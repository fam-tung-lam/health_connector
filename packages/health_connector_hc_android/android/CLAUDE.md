# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the native Kotlin/Android implementation of the Health Connector plugin. It wraps Android's Health Connect SDK
and exposes it to Flutter via Pigeon-generated platform channels.

## Directory Structure

```text
src/
├── main/kotlin/com/phamtunglam/health_connector_hc_android/
│   ├── HealthConnectorHCAndroidPlugin.kt
│   ├── HealthConnectorClient.kt
│   ├── handlers/           # Handler interfaces + health_record_handlers/
│   ├── services/           # Permission, feature, manifest, data sync
│   ├── mappers/            # health_record_mappers/, metadata_mappers/
│   ├── pigeon/             # *.g.kt (generated)
│   └── exceptions/
└── test/kotlin/            # JUnit 5 + MockK + Kotest + Robolectric
gradle/                     # Wrapper and properties
```

## Essential Commands

From this directory (`android/`):

```bash
# Run all unit tests
melos test:kotlin # IMPORTANT: Don't use ./gradlew to run tests

# Code quality
./gradlew ktlintCheck      # Check Kotlin formatting
./gradlew ktlintFormat     # Auto-fix formatting
./gradlew detekt           # Static analysis (uses detekt.yml config)
./gradlew detektBaseline   # Update baseline for existing issues
./gradlew lintAll          # Run both ktlint and detekt

# Build
./gradlew build
./gradlew assembleDebug
```

## Architecture

### Entry Point

`HealthConnectorHCAndroidPlugin.kt` - Implements `FlutterPlugin`, `ActivityAware`, and the Pigeon-generated
`HealthConnectorHCAndroidApi`. Routes all Dart calls through coroutine scope with `SupervisorJob`.

### Client Layer

`HealthConnectorClient.kt` - Internal facade wrapping `HealthConnectClient`. Coordinates handlers and services,
validates operations, and delegates to appropriate components.

### Handler Pattern

Each Health Connect record type has a dedicated handler implementing capability interfaces:

```text
HealthRecordHandler (base)
├── ReadableHealthRecordHandler     # readRecord(), readRecords()
├── WritableHealthRecordHandler     # writeRecord()
├── UpdatableHealthRecordHandler    # updateRecord()
├── DeletableHealthRecordHandler    # deleteRecords(), deleteRecordsByTimeRange()
└── AggregatableHealthRecordHandler # aggregate()
```

Handlers are registered in `HealthRecordHandlerRegistry` and looked up by `HealthDataTypeDto`.

**Adding a new health data type (Kotlin side):**
1. Create Kotlin mapper in `mappers/health_record_mappers/`
2. Create handler class in `handlers/health_record_handlers/` implementing required interfaces based on Health Connect record capabilities
3. Register handler in `HealthRecordHandlerRegistry`
4. Update `HealthDataTypeMapper` (Kotlin)

### Services

| Service                            | Responsibility                                         |
|------------------------------------|--------------------------------------------------------|
| `HealthConnectorPermissionService` | Permission requests and status checking                |
| `HealthConnectorFeatureService`    | Platform feature availability (e.g., background reads) |
| `HealthConnectorManifestService`   | Validates permissions declared in AndroidManifest.xml  |
| `HealthConnectorDataSyncService`   | Incremental sync with change tokens                    |

### Mappers

`mappers/` contains bidirectional converters:
- `health_record_mappers/` - Pigeon DTO ↔ Health Connect Record
- `metadata_mappers/` - Device type, recording method
- `permission_mappers/` - Permission strings

### Exception Handling

`HealthConnectorException` is a sealed class hierarchy. The `HealthRecordHandler.process()` method provides
centralized exception mapping:
- `SecurityException` → `HealthConnectorException.Authorization`
- `IllegalArgumentException`/`IllegalStateException` → `HealthConnectorException.InvalidArgument`
- `IOException` → `HealthConnectorException.HealthService`

### Concurrency

Uses `DispatcherProvider` for testable coroutine dispatchers. Inject `StandardTestDispatcher` in tests via constructor.

## Testing

Tests are in `src/test/kotlin/`. Stack:
- **JUnit 5** - Test framework
- **MockK** - Kotlin mocking
- **Kotest Assertions** - Expressive assertions (`shouldBe`, `shouldThrow`)
- **Robolectric** - Android framework simulation
- **kotlinx-coroutines-test** - Coroutine testing (`runTest`, `StandardTestDispatcher`)

Test injection points:
- `HealthConnectorHCAndroidPlugin.setContext()`, `setActivity()`, `setClient()` - `@VisibleForTesting` setters
- `DispatcherProvider` constructor parameter for custom dispatchers

## Code Quality

### Detekt Rules (detekt.yml)

Key thresholds:
- `LongMethod`: 60 lines
- `CyclomaticComplexMethod`: 15
- `LongParameterList`: 6 function / 7 constructor
- `TooManyFunctions`: 10 per class
- `MaxLineLength`: 100 chars (comments excluded)
- `ReturnCount`: max 3 returns

`detekt-baseline.xml` contains suppressed existing issues. Update with `./gradlew detektBaseline`.

### Generated Code

Files matching `*.g.kt` are Pigeon-generated. They are excluded from ktlint and detekt. Do not edit manually.

## Android-Specific Notes

- **Minimum API 26** (Android 8.0): Required for Health Connect SDK
- **Health Connect App Required**: Must be installed on device; use `getHealthPlatformStatus()` to check
- **Permission Declaration**: All health permissions must be declared in `AndroidManifest.xml`
- **ComponentActivity Required**: Permission requests need a `ComponentActivity` (not just `Activity`)
- **Nutrition Permission Consolidation**: Health Connect uses a single permission for `nutrition` and all nutrient data types (e.g., `dietaryProtein`, `dietaryFiber`). The client handles this mapping automatically in `_handleNutritionNutrientPermissions`.
