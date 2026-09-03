#!/bin/sh
# Conformance and drift check for the Better Bets skill pack.
#
# Conformance: every skill under <root>/skills/bet-*/ satisfies the Agent
# Skills specification constraints the pack depends on.
# Drift: the shared bet-protocol block is byte-identical across the authoring
# source and all five embedded copies.
#
# POSIX shell and standard tools only. No package install, no network.
#
# Usage: scripts/check.sh [root]   (root defaults to the repo root)

set -u

ROOT=${1:-$(cd "$(dirname "$0")/.." && pwd)}
SKILLS_DIR="$ROOT/skills"
SHARED_FILE="$ROOT/shared/bet-protocol.md"

START='<!-- shared:bet-protocol start -->'
END='<!-- shared:bet-protocol end -->'

# The sentinels are constants, so escape them for use as sed addresses once
# rather than on every hash.
escape_for_sed() { printf '%s' "$1" | sed 's/[]\/$*.^[]/\\&/g'; }
ESTART=$(escape_for_sed "$START")
EEND=$(escape_for_sed "$END")
SPEC_KEYS=' name description license compatibility metadata allowed-tools '
MAX_NAME=64
MAX_DESC=1024
MAX_BODY=500

# Not named `status`: that is a read-only special variable in zsh.
exit_status=0
fail() { printf 'FAIL  %s\n' "$*" >&2; exit_status=1; }
pass() { printf 'ok    %s\n' "$*"; }

# ---------------------------------------------------------------- conformance

check_skill() {
    dir=$1
    slug=$(basename "$dir")
    file="$dir/SKILL.md"

    [ -f "$file" ] || { fail "$slug: no SKILL.md"; return; }

    if [ "$(head -n 1 "$file")" != "---" ]; then
        fail "$slug: SKILL.md does not open with YAML frontmatter"
        return
    fi

    fm_end=$(awk 'NR>1 && $0=="---" { print NR; exit }' "$file")
    if [ -z "$fm_end" ]; then
        fail "$slug: frontmatter is never closed"
        return
    fi

    fm=$(sed -n "2,$((fm_end - 1))p" "$file")
    body_lines=$(( $(wc -l < "$file") - fm_end ))

    # Only column-zero keys are frontmatter fields. Indented lines are nested
    # values -- a conformant `metadata:` map would be falsely rejected if this
    # matched at any indentation.
    unknown_keys=$(printf '%s\n' "$fm" | grep -E '^[A-Za-z][A-Za-z0-9_-]*:' | sed 's/:.*//' |
        while read -r key; do
            # Leading '(' on each pattern: inside $( ), bash 3.2 ends the
            # substitution at the first unbalanced ')'. POSIX permits it.
            case "$SPEC_KEYS" in
                (*" $key "*) ;;
                (*) printf '%s\n' "$key" ;;
            esac
        done)
    # `for` runs in the current shell, so fail() sets exit_status here. A `while`
    # fed by a pipe would not -- POSIX runs it in a subshell. Keys match
    # [A-Za-z][A-Za-z0-9_-]* so word-splitting is safe.
    for key in $unknown_keys; do
        fail "$slug: frontmatter key \"$key\" is outside the six-field spec whitelist"
    done

    name=$(printf '%s\n' "$fm" | sed -n 's/^name:[[:space:]]*//p' | head -n 1)
    desc=$(printf '%s\n' "$fm" | sed -n 's/^description:[[:space:]]*//p' | head -n 1)
    desc=${desc#\"}
    desc=${desc%\"}

    [ -n "$name" ] || fail "$slug: name is missing"
    if [ -n "$name" ]; then
        printf '%s' "$name" | grep -Eq '^[a-z0-9]+(-[a-z0-9]+)*$' ||
            fail "$slug: name \"$name\" must be lowercase alphanumeric and hyphens, no leading, trailing, or consecutive hyphens"
        [ "${#name}" -le "$MAX_NAME" ] || fail "$slug: name is ${#name} characters, limit is $MAX_NAME"
        [ "$name" = "$slug" ] || fail "$slug: name \"$name\" does not match its parent directory"
    fi

    [ -n "$desc" ] || fail "$slug: description is missing"
    [ "${#desc}" -le "$MAX_DESC" ] || fail "$slug: description is ${#desc} characters, limit is $MAX_DESC"

    [ "$body_lines" -lt "$MAX_BODY" ] ||
        fail "$slug: SKILL.md body is $body_lines lines, limit is $MAX_BODY"

    if [ -d "$dir/references" ]; then
        deep=$(find "$dir/references" -mindepth 2 -type f 2>/dev/null | head -n 1)
        [ -z "$deep" ] || fail "$slug: references/ nests deeper than one level ($deep)"
    fi
}

# ---------------------------------------------------------------------- drift

sentinel_count() {
    # grep -c prints 0 AND exits non-zero on no match, so the fallback has to
    # replace the value rather than append to it.
    [ -f "$2" ] || { printf '0'; return; }
    c=$(grep -Fc -- "$1" "$2" 2>/dev/null) || c=0
    printf '%s' "${c:-0}"
}

block_hash() {
    # Hash only the text between the sentinels, exclusive of the markers.
    sed -n "/$ESTART/,/$EEND/p" "$1" | sed '1d;$d' | cksum | cut -d' ' -f1
}

check_block_present() {
    file=$1; label=$2
    s=$(sentinel_count "$START" "$file")
    e=$(sentinel_count "$END" "$file")
    if [ "$s" -ne 1 ] || [ "$e" -ne 1 ]; then
        fail "$label: shared:bet-protocol sentinels must appear exactly once each (found start=$s end=$e)"
        return 1
    fi
    return 0
}

# ----------------------------------------------------------------------- main

found=0
for dir in "$SKILLS_DIR"/bet-*; do
    [ -d "$dir" ] || continue
    found=$((found + 1))
    check_skill "$dir"
done

if [ "$found" -eq 0 ]; then
    fail "no skills found under $SKILLS_DIR/bet-*"
else
    pass "conformance: checked $found skill(s)"
fi

if [ ! -f "$SHARED_FILE" ]; then
    fail "authoring source $SHARED_FILE is missing"
else
    # "<hash>  <path>" per contributor, recorded once so the failure report
    # does not re-derive what the comparison already computed.
    records=""
    source_ok=0
    copies_ok=0
    if check_block_present "$SHARED_FILE" "shared/bet-protocol.md"; then
        records="$(block_hash "$SHARED_FILE")  $SHARED_FILE"
        source_ok=1
    fi
    for dir in "$SKILLS_DIR"/bet-*; do
        [ -d "$dir" ] || continue
        f="$dir/SKILL.md"
        [ -f "$f" ] || continue
        if check_block_present "$f" "$(basename "$dir")"; then
            records="$records
$(block_hash "$f")  $f"
            copies_ok=$((copies_ok + 1))
        fi
    done
    distinct=$(printf '%s\n' "$records" | grep -v '^$' | awk '{print $1}' | sort -u | wc -l | tr -d ' ')

    # Agreement is only meaningful if everyone expected to agree took part. A
    # file that failed the sentinel check contributed no hash, so judging on
    # `distinct` alone would report agreement among whoever happened to show up.
    if [ "$source_ok" -eq 1 ] && [ "$copies_ok" -eq "$found" ] && [ "$distinct" -eq 1 ]; then
        pass "drift: shared block identical across source and $found copies"
    else
        fail "drift: not verified (source $source_ok/1, copies $copies_ok/$found, distinct hashes $distinct)"
        printf '%s\n' "$records" | grep -v '^$' | sed 's/^/        /' >&2
    fi
fi

[ "$exit_status" -eq 0 ] && printf '\nAll checks passed.\n'
exit "$exit_status"
