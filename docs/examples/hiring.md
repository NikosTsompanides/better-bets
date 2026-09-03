# Hiring: the senior backend role

A decision people rarely treat as a bet, and one where resulting does the most
damage.

## bet-frame

**Asked:** "Should we hire a senior backend engineer?"

**Reframed:** *What is the cheapest way to clear the backend bottleneck within
a quarter?* Hiring is one route; contracting, reprioritising, and removing the
work are others.

**Facts.** Backend PRs wait a median of four days for review. Two of five
backend engineers left in six months. The last senior search took five months.

**Assumptions.** The bottleneck is capacity — plausible, but the review latency
could equally be a process problem. A new senior will be productive within two
months. We can compete on compensation.

**Opinion.** That the team is "under-levelled." Held by one person, repeated
until it became a premise.

**Unknown that would change the answer.** Whether the four-day review latency
is capacity or scheduling.

## bet-evaluate

**Confidence.** Low that hiring fixes the stated problem. Nobody has separated
capacity from process.

**Outside view.** Senior hires take longer to source than planned and longer to
become productive than planned. A five-month prior search is the relevant base
rate, not the optimistic one.

**Stakes.** £110k+ and a quarter of attention. Onboarding cost falls on the
people already the bottleneck. Reputational cost of a bad hire is high and
slow. Cost of delay: continued slow shipping.

**Reversibility.** Hard. Exiting a bad hire is expensive, slow, and damaging to
everyone nearby.

**Alternatives.** Hire. Contract for two months. Fix review scheduling first.
Higher-upside challenger: fix scheduling *and* start the search, since the
search takes five months anyway and the two do not conflict.

**Size.** Low confidence, high downside, hard to reverse → investigate, but the
challenger removes the tension because the search's lead time is the constraint.

## bet-experiment

**Deciding uncertainty:** capacity or process.

**Probe:** two weeks of a review rota with named reviewers and a one-day SLA.
Costs nothing but coordination.

**Criteria.** Latency below one day → it was process; reassess the hire on
different grounds. Still above three days → capacity is real.

## bet-update

**Committed:** run the rota, open the search in parallel because five months of
lead time cannot be recovered later.

**Update criteria.** Rota fixes latency → narrow the role or pause the search.
No candidate at final stage by month four → the compensation assumption was
wrong, revisit the band. Review monthly.

## bet-review — fourteen months on

The rota halved latency. The hire was made anyway, five months in, and did not
work out; they left after nine months.

**This is the case the skill exists for.** The outcome was bad. Was the
decision?

Partly. Opening the search in parallel was sound — the lead time was real and
the option cost little. What was *not* sound: after the rota showed the
bottleneck was process, nobody revisited the role. An update criterion fired and
went unread. The failure is not the hire; it is that a written criterion was
never checked.

**Belief updated:** review latency in this team is a scheduling problem before
it is a capacity problem. **Process updated:** criteria with no owner and no
date do not get checked — every criterion now carries both.
