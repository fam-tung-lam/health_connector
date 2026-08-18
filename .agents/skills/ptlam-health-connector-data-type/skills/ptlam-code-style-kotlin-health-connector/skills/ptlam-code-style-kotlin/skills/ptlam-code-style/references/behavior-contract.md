# Universal Behavior Contract

What a test must prove, independently of the language or the test runner.

No repository convention, specialization, or tool document may remove these
rules. They may only refine the mechanics underneath them.

## Every test must

- verify behavior through a public interface, not through private methods,
  internal calls, or incidental structure;
- use Given-When-Then, through the tool's native API where one exists and
  otherwise through explicit `Given`, `When`, and `Then` comments;
- read as a behavior specification in the repository's domain language;
- derive its expected values from a specification, a worked example, or a known
  literal, never from the production algorithm;
- cover one coherent behavior, using several assertions only when they jointly
  describe that one outcome;
- prefer real collaborators inside the selected seam, and replace only a
  justified boundary;
- stay deterministic and isolated by controlling time, randomness, external
  services, and mutable global state at their boundaries; and
- clean up every resource it creates.

## Name a test after the behavior

A test name states what the caller observes, not which internal mechanism runs.
`empty queue returns none` survives a refactor; `calls _drain once` does not.

## Choosing between levels

Use a higher level only for a risk the lower one cannot establish.

Never repeat the same assertion across levels. Never let a coverage percentage
stand in for behavior-based design.

## Finish

Finish when every planned test states one observable risk and satisfies this
contract, before any stack-specific mechanic is chosen.
