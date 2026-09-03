# AI agent adoption: rolling out coding agents

A decision about AI, made with the framework's AI-specific cautions active.

## bet-frame

**Asked:** "Should we roll out coding agents to the whole engineering team?"

**Reframed:** *What is the fastest way to find out whether agents raise this
team's throughput without degrading what we ship?* A blanket rollout is one
option and the least reversible one.

**Facts.** Three engineers use an agent daily, unprompted. Median PR size rose
40% in the last quarter among those three. Review time per PR rose too.

**Assumptions.** The throughput gain is real rather than displaced effort —
larger PRs are not the same as more shipped. Quality holds. Gains transfer to
engineers who have not opted in. Tooling cost scales linearly.

**Opinion.** That the three enthusiasts are "obviously more productive." This
is the belief doing the most work and it has the least behind it.

**Careful here.** The evidence for adoption is being gathered by people who
already chose adoption, and some of the analysis is being done by an agent. A
confident summary from either is not independent evidence.

## bet-evaluate

**Confidence.** Low. Self-selected users, one quarter, a metric — PR size —
that plausibly measures the wrong thing.

**Outside view.** Tooling rollouts show large gains among early adopters that
shrink substantially when extended to people who did not choose them.

**Stakes.** Licence cost, review-capacity load, and a quality risk that shows up
late. Blast radius: everything shipped. Cost of delay is low — nothing breaks by
waiting a quarter.

**Reversibility.** Moderate on licences, hard on habits and on code already
written and merged.

**Alternatives.** Full rollout. Opt-in with support. Structured pilot with a
control group. Higher-upside challenger: pilot *and* fix the review bottleneck
the enthusiasts already exposed, since that constraint binds either way.

**Size.** Low confidence, moderate-to-high downside, mixed reversibility →
pilot before committing.

## bet-experiment

**Deciding uncertainty:** does the gain transfer to non-volunteers, and does
quality hold?

**Probe:** six engineers who have not opted in, six weeks, with the three
existing users as an informal comparison. Measure cycle time from first commit
to merged, defect escape rate, and review time — not PR size, which is the
metric that flattered the original case.

**Criteria.** Cycle time improves and defect escape does not worsen → roll out.
Cycle time flat or review load up sharply → the constraint is review, not
authoring, and a rollout makes it worse.

## bet-update

**Committed:** the six-week pilot. Licences bought monthly, not annually, to
keep the commitment reversible while the answer is unknown.

**Update criteria.** Defect escape up more than 20% → stop immediately.
Review time per PR up more than 50% → fix review before extending. Reassess at
six weeks regardless.

## bet-review

Cycle time improved 18%; defect escape was flat; review time rose 35%.

**Good decision, good outcome** — with a caveat the review surfaced. The pilot
measured what the original case had not, and the original case would have been
approved on PR size, a metric that rose while meaning nothing.

**Belief updated:** for this team, authoring was never the constraint — review
was, and agents push harder on the constraint. Any future tooling case has to
state its effect on review, not just on authoring.
