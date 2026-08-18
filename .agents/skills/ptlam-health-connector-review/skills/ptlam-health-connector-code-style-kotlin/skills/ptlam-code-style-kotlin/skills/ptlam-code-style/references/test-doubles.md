# Test Doubles

Use a test double only at a justified boundary. Prefer the real collaborator
inside the selected seam when it is fast, deterministic, and safe. When a double
is needed, use the repository-approved mocking dependency and give every
reusable double one nearest common test owner.

## Choose the semantic role

- **Dummy:** satisfies a required parameter but is never used.
- **Stub:** supplies predetermined indirect input.
- **Fake:** provides a simplified working implementation of a boundary.
- **Spy:** records outgoing interactions for later assertions.
- **Mock:** carries predetermined interaction expectations and verifies them.

Name and discuss a double by the role it performs even when one API creates all
roles through a type named `Mock`. Use the simplest role that expresses the
required behavior. Verify an interaction only when that interaction is part of
the observable contract.

## Resolve the mocking tool

- Reuse the repository's approved mocking dependency.
- In a read-only review, report a missing or conflicting dependency without
  changing project files.
- When no dependency exists, recommend one against the project's existing test
  runner and add it only within authorized dependency scope.
- When another mocking library already exists, do not silently add a second one.
  Recommend whether to retain, migrate, or defer, with the material trade-off.
- Resolve implementation mechanics from the repository-installed tool's local
  type declarations, command help, or accepted examples. If none verifies the
  mechanic, report the gap instead of inventing an API. Tool terminology does
  not replace the semantic role, boundary, or placement rules in this reference.

Complete tool selection when one repository-compatible mechanism owns every new
double in scope.

## Place a reusable double at the nearest common scope

Start from the layout resolved by [test-placement.md](test-placement.md).
Placement follows consumer ownership rather than a fixed repository-wide
directory:

| Consumers                       | Where the definition lives                                                               |
| ------------------------------- | ---------------------------------------------------------------------------------------- |
| One test                        | Inside that test                                                                         |
| Several cases in one file       | Inside or beside that file's suite                                                       |
| Several neighboring test files  | The repository-named test-doubles directory in their nearest common test-owned directory |
| Several nested test directories | Their nearest common parent                                                              |

In a separate test-root layout, a level-specific double remains inside that
level. An identical semantic double already reused across levels belongs at the
nearest common capability scope:

```mermaid
treeView-beta
    <test-root>/
        <capability>/
            <test-doubles>/ ## Genuinely shared across levels
            <local-unit-level>/
                <test-doubles>/ ## Local unit only
            <local-integration-level>/
                <test-doubles>/ ## Local integration only
```

In a source-adjacent layout, keep the double beside the nearest common group of
test files:

```mermaid
treeView-beta
    <source-root>/
        <capability>/
            <test-doubles>/ ## Used by neighboring tests
            first_test.<ext>
            second_test.<ext>
```

Use the repository's established spelling, such as `test-doubles` or
`test_doubles`. These examples fix ownership and locality, not vocabulary.

- Keep one reusable semantic double or generation declaration per file unless
  the tool requires another layout.
- Do not create a suite-root double directory speculatively.
- Keep doubles for different levels separate unless the exact same semantic
  definition is already reused across them.
- Let a fixture or hook construct and clean up a reusable double while its
  definition remains at the nearest common scope.
- Keep one-off mocks, patches, and expectations in the test.
- When reuse expands, move the original definition rather than copying it. When
  reuse contracts, move it closer to the remaining consumers when that improves
  locality.
- Remove the old definition and update every import after a move.

Complete placement when each definition has the smallest owner that contains all
real consumers and no broader speculative copy remains.

## Avoid false confidence

- Do not replace internal collaborators merely to assert call counts or order.
- Do not reproduce the production algorithm in conditional setup.
- Keep stubbing specific to the Given phase.
- Prefer fresh doubles per test over shared mutable state and broad resets.
- Fail or report when an unstubbed or default value affects the asserted
  outcome.

The double is valid only when breaking the boundary contract causes the test to
fail while internal refactoring that preserves behavior does not.
