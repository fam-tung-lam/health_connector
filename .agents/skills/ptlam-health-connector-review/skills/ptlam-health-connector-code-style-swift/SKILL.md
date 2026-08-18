---
name: ptlam-health-connector-code-style-swift
description:
  Write, review, and fix Swift source in Health Connector's iOS package against
  its access, declaration and extension shape, structured logging syntax,
  SwiftLint baseline, and SwiftFormat configuration. Use when editing Swift code
  or fixing a Swift analysis, formatting, or native logging convention failure.
  Apply ptlam-code-style-swift first. Do not use for iOS architecture, HealthKit
  behavior, Pigeon threading, failure translation, or end-to-end handler
  registration.
---

# PTLam Health Connector Code Style Swift

Write, review, or fix handwritten Swift under
`packages/health_connector_hk_ios/ios/`. This skill owns only
repository-specific Swift expression: access and declaration shape, mapper and
extension naming, structured logging calls, SwiftLint, and SwiftFormat.

iOS architecture, HealthKit behavior, Pigeon completion threading, failure
translation, handler capabilities, and end-to-end registration are outside this
skill.

## Required skills

### `ptlam-code-style-swift`

**Reason:** Provides the Swift language, concurrency, package, lint, format, and documentation mechanics this repository's conventions build on.

**Instructions:** Read and apply ptlam-code-style-swift first; it loads ptlam-code-style
as its own foundation.
Let Swift own the language, optionals, error handling, structured
concurrency, Swift Package Manager, SwiftLint, SwiftFormat, and
documentation-comment mechanics.
Use this skill only for Health Connector Swift source, access,
declaration, logging-call, SwiftLint, and SwiftFormat conventions.
This specialization may be stricter than Swift, never looser.

Read [ptlam-code-style-swift](skills/ptlam-code-style-swift/SKILL.md).

## Apply the project conventions

1. Confirm the file is handwritten Swift under the package source tree. Leave
   generated `*.g.swift` untouched.
2. Apply [source conventions](references/source-conventions.md). Read
   [Swift checks](references/checks.md) for configuration or a check failure and
   [native logging](references/logging.md) for a log call.
3. Make the smallest language-level correction. Do not move behavior between
   plugin, client, service, registry, handler, or mapper layers to resolve a
   style finding.
4. Run from the monorepo root:

   ```bash
   melos run format:swift:check
   melos run analyze:swift
   ```

Use `melos run format:swift` only when rewriting files is authorized. Do not
claim native test coverage from these checks; they prove formatting and static
analysis only.

## Finish

Finish when handwritten Swift follows the configured convention, generated
output remains generator-owned, the SwiftLint baseline is unchanged unless its
regeneration was separately requested, applicable checks pass, and the handoff
names every unavailable check.
