# The decision record

Worked example. Domain is incidental — the shape is the same for a hire, a
migration, or a pricing change.

---

**Decision.** Move scheduled jobs off the in-process scheduler onto a managed
queue, starting with the nightly export.

**Objective.** Stop losing overnight jobs to deploy restarts, without adding
infrastructure the on-call rota cannot support.

**Key facts.** Eleven job failures in the last 90 days, all within four minutes
of a deploy (checked in the incident log). Current volume peaks at 40 jobs a
minute. Two of six engineers have run a managed queue before.

**Key assumptions.** Volume stays within one order of magnitude for a year.
The managed option's failure modes are ones we can debug from its console —
untested. Migrating the remaining jobs later will be about as hard as this one.

**Confidence.** Moderate that this fixes the failures — the cause is well
established. Low on the operational-load estimate, which rests on two people's
prior experience elsewhere and no base rate of our own.

**Open unknowns.** Whether the console is enough to debug a stuck job at 3am.
Accepted because the nightly export is not customer-facing and can be rerun.

**Stakes and reversibility.** Moderate reversibility — a month of rework once
several job types are migrated. Blast radius internal for now.

**Alternatives.** Fix the scheduler's restart handling: cheaper, does not solve
the class of problem. Cron on a separate box: cheapest, adds a machine nobody
owns. Do nothing: eleven failures a quarter, currently absorbed by manual
reruns.

**Update criteria.**
- *Increase:* nightly export runs 30 consecutive days without manual
  intervention → migrate the next two job types.
- *Decrease:* more than two incidents needing queue-internals knowledge to
  resolve in the first 60 days → stop migrating, reassess.
- *Invalidate:* volume exceeds 400 jobs/minute, or the managed option's
  pricing changes materially → revisit the whole approach.
- *Date:* review on 2026-12-01 regardless.

**Recommendation.** Migrate the nightly export only. Hold the rest behind the
30-day criterion.

---

## Notes

The unknowns section says *why it was acceptable to proceed*. Listing an
unknown without that is just anxiety on the record.

The invalidate criterion names a number. "If volume grows a lot" would not
survive contact with a busy quarter.

The date criterion exists because the failure mode here is quiet: if the
migration stalls and nobody notices, no event fires. Only the date surfaces it.
