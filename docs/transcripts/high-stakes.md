# High stakes

Expensive to reverse, wide blast radius, and the decision constrains everything
built afterwards. The full framework applies: belief separation, confidence with
its basis, the outside view, backcasting, the strongest counterargument, an
experiment, and a written bet file with update criteria.

---

**User:** We're going to split the monolith into services. Starting next
sprint. I mostly want help sequencing it.

**bet-frame:** I will help sequence it, but the sequencing question assumes the
decision, and this is the kind that is very expensive to undo. One pass at the
premise first — if it holds, the sequencing is better grounded for it.

*What is the best way to reduce the pain we are actually feeling, given what we
can afford to change?* Splitting is one answer.

What is the pain?

**User:** Deploys are slow and scary, teams block each other, and the test
suite takes 40 minutes.

**bet-frame:** Three different problems with three different causes, and
service boundaries only reliably address one of them.

**Facts** — please correct any of these: deploys take a long time and fail
sometimes; test suite is 40 minutes; multiple teams commit to one repository.

**Assumptions:** that coupling between teams is *architectural* rather than
organisational or process-based. That splitting reduces deploy risk — it
redistributes it, and adds network failure modes that did not exist before. That
the 40-minute suite is a monolith problem rather than a test-design problem.

**Opinion:** that the monolith is "the bottleneck." Widely held here, and it is
the premise the whole plan rests on.

**Unknown that decides this:** whether teams block each other because of code
coupling or because of release process and review. Those have completely
different fixes and only one of them costs a year.

---

**bet-evaluate:**

**Confidence:** low that splitting addresses the stated pain. Not low that
splitting is *wrong* — low that anyone has established the causal link.

**Outside view:** most monolith decompositions take substantially longer than
planned, and a well-documented share of teams end up with a distributed system
that has the original coupling plus network partitions. The base rate here is
unkind and it is the relevant reference class.

**Stakes:** a year or more of engineering capacity. Opportunity cost is
everything not built. Blast radius is every team and every deploy. Operational
complexity rises permanently and needs skills the team may not have. Cost of
delay is low — the pain is real but chronic, not acute.

**Reversibility:** hard, approaching one-way. Once services own data, going
back is a second migration nobody funds.

**Alternatives:** full decomposition. Extract one service at the seam that
hurts most. Fix deploy pipeline and test suite, change no boundaries. Modular
monolith — enforce boundaries in-process without distributing. Higher-upside
challenger: fix the pipeline *and* extract exactly one service, which tests the
architectural hypothesis at a fraction of the cost.

**Backcasting.** It is 18 months from now and this failed. What happened?

We extracted four services in the first year. Deploys got faster for those four
and slower overall, because a feature now spans three repositories and three
review queues. The test suite is still slow, because it was slow for reasons
that had nothing to do with the monolith. Two engineers who understood the
original system left. Teams still block each other, now across API contracts
that are harder to change than function calls were. We are twelve months in,
cannot go back, and cannot articulate what we bought.

The detectable early signal in that story is not revenue or velocity. It is
*the first extraction taking longer than planned and not making that team
faster*.

**Strongest counterargument to my own recommendation:** waiting has a cost that
compounds. Every month in the monolith adds coupling, and the team that could
have done this cleanly is the team that will have left by the time you decide.
That is a real argument and I do not think it is decisive here — but if the
senior people who know the system are actively leaving, it becomes decisive.

**Size:** low confidence, high downside, hard to reverse → investigate before
committing.

---

**bet-experiment:**

**Deciding uncertainty:** is the blocking architectural or organisational?

**Probe, four weeks, two tracks in parallel:**

1. Extract one service at the most painful seam. Not a spike — a real
   extraction, shipped. It answers what extraction actually costs here, with
   this team, rather than what it costs in a blog post.
2. Instrument the blocking. For four weeks, log every time a team waits on
   another: what they waited for, and whether the cause was code, review,
   release scheduling, or a decision.

**Criteria, set now:**
- Extraction lands within six weeks and that team's deploy frequency improves
  measurably → the architectural hypothesis survives; continue.
- Extraction overruns badly, or lands and changes nothing → the cost is higher
  and the benefit lower than the plan assumes; stop and reassess.
- Blocking log is majority review-and-release rather than code → fix process
  first; the split is not the lever.
- Cost cap: six weeks and one team. Stop at the cap regardless of result.

---

**bet-update:** Written to `~/bets/2026-09-03-monolith-decomposition.md`,
`status: committed`, committed to *the probe* rather than the decomposition.

**Update criteria in the file:**
- *Increase:* extraction lands ≤6 weeks and deploy frequency improves for that
  team → extract the next two.
- *Decrease:* extraction exceeds 8 weeks, or two incidents trace to the new
  network boundary → pause, reassess.
- *Invalidate:* blocking log shows >60% review-and-release causes → the premise
  is wrong; redirect to pipeline and process.
- *Date:* review 2026-10-15 regardless of what has happened.

---

## Why every stage ran

Three things put this at the top: it is close to one-way, the blast radius is
the entire engineering organisation, and the premise was load-bearing and
unexamined. Any one of those would justify the depth; together they make
skipping it negligent.

Backcasting earned its place — it produced a specific failure mechanism and,
more usefully, the early signal that distinguishes that failure from success.
A risk register would have said "migration may take longer than expected."

The counterargument is real and is stated at full strength, including the
condition under which it wins. A counterargument you can dismiss comfortably is
one you have not found yet.

The commitment is to a bounded probe with a cost cap, not to the architecture.
That is what makes a low-confidence, high-downside bet safe to place.
