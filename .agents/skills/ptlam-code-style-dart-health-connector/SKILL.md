---
name: ptlam-code-style-dart-health-connector
description:
  Write, review, and fix Dart source and tests in the Health Connector SDK
  against its analyzer rules, formatter contract, imports, visibility,
  documentation shape, structured logging syntax, and package-specific test
  layout. Use when editing Dart code, changing the shared lint package, or
  fixing a Dart format, analysis, documentation, or test-convention failure.
  Apply ptlam-code-style-dart first. Do not use for workspace architecture,
  public API design, Pigeon ownership, platform support, or an end-to-end health
  data type change.
---

# PTLam Health Connector Dart Code Style

Write, review, or fix Dart source and tests in the Health Connector SDK. This
skill owns only repository-specific Dart expression: analyzer and formatter
configuration, imports, declaration shape, documentation, structured logging
calls, and test layout.

Workspace architecture, public API decisions, platform support, Pigeon
ownership, domain capabilities, and end-to-end feature completeness are outside
this skill.

## Required skills

### `ptlam-code-style-dart`

**Reason:** Provides the Dart language, package, analyzer, formatter, dartdoc, and test mechanics this repository's conventions build on.

**Instructions:** Read and apply ptlam-code-style-dart first; it loads ptlam-code-style
as its own foundation.
Let Dart own the SDK and toolchain, naming, formatting, imports, const
and final, visibility, package layout, dartdoc, and package:test
mechanics.
Use this skill only for Health Connector Dart source, analyzer,
formatter, documentation, logging-call, and test conventions.
This specialization may be stricter than Dart, never looser.

Read [ptlam-code-style-dart](skills/ptlam-code-style-dart/SKILL.md).

## Apply the project conventions

1. Locate the changed Dart file and its package `analysis_options.yaml`. Confirm
   whether it is handwritten source, a part file, a test, or generated output.
   Leave generated `*.g.dart` untouched.
2. Apply [source conventions](references/source-conventions.md) to handwritten
   code and [analyzer and formatter](references/analyzer-and-formatter.md) to
   configuration or check failures.
3. Read [documentation](references/documentation.md) for a public declaration or
   dartdoc failure. Read [tests](references/tests.md) for test placement,
   imports, doubles, fixtures, or structure.
4. Make the smallest language-level change that satisfies the loaded convention.
   Do not redesign a package or cross-platform contract to resolve a style
   finding.
5. Run focused tests, then the repository checks from the monorepo root:

   ```bash
   melos run format:dart:check
   melos run analyze:dart:strict
   melos run test:dart
   ```

Run `melos run doc:generate` when public documentation changed.

## Finish

Finish when handwritten Dart follows the project convention, generated files
remain generator-owned, applicable checks pass, and the handoff names every
check not run. A functional or architecture defect discovered along the way is
reported to its owner rather than absorbed into this skill.
