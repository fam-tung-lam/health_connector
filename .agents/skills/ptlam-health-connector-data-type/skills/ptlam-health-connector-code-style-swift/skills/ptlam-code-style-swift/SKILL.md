---
name: ptlam-code-style-swift
description:
  Write, review, and fix Swift library and application code against conventions
  for language mechanics, optionals, error handling, structured concurrency and
  actor isolation, the Swift Package Manager, SwiftFormat, and SwiftLint
  toolchain, documentation comments, and tests. Use when starting or
  standardizing a Swift package, changing Swift code or its lint and format
  configuration, reviewing Swift-specific design, or resolving a swift build,
  SwiftLint, or SwiftFormat failure. Apply ptlam-code-style first for the
  standard these mechanics satisfy. Use as the foundation for Swift platform and
  project specializations. Do not use for Objective-C.
---

# PTLam Swift Code Style

Conventions for Swift library and application code: the package manifest, the
SwiftFormat and SwiftLint toolchain, naming and access control, optionals, type
choice, failure design, structured concurrency, documentation comments, and
tests. This skill owns Swift mechanics only; the foundation owns the standard
they satisfy.

## Required skills

### `ptlam-code-style`

**Reason:** Provides the language-neutral conventions and testing doctrine the Swift mechanics satisfy.

**Instructions:** Read and apply ptlam-code-style first.
Let it own precedence; the structure, boundary, naming, readability,
data-modeling, contract, failure, documentation, and logging
standards; the universal behavior contract; test levels; test
placement; and test doubles.
Use this skill only for Swift language, package, and tool mechanics
that satisfy those standards.
This specialization may be stricter than the foundation, never looser.

Read [ptlam-code-style](skills/ptlam-code-style/SKILL.md).

## Before the first edit

1. Resolve the package root and read every applicable `AGENTS.md` from the
   repository root down to the files in scope.
2. Read `Package.swift`, `.swift-version`, `.swiftformat`, `.swiftlint.yml`,
   `Package.resolved`, and the CI or workspace scripts. Record the tools
   version, the language mode, the platform floors, the targets, and the real
   format, lint, build, and test commands.
3. Treat the checked-in configuration and the commands CI runs as the mechanic.
   An installed SwiftLint that no command invokes is not a gate.
4. Apply stronger new-code rules to code you add or substantively change. Leave
   unrelated legacy inconsistencies alone.

For a new Swift package, use Swift Package Manager, the Swift 6 language mode,
SwiftFormat for formatting, SwiftLint for linting, and Swift Testing for tests.
In an existing project, keep its explicit working toolchain until replacing it
is part of the task.

## Pick a reference

| Concern                                                            | Reference                                               |
| ------------------------------------------------------------------ | ------------------------------------------------------- |
| Creating or changing the manifest, a target, or a dependency       | [package-manifest.md](references/package-manifest.md)   |
| Configuring SwiftFormat, or resolving a formatting failure         | [swiftformat.md](references/swiftformat.md)             |
| Configuring SwiftLint, reading its baseline, or suppressing a rule | [swiftlint.md](references/swiftlint.md)                 |
| Naming a Swift declaration, or choosing its access level           | [naming-and-access.md](references/naming-and-access.md) |
| Choosing struct, class, enum, or actor, or designing a protocol    | [types.md](references/types.md)                         |
| Reading, binding, or defaulting an optional value                  | [optionals.md](references/optionals.md)                 |
| Throwing, catching, or converting a Swift error                    | [errors.md](references/errors.md)                       |
| Writing async code, isolating state, or conforming to `Sendable`   | [concurrency.md](references/concurrency.md)             |
| Writing a `///` documentation comment                              | [documentation.md](references/documentation.md)         |
| Writing a Swift test, or declaring a test target                   | [testing.md](references/testing.md)                     |

## Apply the mechanics

1. Keep each changed declaration at the narrowest access level its real
   consumers allow, and mark a class `final` unless something subclasses it.
2. Remove every force-unwrap, force-cast, and implicitly unwrapped optional from
   the code you touch, and bind the value with `guard let` instead.
3. Give each changed throwing function a named `Error` type whose cases a caller
   can act on.
4. Keep mutable shared state inside an `actor` or on `@MainActor`, and give
   every type that crosses an isolation boundary a real `Sendable` conformance.
5. Write a `///` comment on every declaration the package publishes.
6. Add or update behavioral tests in the package's existing test target.
7. Run the checks from narrow to broad, stopping at the first failure.

```shell
swiftformat Sources/Changed.swift
swiftlint lint --strict --quiet Sources/Changed.swift
swift build
swift test --filter ChangedBehavior
swiftformat --lint .
swiftlint lint --strict
swift test
```

`swiftformat` without `--lint`, and `swiftlint --fix`, rewrite files in place.
Read the resulting diff before continuing: reflowing a declaration moves the
line a `// swiftlint:disable:next` comment applies to.

## Finish

Finish when the package builds under its declared language mode, SwiftFormat
reports no unformatted file, SwiftLint passes under `--strict` with every
remaining suppression carrying its reason, and the affected tests pass under the
project's own commands.
