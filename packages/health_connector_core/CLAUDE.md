# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Package Purpose

`health_connector_core` is the foundational package providing:

- Platform interface (`HealthConnectorPlatformClient`) that platform implementations must fulfill
- Domain models for health records, data types, and measurement units
- Shared utilities for validation and error handling

## Directory Structure

```text
lib/
└── src/
    ├── annotations/       # Platform/since/read_only annotations
    ├── config/
    ├── models/
    │   ├── exceptions/
    │   ├── health_data_sync/
    │   ├── health_data_types/   # Part files per data type
    │   ├── health_records/       # Part files per record type
    │   ├── measurement_units/
    │   ├── metadata/
    │   ├── permissions/
    │   ├── requests/
    │   └── responses/
    └── utils/
test/
└── src/                  # Mirrors lib/src structure
```

## Key Architectural Patterns

### Sealed Class Hierarchies

The package uses Dart's `sealed class` extensively for exhaustive pattern matching:

- **`HealthRecord`**: Base for all health record types (~185 concrete record types)
- **`HealthDataType<R, U>`**: Type-safe data type definitions with associated record type `R` and measurement unit `U`
- **`MeasurementUnit`**: Type-safe physical units (Mass, Energy, Length, etc.)

### Part Files Organization

Large sealed hierarchies use Dart `part`/`part of` for organization:

- `health_record.dart` has ~185 part files for individual record types
- `health_data_type.dart` has ~120 part files for data type definitions
- `measurement_unit.dart` has 13 part files for unit types

### Capability Interfaces

Data types implement capability interfaces (not mixins) to support operations:

- `ReadableHealthDataType<R>` - can read records
- `WriteableHealthDataType<R>` - can write records
- `DeletableHealthDataType<R>` - can delete records
- `AggregatableHealthDataType<U>` - supports aggregation queries

Interface classes are used instead of mixins to avoid switch-case exhaustiveness issues with sealed types.

### Two Library Entry Points

- **`health_connector_core.dart`**: Public API with selective exports (hides internal types)
- **`health_connector_core_internal.dart`**: Internal API for platform implementations, exports everything including
  `@internalUse` annotated APIs

## Platform Annotations

Custom annotations indicate platform support:

- `@supportedOnHealthConnect` - Android Health Connect only
- `@supportedOnAppleHealth` - iOS HealthKit only
- `@supportedOnAppleHealthIOS16Plus/17Plus/18Plus` - iOS version requirements
- `@readOnly` - Data type cannot be written (system-generated)
- `@sinceV1_0_0`, `@sinceV2_0_0`, etc. - Version when feature was added

## Commands for This Package

```bash
# Run tests
fvm flutter test

# Run single test file
fvm flutter test test/src/models/health_records_test.dart

# Analyze
fvm dart analyze --fatal-warnings
```

## Data Type to Record Mapping

Each `HealthDataType` is parameterized with its corresponding `HealthRecord`:

- `StepsDataType` → `StepsRecord`
- `WeightDataType` → `WeightRecord`
- `HeartRateSeriesDataType` → `HeartRateSeriesRecord`

The generic parameter ensures type safety through read/write operations.

## HealthRecordId Pattern

Records use `HealthRecordId` value object:

- `HealthRecordId.none` for new records (before platform write)
- Platform-assigned UUID string after writing
- Validates against empty strings in factory constructor
