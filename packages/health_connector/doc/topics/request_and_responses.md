# Request-Response Pattern

The Health Connector SDK uses a strongly-typed request-response pattern for all data operations. This architectural pattern provides compile-time type safety, IDE autocompletion, and clear API contracts.

## Core Concepts

### Type-Safe Operations

All SDK operations follow a consistent pattern:

1. Create a typed **request** object through a `HealthDataType` method
2. Pass the request to the appropriate `HealthConnector` method
3. Receive a typed **response** with automatic type inference

This ensures that the compiler knows exactly what type of data you're working with, catching errors at compile time rather than runtime.

### Generics for Compile-Time Safety

The SDK leverages Dart's generics to automatically infer:

- The correct **health record type** based on the data type
- The appropriate **measurement unit** for aggregations
- Type-safe **request and response** objects

## Request Types

All request classes extend the base `Request` class and are created through methods on `HealthDataType` instances.

### Read Requests

#### ReadRecordByIdRequest

Reads a single health record by its unique identifier.

```dart
// Create request
final request = HealthDataType.steps.readById(recordId);

// Execute request
final record = await connector.readRecord(request);
```

#### ReadRecordsInTimeRangeRequest

Queries multiple health records within a time range with pagination support.

```dart
// Create request with default page size
final request = HealthDataType.heartRate.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

// Execute request
final response = await connector.readRecords(request);

// Process paginated results
for (final record in response.records) {
  print('Heart rate: ${record.beatsPerMinute.value}');
}
```

### Aggregate Requests

Compute aggregated values (sum, average, min, max) over time ranges.

```dart
// Sum aggregation
final sumRequest = HealthDataType.steps.aggregateSum(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);
final totalSteps = await connector.aggregate(sumRequest);
print('Total steps: ${totalSteps.value}'); // Numeric type inferred

// Average aggregation
final avgRequest = HealthDataType.heartRate.aggregateAverage(
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
);
final avgHeartRate = await connector.aggregate(avgRequest);
print('Average BPM: ${avgHeartRate.value}'); // Numeric type inferred
```

### Delete Requests

#### DeleteRecordsByIdsRequest

Deletes specific records by their IDs.

```dart
final request = HealthDataType.steps.deleteByIds([id1, id2, id3]);
await connector.deleteRecords(request);
```

#### DeleteRecordsInTimeRangeRequest

Deletes all records of a type within a time range.

```dart
final request = HealthDataType.steps.deleteInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);
await connector.deleteRecords(request);
```

## Response Types

### ReadRecordsInTimeRangeResponse

Contains paginated results from a read operation.

**Properties:**

- `records`: List of health records matching the query
- `nextPageRequest`: Request object for fetching the next page (null if no more pages)
- `hasMorePages`: Convenience getter equivalent to `nextPageRequest != null`

**Pagination Example:**

```dart
var response = await connector.readRecords(request);

// Process all pages
while (response.hasMorePages) {
  for (final record in response.records) {
    print(record);
  }
  
  // Fetch next page
  response = await connector.readRecords(response.nextPageRequest!);
}
```

### Direct Value Returns

Some operations return values directly rather than response objects:

- **Reading single records**: Returns `R?` (nullable health record)
- **Writing records**: Returns `HealthRecordId` or `List<HealthRecordId>`
- **Aggregations**: Returns `U` (the appropriate measurement unit type)

## Type Inference Benefits

### Automatic Record Type Inference

```dart
// Compiler knows 'record' is StepsRecord
final request = HealthDataType.steps.readById(id);
final record = await connector.readRecord(request);
print(record.count.value); // IDE autocompletes StepsRecord properties

// Compiler knows 'records' is List<HeartRateRecord>
final timeRequest = HealthDataType.heartRate.readInTimeRange(
  startTime: start,
  endTime: end,
);
final response = await connector.readRecords(timeRequest);
for (final record in response.records) {
  print(record.beatsPerMinute); // IDE autocompletes HeartRateRecord properties
}
```

### Automatic Measurement Unit Inference

```dart
// Returns Numeric for steps
final stepsSum = await connector.aggregate(
  HealthDataType.steps.aggregateSum(startTime: start, endTime: end),
);

// Returns Length for distance
final distanceSum = await connector.aggregate(
  HealthDataType.distance.aggregateSum(startTime: start, endTime: end),
);

// Returns Energy for calories
final caloriesSum = await connector.aggregate(
  HealthDataType.activeCaloriesBurned.aggregateSum(startTime: start, endTime: end),
);
```

## Data Ownership

All delete operations respect platform data ownership rules:

- Apps can only delete records **they created**
- Attempting to delete records from other apps results in a security error
- This applies to both ID-based and time-range deletions

## See Also

- `HealthDataType` - Factory for creating request objects
- `HealthConnector` - Methods that accept requests and return responses
- `HealthRecord` - Base class for all health record types
- `MeasurementUnit` - Base class for all measurement units
