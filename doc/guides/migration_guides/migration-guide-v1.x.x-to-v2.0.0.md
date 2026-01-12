# Migration Guide: v1.x.x → v2.0.0

This guide helps you migrate your Flutter health data integration from HealthConnect SDK v1.x.x to
v2.0.0.

> [!IMPORTANT]
> **v2.0.0 contains breaking changes** that require code modifications. Review this guide carefully
> before upgrading.

---

## Table of Contents

- [Overview](#overview)
- [Quick Migration Checklist](#quick-migration-checklist)
- [Breaking Changes](#breaking-changes)
  - [1. Delete Records API Redesign](#1-delete-records-api-redesign)
  - [2. Read Records Method Rename](#2-read-records-method-rename)
  - [3. Error Code Changes](#3-error-code-changes)
  - [4. Aggregate Response Type](#4-aggregate-response-type)
  - [5. Update Record Return Type](#5-update-record-return-type)
- [New Features in v2.0](#new-features-in-v20)

---

## Overview

**Difficulty**: Moderate

v2.0.0 introduces a more type-safe and developer-friendly API design with improved error handling
and platform consistency. Most changes require simple find-and-replace updates, while a few require
understanding new patterns.

**Estimated migration time**: 15-30 minutes for typical applications

---

## Breaking Changes

### 1. Delete Records API Redesign

**Difficulty**: Moderate

The delete API has been completely redesigned for better type safety and consistency.

#### API Changes

| v1.x.x Method                  | v2.0.0 Replacement                                           | Complexity |
|--------------------------------|--------------------------------------------------------------|------------|
| `deleteRecordsByIds()`         | `deleteRecords()` that accepts `deleteByIds()` request       | Moderate   |
| `deleteRecords()` (time range) | `deleteRecords()` that accepts `deleteInTimeRange()` request | Moderate   |

#### Migration Steps

**Before (v1.x.x) - Delete by IDs:**

```dart
// v1.x.x - Named parameters
await connector.deleteRecordsByIds(
  dataType: HealthDataType.steps,
  recordIds: [HealthRecordId('id-1'), HealthRecordId('id-2')],
);
```

**After (v2.0.0) - Delete by IDs:**

```dart
// v2.0.0 - Request-based using capability interface
final request = HealthDataType.steps.deleteByIds([
  HealthRecordId('id-1'),
  HealthRecordId('id-2'),
]);

await connector.deleteRecords(request);
```

**Before (v1.x.x) - Delete by time range:**

```dart
// v1.x.x - Named parameters
await connector.deleteRecords(
  dataType: HealthDataType.steps,
  startTime: startTime,
  endTime: endTime,
);
```

**After (v2.0.0) - Delete by time range:**

```dart
// v2.0.0 - Request-based using capability interface
final request = HealthDataType.steps.deleteInTimeRange(
  startTime: startTime,
  endTime: endTime,
);

await connector.deleteRecords(request);
```

#### Why This Change?

- **Type Safety**: Request objects provide compile-time safety and proper type inference
- **Consistency**: Deletion API now matches the pattern used by read and aggregate operations
- **Future-Proof**: Easier to extend with additional deletion filters or options
- **Capability-Based**: Leverages `DeletableHealthDataType` interface for better discoverability

---

### 2. Read Records Method Rename

**Difficulty**: Simple

The method for creating read requests from `HealthDataType` has been renamed for clarity.

#### API Changes

| v1.x.x Method                  | v2.0.0 Method                      | Type          |
|--------------------------------|------------------------------------|---------------|
| `HealthDataType.readRecords()` | `HealthDataType.readInTimeRange()` | Method rename |

#### Migration Steps

**Before (v1.x.x):**

```dart
final request = HealthDataType.steps.readRecords(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

final response = await connector.readRecords(request);
```

**After (v2.0.0):**

```dart
final request = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

final response = await connector.readRecords(request);
```

> [!TIP]
> Use IDE refactoring (e.g., "Rename Symbol") to update all occurrences safely.

---

### 3. Error Code Changes

**Difficulty**: Simple

Several error codes have been renamed for better clarity and platform consistency.

#### Error Code Mapping

| v1.x.x Error Code              | v2.0.0 Error Code                            | Usage Context                |
|--------------------------------|----------------------------------------------|------------------------------|
| `securityError`                | `notAuthorized`                              | Permission denied errors     |
| `invalidPlatformConfiguration` | `invalidConfiguration`                       | Configuration errors         |
| `installationOrUpdateRequired` | `healthPlatformNotInstalledOrUpdateRequired` | Health platform setup errors |
| `unsupportedHealthPlatformApi` | `unsupportedOperation`                       | Platform API not available   |

#### Migration Steps

**Before (v1.x.x):**

```dart
try {
  await connector.readRecords(request);
} on HealthConnectorException catch (e) {
  if (e.code == HealthConnectorErrorCode.securityError) {
    print('Permission denied');
  } else if (e.code == HealthConnectorErrorCode.unsupportedHealthPlatformApi) {
    print('API not supported on this platform');
  }
}
```

**After (v2.0.0):**

```dart
try {
  await connector.readRecords(request);
} on HealthConnectorException catch (e) {
  if (e.code == HealthConnectorErrorCode.notAuthorized) {
    print('Permission denied');
  } else if (e.code == HealthConnectorErrorCode.unsupportedOperation) {
    print('API not supported on this platform');
  }
}
```

### 4. Aggregate Response Type

**Difficulty**: Simple

The aggregate method now returns the measurement unit directly instead of wrapping it in `AggregateResponse`.

#### API Changes

| v1.x.x Return Type                | v2.0.0 Return Type |
|-----------------------------------|--------------------|
| `Future<AggregateResponse<R, U>>` | `Future<U>`        |

Where `U extends MeasurementUnit` (e.g., `Numeric`, `Energy`, `Length`)

#### Migration Steps

**Before (v1.x.x):**

```dart
final request = HealthDataType.steps.aggregateSum(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

final response = await connector.aggregate(request);
print('Total steps: ${response.value.value}'); // response.value is Numeric
```

**After (v2.0.0):**

```dart
final request = HealthDataType.steps.aggregateSum(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

final totalSteps = await connector.aggregate(request);
print('Total steps: ${totalSteps.value}'); // totalSteps is Numeric directly
```

> [!TIP]
> The response is now the `MeasurementUnit` directly, eliminating the need to unwrap `.value`.

---

### 5. Update Record Return Type

**Difficulty**: Simple

The `updateRecord()` method now returns `void` instead of `HealthRecordId`.

#### API Changes

| v1.x.x Return Type       | v2.0.0 Return Type |
|--------------------------|--------------------|
| `Future<HealthRecordId>` | `Future<void>`     |

#### Migration Steps

**Before (v1.x.x):**

```dart
final updatedRecord = existingRecord.copyWith(
  count: Numeric(existingRecord.count.value + 100),
);

final newRecordId = await connector.updateRecord(updatedRecord);
print('Updated record ID: ${newRecordId.value}');
```

**After (v2.0.0):**

```dart
final updatedRecord = existingRecord.copyWith(
  count: Numeric(existingRecord.count.value + 100),
);

await connector.updateRecord(updatedRecord);
// Record ID remains the same (Android)
print('Updated record ID: ${updatedRecord.id.value}');
```

---

## New Features in v2.0

Take advantage of these new capabilities after migrating:

### 1. Individual Permission Status Check

**NEW in v2.0.0**

```dart
final permission = HealthDataType.steps.readPermission;
final status = await connector.getPermissionStatus(permission);

switch (status) {
  case PermissionStatus.granted:
    // Permission granted
  case PermissionStatus.denied:
    // Permission denied
  case PermissionStatus.unknown:
    // Cannot determine (iOS read permissions)
}
```

### 2. Batch Update Records (Android Only)

**NEW in v2.0.0**

```dart
// Update multiple records atomically
final updatedRecords = existingRecords.map((record) {
  return record.copyWith(count: Numeric(record.count.value + 1000));
}).toList();

await connector.updateRecords(updatedRecords);
```

### 3. Activity-Specific Distance Types (iOS)

Distance tracking is now more granular on iOS:

- `CyclingDistanceDataType`
- `SwimmingDistanceDataType`
- `WalkingRunningDistanceDataType`
- `WheelchairDistanceDataType`

### 4. Speed Data Types

New speed metrics supported on both platforms:

- `CyclingSpeedDataType`
- `RunningSpeedDataType`
- `WalkingSpeedDataType`

### 5. Exercise Session & Workout Support

**NEW in v2.0.0**

Track workouts and exercise sessions with comprehensive exercise type support:

```dart
// Write an exercise session
final exerciseSession = ExerciseSessionRecord(
  id: HealthRecordId.none,
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  exerciseType: ExerciseType.running,
  title: 'Morning Run',
  notes: '5K run in the park',
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.phone),
  ),
);

await connector.writeRecord(exerciseSession);

// Read exercise sessions
final request = HealthDataType.exerciseSession.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);
final response = await connector.readRecords(request);

// Aggregate total exercise duration
final totalDuration = await connector.aggregate(
  HealthDataType.exerciseSession.aggregateSum(
    startTime: DateTime.now().subtract(Duration(days: 7)),
    endTime: DateTime.now(),
  ),
);
```

#### Exercise Type Support

v2.0.0 includes **100+ exercise types** across both platforms:

- **~50 cross-platform types**: running, walking, cycling, swimming, basketball, tennis, yoga, HIIT, and more
- **iOS-only types** (annotated with `@supportedOnAppleHealth`):
  - Swimming (generic), kickboxing, pickleball, cross-country skiing, tai chi, etc.
- **Android-only types** (annotated with `@supportedOnHealthConnect`):
  - Running treadmill, cycling stationary, weightlifting, ice hockey, guided breathing, etc.

**Platform-Specific Validation**:

```dart
// Check if an exercise type is supported on the current platform
final isSupported = ExerciseType.running.isSupportedOnPlatform(
  HealthPlatform.appleHealth,
);

// Get all supported types for a platform
final iosTypes = ExerciseType.appleHealthTypes;
final androidTypes = ExerciseType.healthConnectTypes;

// Get platform-exclusive types
final iosOnlyTypes = ExerciseType.other.getExerciseTypesForPlatform(
  HealthPlatform.appleHealth,
);
```

> [!WARNING]
> Attempting to use a platform-specific exercise type on an unsupported platform will throw `UnsupportedOperationException`.

---

**Happy migrating! 🚀**

For the latest updates and detailed API docs, visit the [HealthConnector documentation](https://pub.dev/packages/health_connector).
