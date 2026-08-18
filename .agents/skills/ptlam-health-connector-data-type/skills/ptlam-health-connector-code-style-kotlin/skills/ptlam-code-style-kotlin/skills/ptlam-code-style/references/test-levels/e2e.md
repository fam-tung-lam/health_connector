# End-to-End Testing

Use an end-to-end test for a critical user journey through the composed
application when lower levels cannot establish that the system works together.

## Rules

- Start from a user-visible entry point and assert a user-visible outcome.
- Cover only critical journeys, high-value platform behavior, and failures that
  require the composed application.
- Use the production composition and real controlled subsystems. Replace only
  uncontrollable external systems at their outermost boundary or use an approved
  sandbox.
- Drive the application through stable user-facing semantics, accessibility
  identifiers, or repository-approved stable keys. Avoid implementation
  selectors.
- Create isolated test data and clean it up. Make reruns independent of order
  and previous failures.
- Wait on observable readiness and state changes. Do not use fixed sleeps.
- Keep assertions focused on the journey. Leave exhaustive input combinations
  and edge cases to lower levels.
- Run on each materially different supported platform when the risk is
  platform-specific.

## Exit criteria

- The journey exercises the composed application through its real entry point.
- Failures provide enough context to distinguish product behavior from device,
  environment, or external-service failure.
- The suite remains intentionally small and stable.
