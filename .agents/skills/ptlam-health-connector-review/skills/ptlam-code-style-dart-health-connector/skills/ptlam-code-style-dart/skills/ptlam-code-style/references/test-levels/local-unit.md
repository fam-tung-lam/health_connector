# Local Unit Testing

Use a local unit test for one function, class, state transition, or other small
public behavior whose risk can be established without a real multi-component
runtime.

Local names the isolated test-harness boundary. It does not mean the test runs
only on a developer workstation.

## Rules

- Place the test where [test-placement.md](../test-placement.md) resolves.
- Exercise the unit through its public interface.
- Keep the environment in-process, fast, deterministic, and isolated.
- Use real values and controlled in-memory collaborators where practical.
- Replace external dependencies at their boundary. Do not mock internal
  collaborators merely because they are separate classes.
- Cover meaningful normal, boundary, and failure behavior. Avoid enumerating
  implementation branches without a behavioral reason.
- Assert returned values, exposed state, emitted events, or contractually
  observable outgoing interactions.
- Do not access disk, network, platform UI, or uncontrolled clocks and random
  sources. Move to a local integration test when those real collaborations are
  the risk being tested.
- Keep setup local to the test unless proven reuse justifies a broader fixture.

## Exit criteria

- The test fails when the specified behavior is broken.
- Internal refactoring that preserves behavior does not require rewriting it.
- No higher test level is needed to prove the same risk.
