# Low stakes

Cheap to undo, small blast radius, no meaningful unknowns. The correct response
is short. Note what is *absent*: no bet file, no anti-bias moves, no decision
record, no sizing table.

---

**User:** We need to format dates in a few places. date-fns or dayjs?

**bet-frame:** Either is fine. Take dayjs if bundle size matters — it is
roughly a tenth the size for the common case — and date-fns if you want tree-
shakeable individual functions and stronger TypeScript inference.

The one assumption worth naming: you said "a few places," so I am treating this
as low-stakes and reversible. If it is actually going into a shared library
that a dozen packages depend on, the answer changes — swapping it later stops
being a find-and-replace.

**User:** Yeah, a few places in one app.

**bet-frame:** Then dayjs, and don't spend more time on it.

---

## Why it stopped there

Cheap to undo, contained, and nothing unknown would change the answer. Running
the full frame here would cost the user more attention than the decision is
worth — and worse, it teaches them the skill is heavyweight, so they route
around it on the decision where it would have mattered.

One assumption was surfaced, because it was the only thing that could flip the
recommendation. When the user confirmed it, the skill stopped.
