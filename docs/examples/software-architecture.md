# Software architecture: the event pipeline

Shows the full lifecycle on a decision that looked settled when it arrived.

## bet-frame

**Asked:** "Should we move to Kafka?"

**Reframed:** *What is the best way to handle our expected event volume over
the next 18 months without adding operational load the on-call rota cannot
carry?* Kafka is now one candidate, not the question.

**Facts.** Peak is 40 events/second, measured last week. Two of six engineers
have run Kafka before, neither in production. Eleven job failures in 90 days,
all within four minutes of a deploy.

**Assumptions.** Volume grows with headcount rather than usage — nobody has
checked which. The failures are caused by deploy restarts (strongly indicated,
not proven). "We will need streaming eventually."

**Opinion.** That the current scheduler is "held together with tape." Widely
shared, no evidence attached.

**Unknowns that would change the answer.** Whether volume is heading for 400/s
or staying near 40. Whether the failures have one cause or several.

## bet-evaluate

**Confidence.** Low on the volume projection — it rests on a growth assumption
nobody has tested. Moderate that deploy restarts cause the failures.

**Outside view.** Most teams adopting a streaming platform for volume they do
not yet have end up operating it for volume they never get.

**Stakes.** Kafka is a permanent operational commitment for a team with no
production experience of it. Cost of delay is low: 11 reruns a quarter, absorbed
manually.

**Reversibility.** Hard once producers and consumers are written against it.

**Alternatives.** Managed queue. Fix restart handling only. Do nothing yet.
Higher-upside challenger: fix restarts *and* instrument volume, so the real
decision is made on data in two months.

**Size.** Low confidence, high downside, hard to reverse → investigate before
committing.

## bet-experiment

**Deciding uncertainty:** the volume trajectory.

**Probe:** instrument event volume per tenant and plot against headcount and
usage for six weeks. Half a day of work.

**Criteria.** Above 250/s sustained, or a growth curve tracking usage rather
than headcount → revisit streaming. Below that → managed queue is sufficient.

## bet-update

**Committed:** managed queue for the nightly export; restart handling fixed
separately; volume instrumented.

**Update criteria.** Above 250/s sustained → revisit. More than two incidents
needing queue internals in 60 days → stop migrating. Review 2026-12-01
regardless.

## bet-review — nine months later

Volume reached 55/s. The queue handled it. **Good decision, good outcome** —
and the reasoning drove it, because the instrumentation is what made the
restraint defensible rather than merely lucky.

**Belief updated:** this organisation's event volume tracks usage, not
headcount, and usage growth is slower than the roadmap assumes. Applied to the
next capacity argument.
