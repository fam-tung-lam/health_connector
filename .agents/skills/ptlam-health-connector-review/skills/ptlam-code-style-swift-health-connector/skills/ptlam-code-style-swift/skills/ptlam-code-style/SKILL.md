---
name: ptlam-code-style
description:
  Hold source and test code to one language-neutral set of conventions for
  source-tree structure, module boundaries, naming, function readability, domain
  modeling, cross-boundary contracts, failure design, documentation, logging,
  and testing. Use when placing or naming a file, setting a public or internal
  boundary, shaping a domain type or its states, promising an interface across a
  process or release boundary, designing a failure or a retry, writing a doc
  comment, emitting a log record, deciding what a test must prove, choosing a
  test level, placing a test or a test double, or planning how a change
  migrates. Use ptlam-modeling-domain instead for business terminology, context
  boundaries, and business process maps. Use as the foundation for a stack
  specialization that adds the mechanics.
---

# PTLam Code Style

Route source and test concerns through one language-neutral standard. This
foundation owns the shared behavior and vocabulary; a stack specialization owns
the mechanics that satisfy them.

## Who decides what

For any mechanic these conventions leave open, take the first source that
answers it:

| Order | Source                                             | Owns                                                                            |
| ----- | -------------------------------------------------- | ------------------------------------------------------------------------------- |
| 1     | Current user instructions                          | Anything the user states for this task                                          |
| 2     | Applicable `AGENTS.md`                             | Project requirements and permitted exceptions                                   |
| 3     | Current feature specification and repository files | Confirmed behavior and constraints; established commands, configuration, layout |
| 4     | The active stack specialization                    | Stack mechanics the repository leaves open                                      |
| 5     | This skill                                         | The conventions below, and the fallbacks they point to                          |

Report an unresolved conflict instead of choosing silently. A feature
specification and repository files are evidence, not another store of
preferences.

When a higher-precedence source explicitly replaces a rule below, name that
replacement in the handoff. Silence or an unrelated local example is not a
replacement.

These conventions serve the people who read the code next. Break one when it
costs a reader more than it returns, then record the reason where the surprise
lives, as [documentation.md](references/documentation.md) requires. An
unexplained deviation is the defect; an explained one is a decision.

## Pick a reference

Read the one reference for the concern you are touching. Each sits one hop away
and owns its rules, its examples, and its caveats.

### Shape and seams

| Concern                                                                    | Reference                                 |
| -------------------------------------------------------------------------- | ----------------------------------------- |
| Placing a file, adding a directory, or shaping a source tree               | [structure.md](references/structure.md)   |
| Deciding what a unit publishes, which way it may depend, or where I/O sits | [boundaries.md](references/boundaries.md) |

### Names and reading

| Concern                                                        | Reference                                       |
| -------------------------------------------------------------- | ----------------------------------------------- |
| Naming a file, type, function, variable, or boolean            | [naming.md](references/naming.md)               |
| Writing or restructuring the body of a function                | [readability.md](references/readability.md)     |
| Writing a doc comment, or explaining why code is the way it is | [documentation.md](references/documentation.md) |

### Data, promises, and failure

| Concern                                                         | Reference                                       |
| --------------------------------------------------------------- | ----------------------------------------------- |
| Shaping a domain type, a persisted record, or a set of states   | [data-modeling.md](references/data-modeling.md) |
| Promising something across a process, team, or release boundary | [contracts.md](references/contracts.md)         |
| Designing a failure, a retry, or a startup check                | [errors.md](references/errors.md)               |
| Emitting a log record, naming a logger, or picking a level      | [logging.md](references/logging.md)             |

### Change over time

| Concern                                                                    | Reference                               |
| -------------------------------------------------------------------------- | --------------------------------------- |
| Abstracting a repeated pattern, migrating a shape, or recording a decision | [evolution.md](references/evolution.md) |

### Tests

| Concern                                                                         | Reference                                                                                                                                                                                                                                                                                       |
| ------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Deciding what a test must prove before any tool is chosen                       | [behavior-contract.md](references/behavior-contract.md)                                                                                                                                                                                                                                         |
| Working test-first after the user explicitly requests TDD or Red-Green-Refactor | [test-first-workflow.md](references/test-first-workflow.md)                                                                                                                                                                                                                                     |
| Choosing one test level for a risk                                              | First [behavior-contract.md](references/behavior-contract.md), then [local-unit.md](references/test-levels/local-unit.md), [local-integration.md](references/test-levels/local-integration.md), [ui-golden.md](references/test-levels/ui-golden.md), or [e2e.md](references/test-levels/e2e.md) |
| Placing a new test file, or relocating a misplaced one                          | [test-placement.md](references/test-placement.md)                                                                                                                                                                                                                                               |
| Introducing, naming, or placing a test double                                   | [test-doubles.md](references/test-doubles.md)                                                                                                                                                                                                                                                   |

## Apply it

1. Resolve the target project, then read the current user instructions and every
   applicable `AGENTS.md` from the project root down to the files in scope.
2. Name the concern in front of you and read its one reference. For every test,
   read the behavior contract before selecting a level, placement, workflow, or
   double.
3. Select the active stack specialization. When none of the available ones
   matches the project, say so rather than inventing a toolchain.
4. Apply the standard, then let the specialization supply the mechanics.
5. Run the project's own formatter, linter, type check, and tests. Report the
   exact commands, their results, and every check you did not run.

When build, test, or run is not one fast command, name that friction in the
handoff. A loop people avoid is a defect in the project, not a fact about it.

A review changes no files. Fixing what a review found needs separate authority.

## Finish

Finish when every touched file satisfies the conventions for its concern, every
open mechanic traces to a named owner in the precedence table, every deliberate
deviation carries its reason, and the handoff never implies that an unrun check
passed.
