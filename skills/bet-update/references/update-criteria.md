# Writing update criteria that fire

A criterion works if someone who has forgotten the reasoning can tell whether
it has happened.

## The test

Read it back and ask: *what would I observe?* If the answer is a feeling, it is
not a criterion.

| Does not fire | Fires |
|---|---|
| If it does not work out | If p95 is still above 400ms four weeks after the cache ships |
| If adoption is disappointing | If fewer than 15 of the 60 pilot accounts have run it twice by 1 December |
| If the hire is not working | If by day 60 they have not shipped independently to production |
| If the market shifts | If either of the two named competitors ships this and prices below us |
| If it gets too expensive | If monthly spend passes £4k |

## Three directions, one date

Cover increase, decrease, and invalidate — the first two calibrate, the third
changes course. Most records have only the pessimistic one, which turns the
review into a hunt for problems rather than an honest reassessment.

Then give at least one criterion a date, unconditionally. Event-based criteria
share a blind spot: they cannot fire when the failure mode is that nothing
happens. A project that quietly stalls trips no threshold. The calendar is the
only thing that catches it.

## Thresholds, not directions

"If latency gets worse" leaves the argument for later, at exactly the moment
everyone is invested. "If p95 exceeds 400ms" was agreed while nobody minded.
Pick the number when it is cheap to pick.

If you genuinely cannot name a threshold, say so and name the observation you
would make instead — "if two more customers raise it unprompted" is a real
criterion even without a metric behind it.

## Rewrite them when they fail

A criterion that turned out to be unrecognisable, or that fired on something
irrelevant, was a bad criterion. Say so in the revision and replace it. The
criteria are part of the bet, and they are revisable like anything else — the
one thing you may not do is quietly drop one because it fired.
