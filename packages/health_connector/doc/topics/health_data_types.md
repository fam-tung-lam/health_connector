# Health Data Types

Comprehensive reference for all supported health and fitness data types across iOS HealthKit and Android Health Connect.

## Overview

Health Connector provides type-safe access to health and fitness data through strongly-typed data type classes. Each data type is associated with:

- A specific **record type** (e.g., `WeightRecord`, `StepsRecord`)
- A specific **measurement unit** (e.g., `Mass`, `Count`)
- Platform-specific **capabilities** (read, write, aggregate, delete)
- Platform-specific **native API mappings**

## Categories

### Activity

Activity data types track physical movement and exercise metrics.

| Data Type       | Measurement Unit | iOS | Android | Capabilities             |
|-----------------|------------------|-----|---------|--------------------------|
| Steps           | Count            | ✅   | ✅       | Read, Write, Sum, Delete |
| Distance        | Length           | ✅   | ✅       | Read, Write, Sum, Delete |
| Active Calories | Energy           | ✅   | ✅       | Read, Write, Sum, Delete |
| Basal Calories  | Energy           | ✅   | ✅       | Read, Write, Sum, Delete |
| Floors Climbed  | Count            | ✅   | ✅       | Read, Write, Sum, Delete |
| Exercise Time   | Duration         | ✅   | ✅       | Read, Write, Sum, Delete |
| Workouts        | -                | ✅   | ✅       | Read, Write, Delete      |

### Body Measurements

Body measurement data types track physical characteristics and body composition.

| Data Type           | Measurement Unit | iOS | Android | Capabilities                     |
|---------------------|------------------|-----|---------|----------------------------------|
| Weight              | Mass             | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Height              | Length           | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Body Fat Percentage | Percentage       | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| BMI                 | Number           | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Lean Body Mass      | Mass             | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Bone Mass           | Mass             | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |

### Vitals

Vital sign data types track physiological measurements and health indicators.

| Data Type                | Measurement Unit | iOS | Android | Capabilities                     |
|--------------------------|------------------|-----|---------|----------------------------------|
| Heart Rate               | BPM              | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Resting Heart Rate       | BPM              | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Heart Rate Variability   | Duration         | ✅   | ✅       | Read, Write, Avg, Delete         |
| Blood Pressure           | Blood Pressure   | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Blood Glucose            | Blood Glucose    | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Oxygen Saturation (SpO2) | Percentage       | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Respiratory Rate         | BPM              | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |
| Body Temperature         | Temperature      | ✅   | ✅       | Read, Write, Avg/Min/Max, Delete |

### Nutrition

Nutrition data types track dietary intake of macronutrients, micronutrients, and other nutritional
components.

| Data Type           | Measurement Unit | iOS | Android | Capabilities             |
|---------------------|------------------|-----|---------|--------------------------|
| Energy (Calories)   | Energy           | ✅   | ✅       | Read, Write, Sum, Delete |
| Protein             | Mass             | ✅   | ✅       | Read, Write, Sum, Delete |
| Total Carbohydrate  | Mass             | ✅   | ✅       | Read, Write, Sum, Delete |
| Total Fat           | Mass             | ✅   | ✅       | Read, Write, Sum, Delete |
| Dietary Fiber       | Mass             | ✅   | ✅       | Read, Write, Sum, Delete |
| Sugar               | Mass             | ✅   | ✅       | Read, Write, Sum, Delete |
| Sodium              | Mass             | ✅   | ✅       | Read, Write, Sum, Delete |
| Caffeine            | Mass             | ✅   | ✅       | Read, Write, Sum, Delete |
| Hydration (Water)   | Volume           | ✅   | ✅       | Read, Write, Sum, Delete |
| Vitamins & Minerals | Mass             | ✅   | ✅       | Read, Write, Sum, Delete |

### Sleep

Sleep data types track sleep sessions, stages, and quality metrics.

| Data Type     | Measurement Unit | iOS | Android | Capabilities        |
|---------------|------------------|-----|---------|---------------------|
| Sleep Session | -                | ✅   | ✅       | Read, Write, Delete |
| Sleep Stages  | -                | ✅   | ✅       | Read, Delete        |

### Speed

Speed data types track velocity during various physical activities.

> [!IMPORTANT]
> Speed data types have **platform-specific implementations**:
>
> - **iOS (HealthKit)**: Activity-specific types (walking, running, stair ascent/descent)
> - **Android (Health Connect)**: Generic speed series data type

#### iOS Speed Data Types (Activity-Specific)

| Data Type           | Description                      | Measurement Unit | Capabilities             |
|---------------------|----------------------------------|------------------|--------------------------|
| Walking Speed       | Speed while walking              | Velocity         | Read, Write, Avg, Delete |
| Running Speed       | Speed while running              | Velocity         | Read, Write, Avg, Delete |
| Stair Ascent Speed  | Vertical speed climbing stairs   | Velocity         | Read, Write, Avg, Delete |
| Stair Descent Speed | Vertical speed descending stairs | Velocity         | Read, Write, Avg, Delete |

**Platform Mapping:**

- `WalkingSpeedDataType` → `HKQuantityType(.walkingSpeed)`
- `RunningSpeedDataType` → `HKQuantityType(.runningSpeed)`
- `StairAscentSpeedDataType` → `HKQuantityType(.stairAscentSpeed)`
- `StairDescentSpeedDataType` → `HKQuantityType(.stairDescentSpeed)`

#### Android Speed Data Type (Generic)

| Data Type    | Description                               | Measurement Unit | Capabilities                     |
|--------------|-------------------------------------------|------------------|----------------------------------|
| Speed Series | Generic speed measurements as time series | Velocity         | Read, Write, Avg/Min/Max, Delete |

**Platform Mapping:**

- `SpeedSeriesDataType` → `SpeedRecord`

**Usage Note:** Speed series data captures multiple speed samples over a time interval, making it suitable for recording continuous speed data during workouts or activities.

## Type Safety

All health data operations are **compile-time type-safe** through generic constraints:

```dart
// Type parameters enforce correct pairing of data types, records, and units
class HealthDataType<R extends HealthRecord, U extends MeasurementUnit> {
  // ...
}

// Example: Weight data type is constrained to WeightRecord and Mass
final class WeightDataType extends HealthDataType<WeightRecord, Mass> {
  // ...
}
```

This design prevents runtime errors by ensuring:

- Records match their data types
- Measurement units match their data types
- Aggregation operations are only available for supported types

## Platform Support

### iOS HealthKit

All data types map to native HealthKit types:

- Quantity types (`HKQuantityType`)
- Category types (`HKCategoryType`)
- Correlation types (`HKCorrelationType`)
- Workout types (`HKWorkoutType`)

### Android Health Connect

All data types map to native Health Connect record types:

- Instant records (single timestamp)
- Interval records (time range)
- Series records (multiple samples)

## Capabilities

Each data type declares its capabilities through interface implementation:

### Readable

```dart
interface ReadableHealthDataType<R extends HealthRecord> {
  ReadRecordByIdRequest<R> readById(HealthRecordId id);
  ReadRecordsInTimeRangeRequest<R> readInTimeRange({...});
}
```

### Writeable

```dart
interface WriteableHealthDataType {
  HealthDataPermission get writePermission;
}
```

### Aggregatable

```dart
interface AvgAggregatableHealthDataType<R, U> {
  AggregateRequest<R, U> aggregateAvg({...});
}

interface SumAggregatableHealthDataType<R, U> {
  AggregateRequest<R, U> aggregateSum({...});
}

interface MinAggregatableHealthDataType<R, U> {
  AggregateRequest<R, U> aggregateMin({...});
}

interface MaxAggregatableHealthDataType<R, U> {
  AggregateRequest<R, U> aggregateMax({...});
}
```

### Deletable

```dart
interface DeletableHealthDataType {
  DeleteRecordsByIdsRequest deleteByIds(List<HealthRecordId> ids);
  DeleteRecordsInTimeRangeRequest deleteInTimeRange({...});
}
```

## Usage Examples

### Reading Data

```dart
// Read weight records from the last 7 days
final request = HealthDataType.weight.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

final response = await healthConnector.execute(request);
for (final record in response.records) {
  print('Weight: ${record.weight.value} ${record.weight.unit}');
}
```

### Aggregating Data

```dart
// Calculate average heart rate for today
final request = HealthDataType.heartRate.aggregateAvg(
  startTime: DateTime.now().startOfDay,
  endTime: DateTime.now(),
);

final response = await healthConnector.execute(request);
print('Average HR: ${response.value?.value} ${response.value?.unit}');
```

### Platform-Specific Speed Data

```dart
// iOS: Use activity-specific speed types
if (Platform.isIOS) {
  final walkingSpeedRequest = HealthDataType.walkingSpeed.readInTimeRange(
    startTime: startTime,
    endTime: endTime,
  );
}

// Android: Use generic speed series
if (Platform.isAndroid) {
  final speedRequest = HealthDataType.speedSeries.readInTimeRange(
    startTime: startTime,
    endTime: endTime,
  );
}
```
