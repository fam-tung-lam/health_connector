# Health Records

The Health Connector data model is built on three pillars:

1. **Health Records**: The actual data points (e.g., a weight measurement, an excercise session).
2. **Measurement Units**: Type-safe values that handle unit conversions automatically.
3. **Health Data Types**: Descriptors that define the properties and capabilities of each record
   type.

This design ensures that your code is compile-time type-safe, preventing
common errors like using the wrong unit or trying to aggregate unsupported
data types.

## Record Hierarchy

Health records are organized into a clear hierarchy based on their temporal
characteristics:

1. **Instant Records**: Measurements taken at a single point in time (e.g., `WeightRecord`,
   `BloodGlucoseRecord`).
2. **Interval Records**: Activities or measurements spanning a duration (e.g., `StepsRecord`,
   `SleepSessionRecord`).
3. **Series Records**: Multiple timestamped samples collected within a time interval (e.g.,
   `HeartRateSeriesRecord`).

### Common Properties

#### HealthRecordId

A type-safe identifier for health records:

- **New records**: Use `HealthRecordId.none` when creating a record to be written.
- **Existing records**: Contains the platform-assigned UUID when reading from the store.

```dart
// New record
final newRecord = WeightRecord(id: HealthRecordId.none, ...);

// Existing record
final existingId = HealthRecordId('550e8400-e29b-41d4-a716-446655440000');
```

#### Metadata

Describes the context of the record:

- **Recording method**: Manual entry (`Metadata.manualEntry()`), automatic (
  `Metadata.automaticallyRecorded()`), or unknown.
- **Device info**: Device manufacturer and model (optional for manual/unknown, required for others).

#### Timestamps & Timezones

- **Instant Records**: Single `time` property and `zoneOffsetSeconds`.
- **Interval/Series Records**: `startTime`, `endTime`, `startZoneOffsetSeconds`, and
  `endZoneOffsetSeconds`.

### Health Record Examples

#### Instant Record: Weight

```dart
final weightRecord = WeightRecord(
  id: HealthRecordId.none,
  time: DateTime.now(),
  zoneOffsetSeconds: 3600, // UTC+1
  weight: Mass.kilograms(72.5),
  metadata: Metadata.manualEntry(),
);
```

#### Interval Record: Steps

```dart
final stepsRecord = StepsRecord(
  id: HealthRecordId.none,
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  startZoneOffsetSeconds: 3600,
  endZoneOffsetSeconds: 3600,
  count: Number(1500),
  metadata: Metadata.automaticallyRecorded(),
);
```

#### Series Record: Heart Rate

```dart
final heartRateSeries = HeartRateSeriesRecord(
  id: HealthRecordId.none,
  startTime: DateTime.now().subtract(Duration(minutes: 10)),
  endTime: DateTime.now(),
  startZoneOffsetSeconds: 3600,
  endZoneOffsetSeconds: 3600,
  samples: [
    HeartRateSample(
      time: DateTime.now().subtract(Duration(minutes: 10)),
      rate: Frequency.perMinute(65),
    ),
    HeartRateSample(
      time: DateTime.now(),
      rate: Frequency.perMinute(80),
    ),
  ],
  metadata: Metadata.automaticallyRecorded(),
);
```

#### Complex Record: Nutrition

```dart
final nutritionRecord = NutritionRecord(
  id: HealthRecordId.none,
  startTime: DateTime.now(),
  endTime: DateTime.now().add(Duration(minutes: 30)),
  mealType: MealType.lunch,
  energy: Energy.kilocalories(650),
  protein: Mass.grams(35),
  totalCarbohydrate: Mass.grams(75),
  metadata: Metadata.manualEntry(),
);
```

## Measurement Units

The SDK uses immutable, type-safe measurement unit classes that handle
automatic conversions. This prevents mixing incompatible units (e.g.,
adding meters to kilograms) and eliminates conversion errors.

### Quick Reference

| Type           | Units                     | Base Unit  | Common Use Cases             |
|:---------------|:--------------------------|:-----------|:-----------------------------|
| `Mass`         | kg, g, lb, oz             | kg         | Body weight, nutrition       |
| `Energy`       | kcal, cal, kJ, J          | kcal       | Calories burned, nutrition   |
| `Frequency`    | Hz, events/min            | events/min | Heart rate, respiratory rate |
| `Length`       | m, km, cm, mm, mi, ft, in | m          | Distance, height             |
| `Volume`       | L, mL, fl oz (US/Imp)     | L          | Hydration, fluids            |
| `Temperature`  | °C, °F, K                 | °C         | Body temperature             |
| `Pressure`     | mmHg, Pa                  | mmHg       | Blood pressure               |
| `BloodGlucose` | mmol/L, mg/dL             | mmol/L     | Glucose monitoring           |
| `Number`       | value                     | N/A        | Steps, counts                |
| `Percentage`   | decimal, whole            | decimal    | Body fat, O₂ saturation      |
| `Power`        | W, kW                     | W          | Exercise power               |
| `TimeDuration` | s, min, h                 | s          | Sleep, exercise duration     |
| `Velocity`     | m/s, km/h, mph            | m/s        | Speed                        |

### Usage Example

```dart
// Mass
final weight = Mass.pounds(155.4);
print(weight.inKilograms); // ~70.5

// Length
final height = Length.feet(5) + Length.inches(10);
print(height.inCentimeters); // ~177.8

// Energy
final energy = Energy.kilocalories(2000);
print(energy.inKilojoules); // ~8368.0
```

## Health Data Types

Health Connector provides strongly-typed access to health data. Each
`HealthDataType` is a constant that links a specific record class to its
measurement unit and platform capabilities.

### Type Safety

All health data operations are **compile-time type-safe** through generic constraints:

```dart
// Type parameters enforce correct pairing of data types, records, and units
class HealthDataType<R extends HealthRecord, U extends MeasurementUnit> {
  // ...
}

// Example: Weight data type is constrained to `WeightRecord` and `Mass`
final class WeightDataType extends HealthDataType<WeightRecord, Mass> {
  // ...
}
```

This design prevents runtime errors by ensuring:

- Records match their data types.
- Measurement units match their data types.
- Aggregation operations are only available for supported types.

### Capabilities

Each data type declares its capabilities through interface implementation.
This allows you to check what operations are supported at compile time.

- **Readable**: Can be read using `readById` or `readInTimeRange`.
- **Writeable**: Can be written; exposes a `writePermission`.
- **Aggregatable**: Supports aggregation operations like `Sum`, `Avg`, `Min`, `Max`.
- **Deletable**: Can be deleted by ID or time range.

### Platform Support

- **iOS HealthKit**: Maps to native types like `HKQuantityType`,
  `HKCategoryType`, `HKCorrelationType`, and `HKWorkoutType`.
- **Android Health Connect**: Maps to native Health Connect record types
  (Instant, Interval,
  Series).

---
