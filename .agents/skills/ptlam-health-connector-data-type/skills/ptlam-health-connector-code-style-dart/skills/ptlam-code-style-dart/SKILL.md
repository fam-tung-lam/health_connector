---
name: ptlam-code-style-dart
description:
  Write, review, and fix Dart library and application code against conventions
  for language mechanics, package layout, the analyzer and formatter toolchain,
  dartdoc comments, and package:test tests. Use when starting or standardizing a
  Dart package, changing Dart code or its analysis options, reviewing
  Dart-specific design, or resolving a dart analyze, dart format, or dart test
  failure. Apply ptlam-code-style first for the standard these mechanics
  satisfy. Use as the foundation for Dart framework and project specializations.
  Do not use for non-Dart code.
---

# PTLam Dart Code Style

Conventions for Dart library and application code: SDK and package resolution,
analyzer and formatter configuration, naming, library layout, data types,
failures, asynchrony, dartdoc, and `package:test`. This skill owns Dart
mechanics only; the foundation owns the standard they satisfy.

## Required skills

### `ptlam-code-style`

**Reason:** Provides the language-neutral conventions and testing doctrine the Dart mechanics satisfy.

**Instructions:** Read and apply ptlam-code-style first.
Let it own precedence; the structure, boundary, naming, readability,
data-modeling, contract, failure, documentation, and logging
standards; the universal behavior contract; test levels; test
placement; and test doubles.
Use this skill only for Dart language, package, and tool mechanics
that satisfy those standards.
This specialization may be stricter than the foundation, never looser.

Read [ptlam-code-style](skills/ptlam-code-style/SKILL.md).

## Before the first edit

1. Resolve the package root, then read every applicable `AGENTS.md` from the
   repository root down to the files in scope.
2. Read `pubspec.yaml`, `pubspec.lock`, `analysis_options.yaml`, CI, and the
   nearest source and tests. Record the SDK constraint, the resolved dependency
   versions, the included lint set, the formatter settings, and the commands CI
   actually runs.
3. Treat `analysis_options.yaml` and `pubspec.lock` as this project's source of
   truth. A rule described here that the checked-in configuration does not
   enable is not enforced; report that gap instead of assuming it.
4. Confirm which SDK answers `dart`. A version manager rebinds it per project,
   so run `dart --version` from the package directory rather than trusting the
   shell's default.
5. Apply the stronger rules to code you add or substantively change. Leave
   unrelated legacy inconsistencies alone.

## Pick a reference

| Concern                                                            | Reference                                                       |
| ------------------------------------------------------------------ | --------------------------------------------------------------- |
| Resolving the SDK, adding a dependency, or reproducing a build     | [toolchain.md](references/toolchain.md)                         |
| Configuring the analyzer or formatter, or suppressing a diagnostic | [analysis-options.md](references/analysis-options.md)           |
| Naming a file or symbol, or settling a formatting difference       | [naming-and-formatting.md](references/naming-and-formatting.md) |
| Publishing a library surface, importing, or splitting a `part`     | [libraries-and-imports.md](references/libraries-and-imports.md) |
| Declaring a type, a constant, or a domain data type                | [types-and-data.md](references/types-and-data.md)               |
| Throwing, catching, or translating a failure                       | [errors.md](references/errors.md)                               |
| Awaiting a `Future`, consuming a `Stream`, or cancelling work      | [async.md](references/async.md)                                 |
| Writing a dartdoc comment or generating API documentation          | [documentation.md](references/documentation.md)                 |
| Writing or running a `package:test` test                           | [testing.md](references/testing.md)                             |

## Apply the mechanics

1. Keep every changed public declaration inside the SDK constraint in
   `pubspec.yaml` and inside what the resolved `pubspec.lock` supplies.
2. Give each changed public declaration an explicit type and a doc comment, and
   keep `dynamic` out of its signature.
3. Await or explicitly hand off every `Future`, and cancel every stream
   subscription its owner opened.
4. Add or update behavioral tests under `test/` in files ending `_test.dart`.
   The runner discovers no other filename.
5. Run checks from narrow to broad, and read each result before widening:

   ```bash
   dart test test/orders_test.dart
   dart analyze lib/orders.dart
   dart format .
   dart analyze
   dart test
   ```

6. When the change touched `pubspec.yaml`, rerun `dart pub get` and commit the
   pubspec with its lockfile wherever the package tracks one.

Inspect the diff after `dart format` or `dart fix --apply`; both rewrite source
in place. Report the exact commands, their results, the analyzer exclusions that
limit your confidence, and every check you did not run.

## Finish

Finish when `dart analyze` reports no new diagnostic in the changed code,
`dart format --output=none --set-exit-if-changed .` reports no difference, the
affected tests pass under the project's own SDK, every remaining suppression
carries its reason, and the handoff names each check you could not run.
