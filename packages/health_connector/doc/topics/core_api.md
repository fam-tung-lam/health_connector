# Core API

The main SDK interface for health data operations across iOS HealthKit and Android Health Connect.

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
- **Incremental Sync**: Retrieve changes since your last sync

## Type Safety and Generics

The SDK leverages Dart generics to provide **compile-time type safety**. Each `HealthDataType` is
parameterized with its corresponding `HealthRecord` type and `MeasurementUnit`, ensuring the correct
types flow through all operations automatically.

### Automatic Type Inference

The compiler automatically infers the correct record and measurement unit types:

```dart
// Step 1: Create request via `HealthDataType`

// Compiler infers `ReadRecordsInTimeRangeRequest<WeightRecord>` for `request` automatically.
final request = HealthDataType.weight.readInTimeRange(
  startTime: start,
  endTime: end,
);

// Step 2: Execute request

// Compiler infers `ReadRecordsResponse<WeightRecord>` for `response`.
final response = await connector.readRecords(request);

// Step 3: Receive typed response

// The response guarantees `response.records` is `List<WeightRecord>`.
final records = response.records;
for (final record in response.records) {
  // ✅ Compile-time Safety:
  // You can safely access `weight` property specific to `WeightRecord`.
  // No runtime checks or casts relating to `HealthRecord` are needed.
  print('Weight: ${record.weight.value}');
}
```

### Benefits of Type Safety

- **No runtime type casting** — The compiler knows the exact record and unit types
- **IDE autocompletion** — Your IDE suggests the correct properties for each record type
- **Compile-time errors** — Type mismatches are caught before your app runs
- **Refactoring safety** — Type changes propagate throughout your code

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
// Step 1: Create request via `HealthDataType`

// `HealthDataType.steps` is typed as `HealthDataType<StepsRecord, Numeric>`, so
// `request` is inferred as `ReadRecordsInTimeRangeRequest<StepsRecord>`
final request = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

// Step 2: Execute request

// Compiler infers `ReadRecordsResponse<StepsRecord>` for `response`.
final response = await connector.readRecords(request);

// Step 3: Receive typed response

// `records` is automatically compiled as `List<StepsRecord>`, not `List<HealthRecord>`
final records = response.records;
for (final record in records) {
// ✅ Compile-time Safety:
// You can safely access `count` property specific to `StepsRecord`.
// No runtime checks or casts relating to `HealthRecord` are needed.  
  print(record.count.value); 
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
