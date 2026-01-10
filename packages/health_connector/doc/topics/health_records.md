# Health Records

Health records are individual data points that represent health measurements. They form the core
data model of the Health Connector package, providing a unified abstraction over Android Health
Connect and iOS HealthKit.

## Overview

The health records system organizes measurements into a clear hierarchy based on their temporal
characteristics:

- **Instant Records**: Single-point measurements at a specific time
- **Interval Records**: Measurements spanning a time duration
- **Series Records**: Multiple timestamped samples within a time interval

## Common Properties

All health records share these fundamental properties:

### HealthRecordId

A type-safe identifier for health records:

- For **new records** (not yet written): Use `HealthRecordId.none`
- For **existing records** (read from platform): Contains platform-assigned UUID

```dart
// New record
final newRecord = WeightRecord(
  id: HealthRecordId.none,
  // ... other fields
);

// Existing record (from platform)
final existingId = HealthRecordId('550e8400-e29b-41d4-a716-446655440000');
```

### Metadata

Describes the context and origin of the record:

- **Data origin**: Package name or app that created the record
- **Recording method**: Manual entry, automatic recording, or unknown
- **Device info**: Optional device identification

```dart
Metadata.manualEntry(
  dataOrigin: DataOrigin(packageName: 'com.example.app'),
)

Metadata.automaticallyRecorded(
  dataOrigin: DataOrigin(packageName: 'com.example.fitness'),
  device: Device(manufacturer: 'Apple', model: 'Apple Watch'),
)
```

### Timestamps

Each record type has appropriate timestamps:

- **Instant Records**: Single `time` property
- **Interval Records**: `startTime` and `endTime` properties
- **Series Records**: `startTime`, `endTime`, plus individual sample times

### Zone Offsets

Timezone offsets (in seconds from UTC) preserve the local time context:

- **Instant Records**: `zoneOffsetSeconds`
- **Interval Records**: `startZoneOffsetSeconds` and `endZoneOffsetSeconds`
- Positive for timezones ahead of UTC (e.g., +3600 for UTC+1)
- Negative for timezones behind UTC (e.g., -28800 for UTC-8)

> [!IMPORTANT]
> **iOS HealthKit limitation**: On iOS, both start and end zone offsets will be the same, even if 
> an interval spans a timezone change. This is because HealthKit only provides one timezone 
> metadata field.

## Instant Health Records

**Definition**: Measurements taken at a single point in time.

**Platform Mapping**:

- **Android Health Connect**: `InstantRecord` subclasses
- **iOS HealthKit**: `HKQuantitySample` or `HKCategorySample` with identical start and end dates

### Example: Weight Record

```dart
final weightRecord = WeightRecord(
  id: HealthRecordId.none,
  time: DateTime.now(),
  zoneOffsetSeconds: 3600, // UTC+1
  weight: Mass.kilograms(72.5),
  metadata: Metadata.manualEntry(
    dataOrigin: DataOrigin(packageName: 'com.example.app'),
  ),
);
```

### Example: Blood Glucose Record

Blood glucose records include contextual properties:

```dart
final glucoseRecord = BloodGlucoseRecord(
  id: HealthRecordId.none,
  time: DateTime.now(),
  bloodGlucose: BloodGlucose.millimolesPerLiter(5.5),
  relationToMeal: BloodGlucoseRelationToMeal.fasting,
  mealType: BloodGlucoseMealType.breakfast,
  specimenSource: BloodGlucoseSpecimenSource.capillaryBlood,
  metadata: Metadata.manualEntry(
    dataOrigin: DataOrigin(packageName: 'com.example.app'),
  ),
);
```

## Interval Health Records

**Definition**: Measurements or activities spanning a duration of time.

**Platform Mapping**:

- **Android Health Connect**: `IntervalRecord` subclasses
- **iOS HealthKit**: `HKQuantitySample` with distinct start and end dates

### Example: Steps Record

```dart
final stepsRecord = StepsRecord(
  id: HealthRecordId.none,
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  startZoneOffsetSeconds: 3600, // UTC+1
  endZoneOffsetSeconds: 3600,   // UTC+1
  count: Number(1500),
  metadata: Metadata.automaticallyRecorded(
    dataOrigin: DataOrigin(packageName: 'com.example.fitness'),
  ),
);

// Duration is automatically calculated
print(stepsRecord.duration); // 1:00:00.000000
```

### Timezone Handling

Interval records can span timezone changes:

```dart
final travelSteps = StepsRecord(
  startTime: DateTime.utc(2024, 1, 15, 10, 0), // 10:00 UTC
  endTime: DateTime.utc(2024, 1, 15, 16, 0),   // 16:00 UTC
  startZoneOffsetSeconds: 0,      // Started in UTC timezone
  endZoneOffsetSeconds: -28800,   // Ended in UTC-8 (traveled west)
  count: Number(8000),
  metadata: Metadata.automaticallyRecorded(
    dataOrigin: DataOrigin(packageName: 'com.example.fitness'),
  ),
);
```

## Series Health Records

**Definition**: Multiple timestamped samples collected within a time interval.

**Platform Mapping**:

- **Android Health Connect**: `SeriesRecord` subclasses (native support)
- **iOS HealthKit**: `HKQuantitySeries` or aggregation of multiple `HKQuantitySample` objects

> [!WARNING]
> Series records have better support on Android Health Connect. On iOS, they may require aggregating individual samples, which can affect performance.

### Example: Heart Rate Series

```dart
final heartRateSeries = HeartRateSeriesRecord(
  id: HealthRecordId.none,
  startTime: DateTime.now().subtract(Duration(minutes: 10)),
  endTime: DateTime.now(),
  startZoneOffsetSeconds: 3600,
  endZoneOffsetSeconds: 3600,
  samples: [
    HeartRateMeasurement(
      time: DateTime.now().subtract(Duration(minutes: 10)),
      beatsPerMinute: Number(65),
    ),
    HeartRateMeasurement(
      time: DateTime.now().subtract(Duration(minutes: 5)),
      beatsPerMinute: Number(120),
    ),
    HeartRateMeasurement(
      time: DateTime.now(),
      beatsPerMinute: Number(80),
    ),
  ],
  metadata: Metadata.automaticallyRecorded(
    dataOrigin: DataOrigin(packageName: 'com.example.fitness'),
    device: Device(manufacturer: 'Apple', model: 'Apple Watch'),
  ),
);

// Computed properties
print(heartRateSeries.samplesCount);  // 3
print(heartRateSeries.averageBpm);    // 88
print(heartRateSeries.minBpm);        // 65
print(heartRateSeries.maxBpm);        // 120
```

## Complex Health Records

Some health records include additional contextual or composite data.

### Blood Pressure Record

Composite record containing both systolic and diastolic measurements:

```dart
final bpRecord = BloodPressureRecord(
  id: HealthRecordId.none,
  time: DateTime.now(),
  systolic: Pressure.millimetersOfMercury(120),
  diastolic: Pressure.millimetersOfMercury(80),
  bodyPosition: BloodPressureBodyPosition.sitting,
  measurementLocation: BloodPressureMeasurementLocation.leftUpperArm,
  metadata: Metadata.manualEntry(
    dataOrigin: DataOrigin(packageName: 'com.example.app'),
  ),
);
```

### Nutrition Record

Contains multiple nutrient measurements:

```dart
final nutritionRecord = NutritionRecord(
  id: HealthRecordId.none,
  startTime: DateTime.now(),
  endTime: DateTime.now().add(Duration(minutes: 30)),
  mealType: MealType.lunch,
  energy: Energy.kilocalories(650),
  protein: Mass.grams(35),
  totalCarbohydrate: Mass.grams(75),
  totalFat: Mass.grams(20),
  saturatedFat: Mass.grams(5),
  sugar: Mass.grams(15),
  dietaryFiber: Mass.grams(8),
  sodium: Mass.milligrams(800),
  // ... additional nutrients
  metadata: Metadata.manualEntry(
    dataOrigin: DataOrigin(packageName: 'com.example.nutrition'),
  ),
);
```

## Record Categories

### Body Measurements

| Record Type               | Category | Measurement      |
|---------------------------|----------|------------------|
| `WeightRecord`            | Instant  | Body weight      |
| `HeightRecord`            | Instant  | Height           |
| `BodyFatPercentageRecord` | Instant  | Body fat %       |
| `LeanBodyMassRecord`      | Instant  | Lean mass        |
| `BodyTemperatureRecord`   | Instant  | Core temperature |

### Vital Signs

| Record Type                  | Category | Measurement        |
|------------------------------|----------|--------------------|
| `HeartRateMeasurementRecord` | Instant  | Single BPM reading |
| `HeartRateSeriesRecord`      | Series   | BPM over time      |
| `RestingHeartRateRecord`     | Instant  | Resting BPM        |
| `BloodPressureRecord`        | Instant  | Systolic/diastolic |
| `OxygenSaturationRecord`     | Instant  | Blood oxygen %     |
| `RespiratoryRateRecord`      | Instant  | Breaths per minute |
| `Vo2MaxRecord`               | Instant  | VO₂ max            |

### Activity & Exercise

| Record Type                    | Category | Measurement        |
|--------------------------------|----------|--------------------|
| `StepsRecord`                  | Interval | Step count         |
| `FloorsClimbedRecord`          | Interval | Floors climbed     |
| `ActiveEnergyBurnedRecord`   | Interval | Active calories    |
| `WheelchairPushesRecord`       | Interval | Wheelchair pushes  |
| `DistanceRecord`               | Interval | Distance (generic) |
| `WalkingRunningDistanceRecord` | Interval | Walking/running    |
| `CyclingDistanceRecord`        | Interval | Cycling distance   |
| `SwimmingDistanceRecord`       | Interval | Swimming distance  |

### Sleep

| Record Type          | Category | Measurement                   |
|----------------------|----------|-------------------------------|
| `SleepSessionRecord` | Interval | Overall sleep session         |
| `SleepStageRecord`   | Interval | Sleep stage (REM, deep, etc.) |

### Nutrition

| Record Type              | Category | Measurement          |
|--------------------------|----------|----------------------|
| `NutritionRecord`        | Interval | Complete meal/snack  |
| `HydrationRecord`        | Interval | Water intake         |
| `DietaryEnergyRecord`   | Interval | Calories only        |
| `ProteinNutrientRecord`  | Interval | Protein only         |
| Various nutrient records | Interval | Individual nutrients |

### Speed

| Record Type               | Category | Measurement          |
|---------------------------|----------|----------------------|
| `SpeedSeriesRecord`       | Series   | Speed over time      |
| `WalkingSpeedRecord`      | Instant  | Walking speed        |
| `RunningSpeedRecord`      | Instant  | Running speed        |
| `StairAscentSpeedRecord`  | Instant  | Stair climbing speed |
| `StairDescentSpeedRecord` | Instant  | Stair descent speed  |

## Platform Considerations

### Android Health Connect

- **Native support** for instant, interval, and series records
- **Timezone offsets** fully supported with separate start/end offsets
- **Rich metadata** including data origin, device info, recording method
- **Series records** efficiently stored and retrieved
- Requires Android 9+ (API level 28+)

### iOS HealthKit

- Maps instant/interval records to `HKQuantitySample` or `HKCategorySample`
- **Single timezone** metadata (`HKMetadataKeyTimeZone`) means start and end offsets are always
  identical
- **Series records** implemented via `HKQuantitySeries` (less direct support)
- Some record types may have limited metadata compared to Android
- Available on iOS 8.0+
