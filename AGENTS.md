# Health Connector SDK

<!-- PTLAM-SETUP-SKILL:START -->

## AGENTS.override.md has precedence

Read [AGENTS.override.md](AGENTS.override.md). It has precedence over this file.

<!-- PTLAM-SETUP-SKILL:END -->

## Project overview

Health Connector is a Flutter plugin monorepo that provides one API for health
data on Android Health Connect and iOS HealthKit.

### Packages

- `health_connector`: Public Flutter API and platform selection.
- `health_connector_core`: Shared domain models and abstractions.
- `health_connector_hc_android`: Android Health Connect implementation.
- `health_connector_hk_ios`: iOS HealthKit implementation.
- `health_connector_lint`: Shared Dart lint rules.
- `health_connector_logger`: Shared logging utilities.

## Architecture

Use the `ptlam-health-connector-architecture` skill for package boundaries,
public APIs, Pigeon contracts, native layers, and platform limits.

## Development setup

Use the `ptlam-health-connector-setup` skill for toolchains, workspace
bootstrap, and development checks.

## Health data types

Use the `ptlam-health-connector-data-type` skill when adding or extending a
health data type across Dart, Pigeon, Android, and iOS.

## Debugging

Use the `ptlam-health-connector-debug` skill to diagnose runtime,
platform-channel, or platform-specific failures.

## Changeset review

Use the `ptlam-health-connector-review` skill to review a working-tree changeset
without editing it.

## Dart development

Use the `ptlam-health-connector-code-style-dart` skill for Dart source, tests,
analysis, formatting, and documentation conventions.

## Kotlin development

Use the `ptlam-health-connector-code-style-kotlin` skill for Android Kotlin
source, tests, analysis, and formatting conventions.

## Swift development

Use the `ptlam-health-connector-code-style-swift` skill for iOS Swift source,
analysis, formatting, and logging conventions.

## Git workflows

Use the `ptlam-git` skill for commits and worktrees.
