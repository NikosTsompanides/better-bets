# Better Bets

Five [Agent Skills](https://agentskills.io) for making decisions under
uncertainty, based on [Annie Duke's](https://www.amazon.co.uk/stores/Annie-Duke/author/B001K88E4U?ref=ap_rdr&shoppingPortalEnabled=true) [*Thinking in Bets: Making Smarter Decisions When You Don't Have All the Facts*](https://www.amazon.co.uk/Thinking-Bets-Making-Smarter-Decisions/dp/0735216355).

They work in Claude Code, Codex, Cursor, OpenCode, Gemini CLI, and any other
tool that reads the Agent Skills standard. Nothing to build, nothing to
install but a directory copy.

The framework is domain-neutral. It applies to an architecture decision, a
hire, a pricing change, or whether to take the job — the shape of a decision
under uncertainty is the same in all of them.

## The idea

A good decision and a good outcome are different things. You can reason well
and lose; you can be careless and win. If you judge your decisions by how they
turned out, you learn the wrong lesson both times — Duke calls that
**resulting**, and it is why experience so often fails to sharpen judgement.

So these skills do not try to tell you what will happen. They make the
reasoning explicit and durable enough that you can tell, later, whether it was
sound.

> Don't try to eliminate uncertainty. Make better decisions in spite of it.

More in [docs/philosophy.md](docs/philosophy.md).

## The five skills

They follow a decision's life, not the sections of one analysis. Each works on
its own; together they hand off through a single file per bet.


| Skill            | What it does                                                                                                                                                    | When                          |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- |
| `bet-frame`      | Sharpens a vague or solution-shaped question into an answerable one; separates facts from assumptions, inferences, and opinions; names the unknowns that matter | Start here                    |
| `bet-evaluate`   | Confidence with its basis, stakes, blast radius, reversibility, alternatives, and how big a bet this is                                                         | Once framed                   |
| `bet-experiment` | The cheapest test that would actually move you, with criteria set before it runs — or a plain "not worth testing"                                               | When one unknown decides it   |
| `bet-update`     | Commit on the evidence you have, with criteria for what would change your mind; later, revise when it does                                                      | Deciding, or evidence arrived |
| `bet-review`     | Judge the reasoning on what was known at the time, not on how it turned out                                                                                     | Outcome is in                 |


```
frame ──► evaluate ──► experiment ──► update ──► review
   ▲                                               │
   └──────────── beliefs updated ──────────────────┘
```



## Install

```sh
git clone https://github.com/<you>/better-bets.git
cd better-bets

# Codex, Cursor, OpenCode, Gemini CLI
mkdir -p ~/.agents/skills && cp -R skills/bet-* ~/.agents/skills/

# Claude Code — it does not read ~/.agents/skills
mkdir -p ~/.claude/skills && cp -R skills/bet-* ~/.claude/skills/
```

Per-tool paths, plugin and extension install, and which paths are confirmed
against official documentation: [docs/install.md](docs/install.md).

## Using them

Most of the time you say what you are deciding and the right skill activates:

- *"We're thinking about moving off Postgres to DynamoDB."*
- *"I've got two offers and a week to decide."*
- *"Should we hire another designer or use a contractor?"*
- *"That migration we did in March went badly — what should we take from it?"*

Or invoke one directly:

```
/bet-frame       should we split the monolith
/bet-evaluate    how risky is the pricing change
/bet-experiment  cheapest way to find out if customers want this
/bet-update      the pilot came back, here are the numbers
/bet-review      the reorg is six months old, how did we do
```

Under a Claude Code plugin install they are namespaced: `/better-bets:bet-frame`.

**Depth scales with stakes.** A reversible ten-minute call gets a sentence.
A one-way door gets the full treatment. See the three transcripts in
[docs/transcripts/](docs/transcripts/) — same entry skill, same framework,
very different responses.

## Bet files

A bet is one markdown file. Each skill appends a dated section; none rewrites
what an earlier one wrote. That append-only rule is the point: the file records
what you believed *before* you knew the outcome, which is the only thing that
makes an honest review possible later.

Files go to `~/bets/`, or to a `bets/` directory that already exists in your
project. **No skill will create a** `bets/` **directory in a project that does not
have one** — installing this will not scatter files through your repositories.

There is no index. Open bets are a search:

```sh
grep -rl 'status: open' ~/bets/
```

An index would be a second copy of facts that already live in the files, and it
would start lying the first time a bet closed without it being updated.

### Keeping them private

Bet files hold real decisions. `bets/` is gitignored here for that reason.

Git history on them is genuinely useful, though — a commit timestamp proves you
wrote the prediction before you knew the answer. To get privacy and history at
once, give the directory its own repository:

```sh
cd ~/bets && git init
```



## Examples

Full lifecycles across six domains, in [docs/examples/](docs/examples/):
[architecture](docs/examples/software-architecture.md) ·
[prioritisation](docs/examples/product-prioritisation.md) ·
[strategy](docs/examples/business-strategy.md) ·
[hiring](docs/examples/hiring.md) ·
[AI adoption](docs/examples/ai-agent-adoption.md) ·
[personal](docs/examples/personal-decision.md)

## Contributing

```sh
sh scripts/check.sh
```

Conformance and drift, no dependencies. Run it before opening a PR.

Each skill embeds a copy of the shared bet-record protocol, marked by
`<!-- shared:bet-protocol start -->` sentinels. The source of truth is
[shared/bet-protocol.md](shared/bet-protocol.md) — edit there, propagate to all
five, and the drift check will tell you if you missed one. The duplication is
deliberate: the Agent Skills spec keeps each skill self-contained, and a check
that fails loudly beats a build step that installers would have to run.

If you can confirm Windsurf's skills path either way, that row in the matrix is
the one piece of this that is currently a guess.

## Licence

Apache-2.0. The framework is Annie Duke's; **the mistakes in adapting it are mine.**