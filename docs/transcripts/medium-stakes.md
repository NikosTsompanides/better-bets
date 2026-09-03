# Medium stakes

Real rework to undo, genuine unknowns, contained blast radius. Assumptions get
separated, reversibility gets classified, alternatives appear, and one
anti-bias move fires. A bet file is offered, not insisted on.

---

**User:** We want to add rate limiting to the public API. Thinking a token
bucket per API key, 1000 requests an hour.

**bet-frame:** Before the mechanism — what is the rate limiting for? The design
differs depending on whether you are protecting capacity, preventing abuse, or
creating a pricing tier. Those three want different limits in different places.

**User:** Mostly capacity. One customer's batch job took the API down last
month.

**bet-frame:** That reframes it. The decision is *how do we stop one client
exhausting shared capacity*, and per-key rate limiting is one answer among
several.

What we actually know: one incident, one client, caused by a batch job. What we
are assuming: that this generalises — that other clients would do the same, and
that 1000/hour is the right number. Where did 1000 come from?

**User:** Honestly, it felt about right.

**bet-frame:** Then it is an opinion, and it is the number the whole design
hangs on. Worth marking as such rather than letting it become a requirement.

The unknown that would change the answer: is your capacity problem concurrency
or total volume? A batch job doing 200 requests in ten seconds and a client
doing 1000 spread over an hour are very different loads, and a per-hour limit
only catches one of them.

---

**bet-evaluate:** Sizing it.

**Confidence:** low on the limit, moderate that limiting is the right category
of fix.

**Stakes:** getting it wrong in the strict direction breaks legitimate clients
silently and you hear about it through support. Too loose and you have not
fixed anything. Blast radius is every API consumer.

**Reversibility:** moderate. The code is easy to change; the *limit* is not,
because clients build against whatever you publish and tightening it later is a
breaking change even when the code is one line.

**Alternatives:** per-key hourly limits. Concurrency limits per key. Both.
Higher-upside option — ship it in log-only mode first and set the number from
what you observe, rather than from what feels about right.

**One anti-bias check:** the strongest counterargument to rate limiting at all
is that you have one incident from one client, and a targeted conversation with
that customer plus a concurrency cap might solve the actual problem without
imposing a permanent constraint on everyone else.

**Recommendation:** log-only mode for two weeks, then set limits from the
observed distribution. Concurrency cap first, since that is what the incident
actually was.

Want me to write this up as a bet file? Worth it if the limit becomes public,
since you will want the reasoning when someone asks why it is what it is.

**User:** Sure, do that.

---

## Why it went this far and no further

Reversibility was the deciding factor. The code is trivially changeable but the
published limit is not, which makes this less reversible than it first appears —
and that is what earned the sizing pass.

One anti-bias move fired, not the full catalogue. Backcasting did not run: the
downside is bounded and recoverable, and prospective hindsight on a contained,
observable change is ceremony.

The bet file was offered with a reason, and the user chose.
