# Installing Better Bets

The pack is five [Agent Skills](https://agentskills.io). Installing means
putting the five directories under `skills/` where your tool looks for skills.
There is no build step and nothing to compile.

## The short version

```sh
npx skills add NikosTsompanides/better-bets --skill '*'
```

[Vercel Labs' `skills` CLI](https://github.com/vercel-labs/skills) treats
GitHub as the registry and discovers `skills/<name>/SKILL.md` natively, so
there is nothing to register and no manifest beyond what is already here. It
prompts for which agent to install into.

```sh
npx skills add NikosTsompanides/better-bets --list              # see the five before installing
npx skills add NikosTsompanides/better-bets --skill bet-frame   # just one
```

## Installing by hand

Two copies cover every tool whose path this project has confirmed:

```sh
git clone https://github.com/NikosTsompanides/better-bets.git
cd better-bets

# Codex, Cursor, OpenCode, Gemini CLI
mkdir -p ~/.agents/skills && cp -R skills/bet-* ~/.agents/skills/

# Claude Code (does not read ~/.agents/skills)
mkdir -p ~/.claude/skills && cp -R skills/bet-* ~/.claude/skills/
```

Swap `~/` for the project directory to install per-project instead.

## Path matrix

Every row was checked against that tool's own documentation on 2026-09-03. A
row marked **unverified** was not confirmed and may be wrong.

| Tool | User-level | Project-level | Reads `.agents/skills/` | Status |
|---|---|---|---|---|
| [Claude Code](https://code.claude.com/docs/en/skills) | `~/.claude/skills/<name>/SKILL.md` | `.claude/skills/<name>/SKILL.md` | No | Confirmed |
| [Codex](https://learn.chatgpt.com/docs/build-skills) | `~/.agents/skills/` | `.agents/skills/` (cwd up to repo root) | Yes — only path | Confirmed |
| [Cursor](https://cursor.com/docs/context/skills) | `~/.agents/skills/`, `~/.cursor/skills/` | `.agents/skills/`, `.cursor/skills/` | Yes | Confirmed |
| [OpenCode](https://opencode.ai/docs/skills/) | `~/.config/opencode/skills/`, `~/.claude/skills/`, `~/.agents/skills/` | `.opencode/skills/`, `.claude/skills/`, `.agents/skills/` | Yes | Confirmed |
| [Gemini CLI](https://geminicli.com/docs/cli/skills/) | `~/.gemini/skills/`, `~/.agents/skills/` | `.gemini/skills/`, `.agents/skills/` | Yes — alias takes precedence | Confirmed |
| Windsurf | `.windsurf/skills/<name>/SKILL.md` reported | — | Unknown | **Unverified** |

**Windsurf is unverified.** Secondary sources report `.windsurf/skills/`, but
this was not confirmed against Windsurf's own documentation. Treat it as a
guess. If you confirm it either way, a correction is welcome.

`.agents/skills/` is the emerging cross-tool convention and four of the five
confirmed tools read it. Claude Code does not, which is the only reason the
short version above needs two copies rather than one.

## Installing as a plugin

Optional. It gets you a one-command install and, in Claude Code, a
`better-bets:` namespace on each skill.

| Tool | Manifest | Status |
|---|---|---|
| Claude Code | `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json` | Validated with `claude plugin validate .` |
| Gemini CLI | `gemini-extension.json` | Schema confirmed; skills auto-discovered from `skills/` |

**Claude Code**

```
/plugin marketplace add NikosTsompanides/better-bets
/plugin install better-bets@better-bets
```

Skills then appear as `/better-bets:bet-frame` and so on.

**Gemini CLI**

```sh
gemini extensions install https://github.com/NikosTsompanides/better-bets
```

Gemini discovers skills from the extension's `skills/` directory — no manifest
field declares them.

No other plugin or marketplace manifest ships. Cursor and the cross-tool
`.agents/plugins/` convention were considered and left out because their
schemas could not be confirmed against official documentation, and a manifest a
tool reads and rejects is worse than no manifest — the copy-install path above
covers both tools today.

## Where bet files go

Skills resolve the bet directory in this order:

1. A path given in the request.
2. A `bets/` directory that **already exists** in the current project.
3. `~/bets/`.

No skill creates a `bets/` directory in a project that does not already have
one, so installing the pack will not scatter files through your repositories.

To change the default, edit the `~/bets/` line in the bet-record protocol block
inside your installed copies. The pack ships no configuration surface — that
edit is the mechanism.

### Keeping your bets private

Bet files record real decisions — hiring calls, strategy, personal choices.
This repository ignores `bets/` for that reason.

Git history on bet files is worth having: a commit timestamp proves you wrote a
prediction *before* you knew the outcome, which is the whole point of keeping
them. To get both, give the directory its own repository:

```sh
cd ~/bets && git init
```

A nested repository inside an ignored directory works cleanly, and nothing
leaves your machine.

## Working on the pack itself

This repository does **not** commit an installed copy of its own skills into
`.claude/skills/`. A committed copy would duplicate `skills/` with nothing
asserting the two stay in step — the drift check covers the shared protocol
block, not whole skills — and it would put a tool-specific directory in a repo
that is deliberately tool-neutral.

To dogfood while working on the pack, symlink instead of copying, so there is
only ever one version:

```sh
mkdir -p .claude/skills
for d in skills/bet-*; do ln -sfn "../../$d" ".claude/skills/$(basename "$d")"; done
```

`.claude/` is not ignored, so remove the symlinks before committing, or add
them to your own global gitignore.

## Verifying an install

```sh
sh scripts/check.sh
```

Conformance and drift, no dependencies. Optionally cross-check against the
reference implementation of the spec:

```sh
uvx skills-ref validate skills/bet-frame
```

`skills-ref` is alpha, needs Python 3.11+, and is not required —
`scripts/check.sh` is the gate and runs anywhere with a POSIX shell. If
`skills-ref` disagrees with it, investigate rather than assuming either is
right.
