# Why bets

Annie Duke's *Thinking in Bets* makes one argument that this pack is built on:
the quality of a decision and the quality of its outcome are different things,
and confusing them is why experience so often fails to improve judgement.

You can reason carefully, weigh what you know against what you are guessing,
pick well — and still lose, because the world had a say. You can also be
careless and win. If you grade yourself on results, you learn the wrong lesson
in both cases. Duke calls this **resulting**, and it is self-reinforcing: the
record you would need to correct it is the one nobody wrote down.

So the aim is not to be right more often. It is to decide well more often, and
to be able to tell the difference afterwards.

## Uncertainty is the condition, not the problem

Every decision that matters is made without enough information. Waiting for
enough is itself a decision, usually a bad one, and it is the one that feels
responsible.

The move is not to eliminate uncertainty but to work honestly inside it: say
what you actually know, mark what you are assuming, notice which unknown is
doing the deciding, and buy down that one uncertainty if it is cheap enough to
be worth buying.

> **Don't try to eliminate uncertainty. Make better decisions in spite of it.**

## Size the bet, not the analysis

Rigour is a cost. Applied to a decision you could reverse in ten minutes, it is
a waste that also teaches people to route around the practice when it matters.

Three things set how much a decision deserves: how bad it is if you are wrong,
how hard it is to undo, and how far the consequences reach. A reversible
decision with a small blast radius should be made quickly and watched. A
one-way door with company-wide consequences deserves everything.

Most of the value in this pack is in telling those apart.

## Write it down before you know

The bet file is the whole mechanism. Not because writing is virtuous, but
because a decision recorded *before* the outcome is the only account of your
reasoning that the outcome has not rewritten.

Two things go in it that nothing else captures: the confidence you actually had,
and what you said would change your mind. The second is what makes a decision
revisable — without it, new evidence gets weighed by whoever is already invested
in the answer.

## What AI changes, and what it doesn't

> **AI doesn't eliminate uncertainty. It makes many forms of uncertainty
> cheaper to explore.**

That is a real shift. Prototypes that cost a week cost an afternoon.
Alternatives that nobody had time to consider can be generated and discarded.
The outside view is a search away. When exploring uncertainty gets cheaper, the
right amount of exploring goes up.

But agents introduce failure modes of their own, and they are subtle because
they arrive dressed as competence:

- **Fluency reads as grounding.** A confident, well-organised answer and a
  well-founded one look identical. Presentation quality and evidence quality are
  independent variables.
- **Agreement isn't confirmation.** An agent that agrees has continued your
  framing, which is what it was trained to do. Two agreeing agents are not two
  witnesses.
- **Plausible detail feels retrieved.** A version number, a config flag, a
  market statistic — generated specifics carry the texture of facts. Unless
  something was actually checked, it is an assumption in a confident voice.
- **Solution momentum.** Ask an agent how to build something and it will build
  it well. It will not spontaneously ask whether that is the thing to build.

Each skill in this pack names its own version of these, because the general
warning does not survive contact with a specific task.

## Not a scoring system

There is a sizing table in `bet-evaluate`. It is a reasoning aid, deliberately
not arithmetic. Turning judgement into a formula produces a number that hides
the reasoning it replaced, and a number is much harder to argue with than a
stated assumption — which is exactly the wrong property.

The pack does not predict outcomes and cannot tell you which option wins. It
improves the process and leaves the uncertainty where it is.
