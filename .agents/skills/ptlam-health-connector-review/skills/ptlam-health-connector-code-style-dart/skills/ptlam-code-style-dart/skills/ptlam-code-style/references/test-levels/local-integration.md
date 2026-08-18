# Local Integration Testing

Use a local integration test when the risk lies in collaboration between real
components, adapters, processes, storage, or framework services inside a chosen
test-harness boundary.

Local names the harness boundary, not where the test command runs. Classify by
the exercised boundary rather than the framework's suite name. A suite called
`integration` is end-to-end under this skill when it starts the composed
application and drives a user journey through its real entry point.

## Rules

- Place the test where [test-placement.md](../test-placement.md) resolves.
- Define the local integration boundary and the behavior visible through its
  public entry point.
- Run the real collaborators whose compatibility is the subject of the test.
- Replace only dependencies outside the chosen boundary, especially
  uncontrollable remote services needed for offline determinism.
- Exercise locally controlled filesystem, database, subprocess, package, or
  platform adapters for real when their integration is the risk under test.
- Use isolated data and resources. Create, identify, and clean them up within
  the test lifecycle.
- Assert behavior through the public boundary rather than querying internals as
  a side channel.
- Keep the suite smaller than the local unit suite and cover collaboration
  failures rather than repeating local unit cases.
- Prefer deterministic readiness signals over sleeps and arbitrary delays.

## Test doubles

Keep local integration doubles separate from local unit doubles even when they
represent a similar external dependency. A local unit double isolates the unit;
a local integration double excludes something outside the integration boundary.
Share one definition above both level directories only when the same semantic
double is actually reused at both levels, not merely because the doubles have
similar names.

## Exit criteria

- The real collaborators under test were exercised.
- A failure identifies a broken local integration contract rather than an
  unrelated external outage.
- The same risk is not already fully established at a cheaper level.
