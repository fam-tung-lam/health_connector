# Core API

The main SDK interface for health data operations across iOS HealthKit and Android Health Connect.

## Table of Contents

- [HealthConnector](#healthconnector)
    - [Creating an Instance](#creating-an-instance)
    - [Checking Platform Availability](#checking-platform-availability)
- [Request-Response Pattern](#request-response-pattern)
- [Type Safety and Generics](#type-safety-and-generics)
- [Core Operations](#core-operations)
    - [Feature Management](#feature-management)
    - [Permission Management](#permission-management)
    - [Reading Health Records](#reading-health-records)
    - [Writing Health Records](#writing-health-records)
    - [Updating Health Records](#updating-health-records-android-health-connect-only)
    - [Deleting Health Records](#deleting-health-records)
    - [Aggregating Health Data](#aggregating-health-data)

## HealthConnector

The `HealthConnector` class is the central entry point for all health data operations. It provides a
unified interface for:

- **Feature Management**: Check platform capability availability
- **Permission Management**: Request and check data access permissions
- **Reading Data**: Query health records with filtering and pagination
- **Writing Data**: Store new health measurements
- **Updating Data**: Modify existing health records (Android Health Connect only)
- **Deleting Data**: Remove health records
- **Aggregation**: Calculate sums, averages, min/max values over time ranges

### Creating an Instance

Before using any health data operations, you must create a `HealthConnector` instance:

```dart
import 'package:health_connector/health_connector.dart';

// Create with default configuration
final connector = await HealthConnector.create();

// Or create with custom configuration
final connector = await HealthConnector.create(
  HealthConnectorConfig(
    isLoggerEnabled: true, // Enable debug logging
  ),
);
```

**Throws:**

- `HealthPlatformUnavailableException` — Health platform is not supported on this device
- `HealthPlatformNotInstalledOrUpdateRequiredException` (Android Health Connect Only) — Health Connect app needs
  installation or update

### Checking Platform Availability

Before creating a connector instance, you can check platform availability:

```dart
final status = await HealthConnector.getHealthPlatformStatus();

switch (status) {
  case HealthPlatformStatus.available:
    // Platform is ready to use
    final connector = await HealthConnector.create();
    break;
  case HealthPlatformStatus.notInstalled:
    // Health Connect needs installation (Android Health Connect Only)
    print('Please install Health Connect');
    break;
  case HealthPlatformStatus.updateRequired:
    // Health Connect needs update (Android Health Connect Only)
    print('Please update Health Connect');
    break;
  case HealthPlatformStatus.unavailable:
    // Health platform not supported on this device
    print('Health platform not available');
    break;
}
```

**Platform Details:**

| Platform                   | Supported | Notes                                                  |
|----------------------------|-----------|--------------------------------------------------------|
| **iOS HealthKit**          | ✅         | Always returns `HealthPlatformStatus.available`        |
| **Android Health Connect** | ✅         | Returns actual status; may require installation/update |


## Request-Response Pattern

The Health Connector SDK uses a strongly-typed request-response pattern for read, delete, and
aggregate data operations.

### Why This Pattern?

Health Connect and HealthKit have fundamentally different APIs. The request-response pattern solves
this by:

1. **Encapsulating platform logic** — The SDK translates your request into the appropriate
   platform-specific API calls
2. **Type safety** — Each `HealthDataType` only exposes the operations it supports
3. **Validation** — Requests validate parameters at creation time, catching errors early
4. **Consistency** — A unified API regardless of the underlying platform

### Pattern Overview

The SDK operations follow a consistent pattern:

1. Create a typed **request** object through a `HealthDataType` method
2. Pass the request to the appropriate `HealthConnector` method
3. Receive a typed **response** with automatic type inference

```dart
// Step 1: Create request via HealthDataType
final request = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

// Step 2: Execute request
final response = await connector.readRecords(request);

// Step 3: Use typed response
// response.records is List<StepsRecord>, not List<HealthRecord>
for (final record in response.records) {
  print(record.count.value); // Direct access, no casting needed
}
```

### Write and Update Operations

Write and update operations **do not** use the request-response pattern because:

- **Write operations** have consistent APIs across both platforms—both accept health record objects
  directly
- **Update operations** are only supported on Android Health Connect (iOS HealthKit uses an
  immutable data model)

```dart
// Writing: Direct record → ID
final recordId = await connector.writeRecord(stepsRecord);

// Updating (Android Health Connect Only): Direct record → void
await connector.updateRecord(updatedRecord);
```

## Type Safety and Generics

The SDK leverages Dart generics to provide **compile-time type safety**. Each `HealthDataType` is
parameterized with its corresponding `HealthRecord` type and `MeasurementUnit`, ensuring the correct
types flow through all operations automatically.

### Automatic Type Inference

The compiler automatically infers the correct record and measurement unit types:

```dart
// HealthDataType.weight is defined as `HealthDataType<WeightRecord, Mass>`
// This means:
//   - Read operations return `WeightRecord` (not a generic `HealthRecord`)
//   - Aggregation returns `Mass` (the measurement unit for weight)

// Reading: Automatic record type inference
final request = HealthDataType.weight.readInTimeRange(
  startTime: start,
  endTime: end,
);
// request is `ReadRecordsInTimeRangeRequest<WeightRecord>`

final response = await connector.readRecords(request);
// response.records is `List<WeightRecord>`, not `List<HealthRecord>`

for (final record in response.records) {
  print('Weight: ${record.weight.value}'); // ✅ No cast needed
}

// Aggregation: Automatic measurement unit inference
final avgRequest = HealthDataType.weight.aggregateAvg(
  startTime: start,
  endTime: end,
);
// avgRequest is `AggregateRequest<WeightRecord, Mass>`

final avgWeight = await connector.aggregate(avgRequest);
// avgWeight is `Mass`, not `MeasurementUnit`
print('Average weight: ${avgWeight.inKilograms} kg'); // ✅ Correct type automatically
```

### Benefits of Type Safety

- **No runtime type casting** — The compiler knows the exact record and unit types
- **IDE autocompletion** — Your IDE suggests the correct properties for each record type
- **Compile-time errors** — Type mismatches are caught before your app runs
- **Refactoring safety** — Type changes propagate throughout your code

### Example: Different Measurement Units

```dart
// Steps: Returns Numeric
final totalSteps = await connector.aggregate(
  HealthDataType.steps.aggregateSum(startTime: start, endTime: end),
);
print('Total steps: ${totalSteps.value}'); // totalSteps is Numeric

// Distance: Returns Length
final totalDistance = await connector.aggregate(
  HealthDataType.distance.aggregateSum(startTime: start, endTime: end),
);
print('Total distance: ${totalDistance.inMeters} m'); // totalDistance is Length

// Calories: Returns Energy
final totalCalories = await connector.aggregate(
  HealthDataType.activeCaloriesBurned.aggregateSum(startTime: start, endTime: end),
);
print('Total calories: ${totalCalories.inKilocalories} kcal'); // totalCalories is Energy
```

## Core Operations

### Feature Management

#### Checking Feature Availability

```dart
final status = await connector.getFeatureStatus(
  HealthPlatformFeature.readHealthDataInBackground,
);

if (status == HealthPlatformFeatureStatus.available) {
  // Feature is supported - safe to request permission
  await connector.requestPermissions([
    HealthPlatformFeature.readHealthDataInBackground.permission,
  ]);
} else {
  // Feature not available on this platform/version
  print('Background reading not available');
}
```

**Platform Behavior:**

| Platform                   | Behavior                                                             |
|----------------------------|----------------------------------------------------------------------|
| **iOS HealthKit**          | All features always return `HealthPlatformFeatureStatus.available`   |
| **Android Health Connect** | Returns actual availability based on Android version and SDK version |

**Available Features:**

- `HealthPlatformFeature.readHealthDataInBackground` — Read health data in background
- `HealthPlatformFeature.readHealthDataHistory` — Access health data older than 30 days

### Permission Management

#### Requesting Permissions

Request permissions for specific health data types and platform features:

```dart
final results = await connector.requestPermissions([
  // Data permissions
  HealthDataType.steps.readPermission,
  HealthDataType.steps.writePermission,
  HealthDataType.weight.readPermission,
  HealthDataType.weight.writePermission,
  
  // Feature permissions
  HealthPlatformFeature.readHealthDataInBackground.permission,
]);

for (final result in results) {
  print('${result.permission}: ${result.status}');
}
```

> [!WARNING]
> **iOS Privacy Note**: Read permissions always return `PermissionStatus.unknown` on iOS. 
> This is by design—Apple prevents apps from detecting whether users have health data by 
> checking permission status.

**Throws:**

- `InvalidConfigurationException` — Missing platform-specific configuration in:
  - `AndroidManifest.xml` (Android)
  - Or `Info.plist` (iOS)

#### Checking Permission Status

Check the status of individual permissions:

```dart
final status = await connector.getPermissionStatus(
  HealthDataType.steps.readPermission,
);

switch (status) {
  case PermissionStatus.granted:
    print('Permission granted');
    break;
  case PermissionStatus.denied:
    print('Permission denied');
    break;
  case PermissionStatus.unknown:
    print('Cannot determine (iOS read permission)');
    break;
}
```

#### Getting All Granted Permissions (Android Health Connect Only)

Retrieve all permissions currently granted to your app:

```dart
try {
  final grantedPermissions = await connector.getGrantedPermissions();
  for (final permission in grantedPermissions) {
    if (permission is HealthDataPermission) {
      print('${permission.dataType} (${permission.accessType})');
    }
  }
} on UnsupportedOperationException {
  // This API is not available on iOS
  print('Only available on Android Health Connect');
}
```

> [!CAUTION]
> **iOS Privacy Note**: This API is not available on iOS. 
> HealthKit does not provide a way to query all granted permissions to protect user privacy.

**Throws:**

- `UnsupportedOperationException` — When called on iOS HealthKit

#### Revoking All Permissions (Android Health Connect Only)

Revoke all permissions granted to your app:

```dart
try {
  await connector.revokeAllPermissions();
  print('All permissions revoked');
} on UnsupportedOperationException {
  // This API is not available on iOS
  print('Only available on Android Health Connect');
}
```

> [!CAUTION]
> **iOS Privacy Note**: This API is not available on iOS. HealthKit requires users to manually 
> revoke permissions through the iOS Settings app to ensure users have full control over 
> their health data.

**Throws:**

- `UnsupportedOperationException` — When called on iOS HealthKit

### Reading Health Records

#### Read Single Record by ID

Retrieve a single health record by its unique identifier:

```dart
final recordId = HealthRecordId('existing-record-id');
final request = HealthDataType.steps.readById(recordId);
final record = await connector.readRecord(request);

if (record != null) {
  print('Steps: ${record.count.value}');
} else {
  print('Record not found');
}
```

**Returns:** `Future<R?>` where `R` is the health record type (e.g., `StepsRecord`). Returns `null`
if record doesn't exist.

**Throws:**

- `NotAuthorizedException` — Read permission not granted for this data type

#### Read Multiple Records in Time Range

Query health records within a time range with pagination support:

```dart
final request = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
  pageSize: 100, // Optional, defaults to platform-specific value
);

final response = await connector.readRecords(request);

for (final record in response.records) {
  print('Steps: ${record.count.value} (${record.startTime} - ${record.endTime})');
}

// Check if more pages available
if (response.hasMorePages) {
  final nextResponse = await connector.readRecords(response.nextPageRequest!);
  // Process next page...
}
```

**Returns:** `Future<ReadRecordsInTimeRangeResponse<R>>` containing:

- `records` — List of health records matching the query
- `nextPageRequest` — Request for the next page (null if no more pages)
- `hasMorePages` — Convenience getter for `nextPageRequest != null`

**Throws:**

- `NotAuthorizedException` — Read permission not granted for this data type

> [!NOTE]
> **Historical Data Access on Android**: By default, Health Connect only provides access to the last
> 30 days of historical health data. To read data older than 30 days, the
`HealthPlatformFeature.readHealthDataHistory` feature must be available and its permission must be
> granted. **iOS HealthKit has no such limitation**.

#### Pagination Example

```dart
var request = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
  pageSize: 100,
);

final allRecords = <StepsRecord>[];

while (true) {
  final response = await connector.readRecords(request);
  allRecords.addAll(response.records);

  if (response.nextPageRequest == null) break;
  request = response.nextPageRequest!;
}

print('Total records: ${allRecords.length}');
```

### Writing Health Records

Write operations store new health records to the platform's health data store.

#### Write Single Record

```dart
final newRecord = StepsRecord(
  id: HealthRecordId.none, // Must be .none for new records
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  count: Numeric(1500),
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.phone),
  ),
);

try {
  final recordId = await connector.writeRecord(newRecord);
  print('Record written with ID: $recordId');
} on NotAuthorizedException catch (e) {
  print('Write permission denied: ${e.message}');
} on InvalidArgumentException catch (e) {
  print('Validation failed: ${e.message}');
}
```

**Returns:** `Future<HealthRecordId>` — The platform-assigned ID for the new record

**Throws:**

- `NotAuthorizedException` — Write permission not granted for this data type
- `InvalidArgumentException` — Record validation failed (see validation rules below)

**Validation Rules:**

- Record `id` must be `HealthRecordId.none` for new records
- Record must be supported on the current platform
- `startTime` must be before or equal to `endTime`
- Measurement values must be within valid ranges
- Required fields must be non-null

#### Write Multiple Records Atomically

All records succeed or all fail together:

```dart
final records = [
  StepsRecord(
    id: HealthRecordId.none,
    startTime: DateTime.now().subtract(Duration(hours: 2)),
    endTime: DateTime.now().subtract(Duration(hours: 1)),
    count: Numeric(3000),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  ),
  StepsRecord(
    id: HealthRecordId.none,
    startTime: DateTime.now().subtract(Duration(hours: 1)),
    endTime: DateTime.now(),
    count: Numeric(2000),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  ),
];

try {
  final recordIds = await connector.writeRecords(records);
  print('Wrote ${recordIds.length} records');
} on InvalidArgumentException catch (e) {
  print('Validation failed: ${e.message}');
}
```

**Returns:** `Future<List<HealthRecordId>>` — Platform-assigned IDs for all records in the same
order

**Throws:**

- `NotAuthorizedException` — Write permission not granted for this data type
- `InvalidArgumentException` — One or more records failed validation

**Validation Rules:**

- All record `id` values must be `HealthRecordId.none`
- All records must be supported on the current platform
- All records must pass individual validation rules

### Updating Health Records (Android Health Connect Only)

Update operations modify existing health records. 

> [!CAUTION]
> **iOS Limitation**: HealthKit uses an **immutable data model**. 
> Once a health record is written, it cannot be modified. To "update" a record on iOS, 
> you must delete the old record and write a new one (see workaround below).

#### Update Single Record (Android Health Connect Only)

```dart
// First, read the existing record
final recordId = HealthRecordId('existing-record-id');
final request = HealthDataType.steps.readById(recordId);
final existingRecord = await connector.readRecord(request);

if (existingRecord != null) {
  // Modify the record
  final updatedRecord = existingRecord.copyWith(
    count: Numeric(existingRecord.count.value + 500),
  );

  try {
    await connector.updateRecord(updatedRecord);
    print('Record updated');
  } on UnsupportedOperationException {
    print('Update not supported on iOS');
  } on InvalidArgumentException catch (e) {
    print('Validation failed: ${e.message}');
  }
}
```

**Returns:** `Future<void>`

**Throws:**

- `UnsupportedOperationException` — When called on iOS HealthKit
- `NotAuthorizedException` — Write permission not granted for this data type
- `InvalidArgumentException` — Record validation failed

**Validation Rules:**

- Record `id` must **not** be `HealthRecordId.none`
- Record must be supported on the current platform
- Record must pass all standard validation rules

#### Update Multiple Records Atomically (Android Health Connect Only)

All updates succeed or all fail together:

```dart
// Read existing records
final readRequest = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);
final response = await connector.readRecords(readRequest);

// Update all records
final updatedRecords = response.records.map((record) {
  return record.copyWith(
    count: Numeric(record.count.value + 100),
  );
}).toList();

try {
  await connector.updateRecords(updatedRecords);
  print('Updated ${updatedRecords.length} records');
} on UnsupportedOperationException {
  print('Update not supported on iOS');
}
```

**Returns:** `Future<void>`

**Throws:**

- `UnsupportedOperationException` — When called on iOS HealthKit
- `NotAuthorizedException` — Write permission not granted for this data type
- `InvalidArgumentException` — One or more records failed validation

#### iOS HealthKit Update Workaround

To update a record on iOS, delete the old record and write a new one:

```dart
// 1. Delete existing record
await connector.deleteRecords(
  HealthDataType.steps.deleteByIds([existingRecord.id]),
);

// 2. Write new record with updated values
final newRecord = StepsRecord(
  id: HealthRecordId.none,
  startTime: existingRecord.startTime,
  endTime: existingRecord.endTime,
  count: Numeric(newValue),
  metadata: existingRecord.metadata,
);

final newId = await connector.writeRecord(newRecord);
// Note: newId will be different from the original ID
```

### Deleting Health Records

Delete operations remove health records from the platform's health data store.

> [!IMPORTANT]
> Apps can **only delete records they created**. Attempting to delete records from other apps will 
> fail with an error.

#### Delete Records by IDs

Delete specific records atomically (all succeed or all fail):

```dart
await connector.deleteRecords(
  HealthDataType.steps.deleteByIds([
    HealthRecordId('id-1'),
    HealthRecordId('id-2'),
    HealthRecordId('id-3'),
  ]),
);
```

**Returns:** `Future<void>`

**Throws:**

- `NotAuthorizedException` — Write permission not granted for this data type
- `InvalidArgumentException` — Invalid record IDs

#### Delete Records in Time Range

Delete all records of a specific type within a time range atomically:

```dart
await connector.deleteRecords(
  HealthDataType.steps.deleteInTimeRange(
    startTime: DateTime.now().subtract(Duration(days: 7)),
    endTime: DateTime.now(),
  ),
);
```

**Returns:** `Future<void>`

**Throws:**

- `NotAuthorizedException` — Write permission not granted for this data type
- `InvalidArgumentException` — Invalid time range (e.g., `startTime > endTime`)

### Aggregating Health Data

Aggregation operations compute statistical values (sum, average, minimum, maximum) over time ranges.

#### Sum Aggregation

Calculate the total value over a time period:

```dart
final sumRequest = HealthDataType.steps.aggregateSum(
  startTime: DateTime.now().subtract(Duration(days: 1)),
  endTime: DateTime.now(),
);

final totalSteps = await connector.aggregate(sumRequest);
print('Total steps: ${totalSteps.value}'); // totalSteps is Numeric
```

#### Average Aggregation

Calculate the mean value over a time period:

```dart
final avgRequest = HealthDataType.heartRate.aggregateAverage(
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
);

final avgHeartRate = await connector.aggregate(avgRequest);
print('Average BPM: ${avgHeartRate.value}'); // avgHeartRate is Numeric
```

#### Minimum Aggregation

Find the minimum recorded value over a time period:

```dart
final minRequest = HealthDataType.weight.aggregateMin(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);

final minWeight = await connector.aggregate(minRequest);
print('Min weight: ${minWeight.inKilograms} kg'); // minWeight is Mass
```

#### Maximum Aggregation

Find the maximum recorded value over a time period:

```dart
final maxRequest = HealthDataType.weight.aggregateMax(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);

final maxWeight = await connector.aggregate(maxRequest);
print('Max weight: ${maxWeight.inKilograms} kg'); // maxWeight is Mass
```

**Returns:** `Future<U>` where `U` is the measurement unit type for the data type (e.g., `Numeric`,
`Mass`, `Length`)

**Throws:**

- `NotAuthorizedException` — Read permission not granted for this data type

> [!NOTE]
> Not all data types support all aggregation types. The SDK uses Dart's type system to expose only 
> the supported aggregation methods for each `HealthDataType`.
