# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Package Overview

`health_connector_hk_ios` is the iOS platform implementation for the Health Connector plugin (Dart + Pigeon).
It provides integration with Apple's HealthKit framework and is part of a monorepo managed by Melos.

For native Swift/HealthKit details, see the [iOS native CLAUDE.md](packages/health_connector_hk_ios/ios/CLAUDE.md).

## Directory Structure

```text
lib/
└── src/                  # Dart client, mappers, pigeon *.g.dart
ios/                       # Native Swift (see ios/CLAUDE.md)
pigeon/                    # Pigeon API definition and generated inputs
test/                      # Dart unit tests (test/unit_tests/)
example/                   # Example Flutter app
```

## Essential Commands

Run these from the **monorepo root** (`health_connector/`):

```bash
# Run Dart tests for this package
fvm flutter test packages/health_connector_hk_ios/test/

# Run a single test file
fvm flutter test packages/health_connector_hk_ios/test/unit_tests/src/mappers/health_record_mappers/steps_record_mapper_test.dart

# Dart analysis with fatal warnings
melos run analyze:dart:strict

# Regenerate Pigeon code after modifying pigeon/health_connector_hk_ios_api.dart
melos run pigeon
```

Run from **this package directory**:

```bash
fvm flutter test                     # All Dart tests
fvm flutter test test/unit_tests/... # Specific test
```

## Architecture

### Dart Layer (`lib/src/`)

- **`health_connector_hk_client.dart`**: Main platform client implementing `HealthConnectorPlatformClient`
  from `health_connector_core`. Acts as a bridge to native code via Pigeon.
- **`pigeon/health_connector_hk_ios_api.g.dart`**: Generated Pigeon code (do not edit directly).
- **`mappers/`**: Convert between domain models (`health_connector_core`) and Pigeon DTOs.

### Key Patterns

1. **Pigeon Type-Safe Channels**: All Dart-Swift communication uses Pigeon-generated DTOs (classes ending in
   `Dto`). The API contract is defined in `pigeon/health_connector_hk_ios_api.dart`.

2. **Mapper Convention**: Mappers use extension methods (e.g., `toDto()`, `toDomain()`) for bidirectional conversion.

## Code Generation

After modifying `pigeon/health_connector_hk_ios_api.dart`:

```bash
melos run pigeon  # Regenerates *.g.dart and *.g.swift files
```

Generated files are excluded from linting.

## Testing

- Dart tests use `mocktail` for mocking and `parameterized_test` for data-driven tests.
- Tests are in `test/unit_tests/`.
- Mock the Pigeon API via `HealthConnectorHKClient.platformClient` setter.
