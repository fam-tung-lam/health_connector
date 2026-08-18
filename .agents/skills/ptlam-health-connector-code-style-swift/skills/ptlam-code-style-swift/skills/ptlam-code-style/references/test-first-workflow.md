# Test-First Workflow

The Red-Green-Refactor operation used only when the user explicitly requests
test-first work, TDD, or Red-Green-Refactor by name. A request for tests or for
local integration testing does not select this workflow.

Work one observable behavior at a time:

1. Write the smallest test that specifies the next behavior.
2. Run it and confirm that it fails for the expected missing behavior.
3. Implement only enough production code to make that test pass.
4. Rerun the focused test and confirm that it passes.
5. Refactor only the code touched by this behavior, then rerun the focused test.

Finish when the selected behavior passes, the refactor preserves it, and every
check required by the surrounding stack specialization has run or been named as
unavailable.
