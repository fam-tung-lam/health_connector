---
name: ptlam-health-connector-review
description:
  Review one Health Connector SDK working-tree changeset and report prioritized
  correctness, architecture, public API, cross-platform, generated-code,
  language-convention, test, documentation, and release gaps without editing it.
  Use when asked to review local changes, perform a pre-PR self-review, judge
  whether a change is complete, or identify what could break. Do not use for
  fixing findings or diagnosing one failing run.
---

# PTLam Health Connector Review

Review one working-tree changeset and return a prioritized findings report. Keep
the review read-only. Do not edit files, regenerate Pigeon output, run a
formatter in write mode, or offer fixes until the user asks for them.

## Required skills

### `ptlam-health-connector-architecture`

**Reason:** Provides the repository boundaries and cross-platform contracts the review must protect.

**Instructions:** Read and apply ptlam-health-connector-architecture first.
Let it own package direction, public and internal surfaces, Pigeon
ownership, native layers, failure boundaries, concurrency, and
platform limits.
Use this skill to judge the diff against that architecture.

Read [ptlam-health-connector-architecture](skills/ptlam-health-connector-architecture/SKILL.md).

### `ptlam-health-connector-code-style-dart`

**Reason:** Provides Health Connector Dart source, analyzer, documentation, and test conventions for changed Dart files.

**Instructions:** Apply ptlam-health-connector-code-style-dart to changed Dart, YAML,
and Dart-test files.
Let it own project-specific Dart writing and check conventions.
Report violations here without copying its rules into this skill.

Read [ptlam-health-connector-code-style-dart](skills/ptlam-health-connector-code-style-dart/SKILL.md).

### `ptlam-health-connector-code-style-kotlin`

**Reason:** Provides Health Connector Kotlin source, ktlint, detekt, and unit-test conventions for changed Android files.

**Instructions:** Apply ptlam-health-connector-code-style-kotlin to changed Kotlin,
Gradle, ktlint, detekt, and Kotlin-test files.
Let it own project-specific Kotlin writing and check conventions.
Report violations here without copying its rules into this skill.

Read [ptlam-health-connector-code-style-kotlin](skills/ptlam-health-connector-code-style-kotlin/SKILL.md).

### `ptlam-health-connector-code-style-swift`

**Reason:** Provides Health Connector Swift source, SwiftLint, SwiftFormat, and native logging conventions for changed iOS files.

**Instructions:** Apply ptlam-health-connector-code-style-swift to changed Swift,
SwiftPM, SwiftLint, and SwiftFormat files.
Let it own project-specific Swift writing and check conventions.
Report violations here without copying its rules into this skill.

Read [ptlam-health-connector-code-style-swift](skills/ptlam-health-connector-code-style-swift/SKILL.md).

## Resolve the review surface

1. Read repository instructions, then run `git status --short`, `git diff`, and
   `git diff --staged`. Name the exact added, changed, deleted, and generated
   files. Done when staged and unstaged scopes cannot be confused.
2. Read each changed file with enough surrounding source to judge behavior.
   Treat committed configuration and code as authoritative over `CLAUDE.md`.
3. Identify every affected package, language, public library, Pigeon contract,
   native layer, platform, test suite, document, and changelog.

## Review the change

### Correctness and failure behavior

- Check validation, empty and boundary inputs, paging, timestamps, units,
  identifiers, platform availability, and capability checks.
- Trace exceptions through native translation, Pigeon error DTOs, Dart mapping,
  and the public exception type. Preserve cancellation and completion behavior.
- Check that logs and error details contain no health values, identifiers,
  user-owned dates, or device names.

### Architecture and compatibility

- Keep package dependency direction and layer ownership intact.
- Treat public Dart exports, `@since` history, data-type ids, Pigeon DTOs,
  error-code strings, and plugin methods as release boundaries.
- Check Android handler registration and capabilities, iOS registration and
  availability gates, and every supported/unsupported platform branch.
- Flag hand-edited generated files. Compare each Pigeon source change with all
  expected generated outputs and the Swift post-processor.

### Language conventions

Apply the loaded project language guidance only to changed files in that
language. Report the violated rule and smallest correction; do not repeat the
whole convention.

### Evidence and release impact

- Require focused tests for changed Dart behavior and Kotlin behavior.
- State plainly that Dart platform tests do not execute native code and that the
  Swift package currently lacks an effective native test target.
- Check public dartdoc, platform limitations, examples, migration guidance,
  package changelogs, and semantic-version impact where behavior is public.
- Compare intended verification with the Melos scripts and relevant CI workflow.

Run check-mode analysis or tests only when the user authorizes their local build
artifacts. Never run `melos run pigeon`, `melos run format`, baseline
generation, or another rewriting command during review.

## Report findings

Order findings by severity. Each finding names the severity, file and line,
observable impact, evidence, and smallest correction.

| Severity | Use for                                                                                                          |
| -------- | ---------------------------------------------------------------------------------------------------------------- |
| Critical | Data corruption, crash, privacy or security exposure, broken public contract, or guaranteed runtime failure      |
| Major    | Incorrect platform behavior, missing registration or mapping, race, error loss, or architectural boundary breach |
| Minor    | Maintainability or project-convention defect that can safely follow the functional corrections                   |
| Coverage | Missing tests, native evidence, documentation, migration notes, changelog, or release proof                      |

Do not report a category with no finding. If no defect survives review, say so
and list the files, platforms, and checks that were not examined or run.

Finish after the report. Wait for a separate request before changing anything.
