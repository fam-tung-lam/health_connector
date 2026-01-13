# Migration Guide: `v2.x.x` → `v3.0.0`

This guide helps you migrate your Flutter health data integration from health_connector `v2.x.x` to
`v3.0.0`.

---

## Table of Contents

- [Overview](#overview)
- [Breaking Changes](#breaking-changes)
  - [1. Logging System Redesign](#1-logging-system-redesign)
  - [2. API Renaming](#2-api-renaming)
  - [3. Health Record Property Type Changes](#3-health-record-property-type-changes)
  - [4. Meal Type Unification](#4-meal-type-unification)
  - [5. Metadata Constructor Changes](#5-metadata-constructor-changes)
  - [6. Exception Hierarchy & Error Handling](#6-exception-hierarchy--error-handling)
- [New Features in `v3.0.0`](#new-features-in-v300)

---

## Overview

**Difficulty**: Moderate

`v3.0.0` represents a major release focused on API consistency, scientific accuracy, and developer
experience. The release includes a complete logging system overhaul, extensive naming
standardization, and new validation enforcement for data integrity.

**Estimated migration time**: 30 minutes for typical applications

---

## Breaking Changes

### 1. Logging System Redesign

**Difficulty**: Moderate

The logging system has been completely redesigned from a stream-based architecture to a
processor-based pattern. This provides better performance, more flexibility, and a cleaner API.

#### What Changed

| `v2.x.x` API                              | `v3.0.0` API                          | Change Type           |
|-------------------------------------------|---------------------------------------|-----------------------|
| `HealthConnectorConfig.isLoggerEnabled`   | `HealthConnectorConfig.loggerConfig`  | Config parameter      |
| `HealthConnectorLogger.logs` (Stream)     | `HealthConnectorLogProcessor` pattern | Architecture redesign |
| `HealthConnectorLogger.instance` (public) | `HealthConnectorLogger` (internal)    | API visibility        |

#### Migration Steps

**Before (`v2.x.x`) - Stream-based logging:**

```dart
// `v2.x.x` - Boolean flag and stream subscription
const config = HealthConnectorConfig(
  isLoggerEnabled: true, // Simple boolean flag
);

final connector = await HealthConnector.create(config: config);

// Subscribe to log stream
final subscription = HealthConnectorLogger.instance.logs.listen((log) {
  print('[${log.level}] ${log.message}');
  if (log.error != null) {
    print('Error: ${log.error}');
  }
});
```

**After (`v3.0.0`) - Processor-based logging:**

```dart
// `v3.0.0` - Processor pattern with built-in processors
const config = HealthConnectorConfig(
  loggerConfig: HealthConnectorLoggerConfig(
    enableNativeLogging: false, // Optional: forward native logs
    logProcessors: [
      // Built-in processor for warnings/errors
      PrintLogProcessor(
        levels: [
          HealthConnectorLogLevel.warning,
          HealthConnectorLogLevel.error,
        ],
      ),

      // Built-in processor using dart:developer
      DeveloperLogProcessor(
        levels: HealthConnectorLogLevel.values, // All levels
      ),
    ],
  ),
);

final connector = await HealthConnector.create(config: config);

// No subscription needed! Processors handle logs automatically
// No cleanup needed either - processors are configuration, not subscriptions
```

**Custom Processor Example:**

```dart
// Create a custom processor for your needs
class FileLogProcessor extends HealthConnectorLogProcessor {
  final File logFile;

  const FileLogProcessor({
    required this.logFile,
    super.levels = HealthConnectorLogLevel.values,
  });

  @override
  Future<void> process(HealthConnectorLog log) async {
    try {
      final formatted = '${log.dateTime} [${log.level.name.toUpperCase()}] '
                       '${log.message}\n';
      await logFile.writeAsString(formatted, mode: FileMode.append);
    } catch (e) {
      // Handle errors gracefully - don't throw
      debugPrint('Failed to write log: $e');
    }
  }

  @override
  bool shouldProcess(HealthConnectorLog log) {
    // Custom filtering: only errors during business hours
    final isBusinessHours = log.dateTime.hour >= 9 && log.dateTime.hour < 17;
    return super.shouldProcess(log) &&
           log.level == HealthConnectorLogLevel.error &&
           isBusinessHours;
  }
}

// Use it in config
const config = HealthConnectorConfig(
  loggerConfig: HealthConnectorLoggerConfig(
    logProcessors: [
      FileLogProcessor(logFile: File('/path/to/app.log')),
    ],
  ),
);
```

#### Why This Change?

- **Zero-Cost Abstraction**: No stream overhead when logging is disabled or no processors registered
- **Multiple Destinations**: Route logs to console, files, analytics, remote services simultaneously
- **Flexible Filtering**: Each processor has its own level-based and custom filtering
- **Better Performance**: No stream controller, no broadcast overhead, no subscription management
- **Simpler API**: Configure once at initialization vs managing subscriptions throughout app
  lifecycle
- **No Memory Leaks**: No forgotten subscription cancellations

---

### 2. API Renaming

`v3.0.0` includes extensive API renaming for consistency, scientific accuracy, and platform
alignment. All renaming changes are grouped in this section.

---

#### 2.1 Property Name Standardization

**Difficulty**: Simple

Property names have been standardized to eliminate "stuttering" (class name repetition in
properties) and unit coupling (units baked into property names). This improves API ergonomics and
enables natural reading patterns.

##### What Changed

**Property Naming Patterns:**

- Eliminated stuttering: `bodyMassIndex` → `bmi`
- Removed unit coupling: `beatsPerMinute` → `rate`
- Domain-natural names: `bloodGlucose` → `glucoseLevel`
- Simplified nutrition: `nutritionValue` → `value`

##### Complete Rename Table

| Record Type                       | `v2.x.x` Property            | `v3.0.0` Property  | Rationale            |
|-----------------------------------|------------------------------|--------------------|----------------------|
| **Body Measurements**             |
| `BodyMassIndexRecord`             | `bodyMassIndex`              | `bmi`              | Eliminate stuttering |
| **Heart & Respiratory**           |
| `HeartRateRecord`                 | `beatsPerMinute`             | `rate`             | Remove unit coupling |
| `RestingHeartRateRecord`          | `beatsPerMinute`             | `rate`             | Remove unit coupling |
| `RespiratoryRateRecord`           | `breathsPerMinute`           | `rate`             | Remove unit coupling |
| `HeartRateVariabilityRMSSDRecord` | `heartRateVariabilityMillis` | `rmssd`            | Eliminate stuttering |
| `HeartRateVariabilitySDNNRecord`  | `heartRateVariabilitySDNN`   | `sdnn`             | Eliminate stuttering |
| **Activity & Movement**           |
| `FloorsClimbedRecord`             | `floors`                     | `count`            | Consistent naming    |
| `WheelchairPushesRecord`          | `pushes`                     | `count`            | Consistent naming    |
| `CyclingPedalingCadenceRecord`    | `revolutionsPerMinute`       | `cadence`          | Remove unit coupling |
| **Vitals**                        |
| `BloodGlucoseRecord`              | `bloodGlucose`               | `glucoseLevel`     | Domain-natural name  |
| `OxygenSaturationRecord`          | `percentage`                 | `saturation`       | Remove unit coupling |
| `Vo2MaxRecord`                    | `mLPerKgPerMin`              | `vo2MlPerMinPerKg` | Clearer abbreviation |
| **Nutrition**                     |
| All nutrient records              | `nutritionValue`             | `value`            | Eliminate stuttering |
| `DietaryEnergyConsumedRecord`     | `nutritionValue`             | `energy`           | Domain-natural name  |

##### Migration Examples

**Example 1: Heart Rate**

```dart
// `v2.x.x`
final record = HeartRateMeasurementRecord(
  time: DateTime.now(),
  beatsPerMinute: Frequency.perMinute(72),
  metadata: Metadata.manualEntry(),
);
print('Heart rate: ${record.beatsPerMinute.inPerMinute} bpm');

// `v3.0.0`
final record = HeartRateRecord(
  time: DateTime.now(),
  rate: Frequency.perMinute(72), // Renamed property
  metadata: Metadata.manualEntry(),
);
print('Heart rate: ${record.rate.inPerMinute} bpm'); // Natural reading
```

**Example 2: Body Mass Index**

```dart
// `v2.x.x`
final record = BodyMassIndexRecord(
  time: DateTime.now(),
  bodyMassIndex: Numeric(24.5), // Stuttering: "bodyMassIndex" in "BodyMassIndexRecord"
  metadata: Metadata.manualEntry(),
);

// `v3.0.0`
final record = BodyMassIndexRecord(
  time: DateTime.now(),
  bmi: Numeric(24.5), // Clean, no stuttering
  metadata: Metadata.manualEntry(),
);
```

##### Why This Change?

- **Improved Readability**: `record.rate.inPerMinute` is more natural than
  `record.beatsPerMinute.inPerMinute`
- **Eliminated Redundancy**: No more stuttering like `bodyMassIndex` in `BodyMassIndexRecord`
- **Unit Flexibility**: Units are in the measurement type, not the property name
- **Platform Alignment**: Matches iOS HealthKit and Android Health Connect property naming
- **Better API Ergonomics**: Shorter, clearer property names

---

#### 2.2 Record Type Renames: "Calories" → "Energy"

**Difficulty**: Simple

"Calories" has been renamed to "Energy" for scientific accuracy and platform alignment. Calories are
a unit of energy measurement, not the physical quantity itself.

##### What Changed

| `v2.x.x` Type                         | `v3.0.0` Type                       |
|---------------------------------------|-------------------------------------|
| `ActiveCaloriesBurnedRecord`          | `ActiveEnergyBurnedRecord`          |
| `ActiveCaloriesBurnedHealthDataType`  | `ActiveEnergyBurnedDataType`        |
| `TotalCaloriesBurnedRecord`           | `TotalEnergyBurnedRecord`           |
| `TotalCaloriesBurnedHealthDataType`   | `TotalEnergyBurnedDataType`         |
| `HealthDataType.activeCaloriesBurned` | `HealthDataType.activeEnergyBurned` |
| `HealthDataType.totalCaloriesBurned`  | `HealthDataType.totalEnergyBurned`  |

##### Migration Steps

**Before (`v2.x.x`):**

```dart
// `v2.x.x` - "Calories" terminology
final record = ActiveCaloriesBurnedRecord(
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  energy: Energy.kilocalories(350.0),
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.watch),
  ),
);

await connector.writeRecord(record);

// Read active calories
final request = HealthDataType.activeCaloriesBurned.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);
```

**After (`v3.0.0`):**

```dart
// `v3.0.0` - "Energy" terminology
final record = ActiveEnergyBurnedRecord( // Renamed class
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  energy: Energy.kilocalories(350.0), // Energy unit unchanged
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.watch),
  ),
);

await connector.writeRecord(record);

// Read active energy
final request = HealthDataType.activeEnergyBurned.readInTimeRange( // Renamed accessor
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);
```

##### Why This Change?

- **Scientific Accuracy**: Energy is the correct physical quantity; calories are just one unit
- **Platform Alignment**: Matches iOS HealthKit terminology (`activeEnergyBurned`)
- **International Support**: Energy can be expressed in calories, kilojoules, or other units
- **Clearer Semantics**: Separates quantity (energy) from unit (calories, kilojoules)

---

#### 2.3 Record Type Renames: "Nutrient" → "Dietary"

**Difficulty**: Simple

All individual nutrient record types have been renamed from `*Nutrient*` to `Dietary*` to align with
health platform naming conventions (both iOS HealthKit and Android Health Connect use "Dietary"
prefix).

##### What Changed

**Pattern**: `{Nutrient}NutrientRecord` → `Dietary{Nutrient}Record`

| `v2.x.x` Type                      | `v3.0.0` Type                     |
|------------------------------------|-----------------------------------|
| **Macronutrients**                 |
| `ProteinNutrientRecord`            | `DietaryProteinRecord`            |
| `TotalCarbohydrateNutrientRecord`  | `DietaryTotalCarbohydrateRecord`  |
| `TotalFatNutrientRecord`           | `DietaryTotalFatRecord`           |
| `DietaryFiberNutrientRecord`       | `DietaryFiberRecord`              |
| `SugarNutrientRecord`              | `DietarySugarRecord`              |
| `SaturatedFatNutrientRecord`       | `DietarySaturatedFatRecord`       |
| `MonounsaturatedFatNutrientRecord` | `DietaryMonounsaturatedFatRecord` |
| `PolyunsaturatedFatNutrientRecord` | `DietaryPolyunsaturatedFatRecord` |
| `CholesterolNutrientRecord`        | `DietaryCholesterolRecord`        |
| **Vitamins**                       |
| `VitaminANutrientRecord`           | `DietaryVitaminARecord`           |
| `VitaminB6NutrientRecord`          | `DietaryVitaminB6Record`          |
| `VitaminB12NutrientRecord`         | `DietaryVitaminB12Record`         |
| `VitaminCNutrientRecord`           | `DietaryVitaminCRecord`           |
| `VitaminDNutrientRecord`           | `DietaryVitaminDRecord`           |
| `VitaminENutrientRecord`           | `DietaryVitaminERecord`           |
| `VitaminKNutrientRecord`           | `DietaryVitaminKRecord`           |
| `ThiaminNutrientRecord`            | `DietaryThiaminRecord`            |
| `RiboflavinNutrientRecord`         | `DietaryRiboflavinRecord`         |
| `NiacinNutrientRecord`             | `DietaryNiacinRecord`             |
| `PantothenicAcidNutrientRecord`    | `DietaryPantothenicAcidRecord`    |
| `BiotinNutrientRecord`             | `DietaryBiotinRecord`             |
| `FolateNutrientRecord`             | `DietaryFolateRecord`             |
| **Minerals**                       |
| `CalciumNutrientRecord`            | `DietaryCalciumRecord`            |
| `IronNutrientRecord`               | `DietaryIronRecord`               |
| `MagnesiumNutrientRecord`          | `DietaryMagnesiumRecord`          |
| `PhosphorusNutrientRecord`         | `DietaryPhosphorusRecord`         |
| `PotassiumNutrientRecord`          | `DietaryPotassiumRecord`          |
| `SodiumNutrientRecord`             | `DietarySodiumRecord`             |
| `ZincNutrientRecord`               | `DietaryZincRecord`               |
| `SeleniumNutrientRecord`           | `DietarySeleniumRecord`           |
| `ManganeseNutrientRecord`          | `DietaryManganeseRecord`          |
| **Other**                          |
| `CaffeineNutrientRecord`           | `DietaryCaffeineRecord`           |
| `EnergyNutrientRecord`             | `DietaryEnergyConsumedRecord`     |

**Data Type Pattern**: Same rename applies to data types

- `ProteinNutrientDataType` → `DietaryProteinDataType`
- `HealthDataType.proteinNutrient` → `HealthDataType.dietaryProtein`

##### Migration Steps

**Before (`v2.x.x`):**

```dart
// `v2.x.x` - "Nutrient" naming
final protein = ProteinNutrientRecord(
  startTime: mealTime,
  endTime: mealTime.add(Duration(hours: 1)),
  nutritionValue: Mass.grams(25.0),
  mealType: MealType.lunch,
  metadata: Metadata.manualEntry(),
);

// Read nutrients
final request = HealthDataType.proteinNutrient.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 1)),
  endTime: DateTime.now(),
);
```

**After (`v3.0.0`):**

```dart
// `v3.0.0` - "Dietary" naming
final protein = DietaryProteinRecord( // Renamed
  startTime: mealTime,
  endTime: mealTime.add(Duration(hours: 1)),
  value: Mass.grams(25.0), // Also renamed property!
  mealType: MealType.lunch,
  metadata: Metadata.manualEntry(),
);

// Read nutrients
final request = HealthDataType.dietaryProtein.readInTimeRange( // Renamed
  startTime: DateTime.now().subtract(Duration(days: 1)),
  endTime: DateTime.now(),
);
```

##### Why This Change?

- **Platform Alignment**: Both iOS HealthKit and Android Health Connect use "Dietary" prefix
- **Consistency**: Unified terminology across platforms
- **Clarity**: "Dietary" explicitly indicates food/drink consumption vs supplements
- **API Cohesion**: Matches platform APIs developers may use directly

---

#### 2.4 Heart Rate API Renaming

**Difficulty**: Simple

The heart rate API has been simplified by removing redundant "Measurement" suffix and standardizing
property names.

##### What Changed

| `v2.x.x`                                    | `v3.0.0`                         |
|---------------------------------------------|----------------------------------|
| `HeartRateMeasurementRecord`                | `HeartRateRecord`                |
| `HeartRateMeasurementRecordDataType`        | `HeartRateDataType`              |
| `HeartRateSeriesRecordDataType`             | `HeartRateSeriesDataType`        |
| `HealthDataType.heartRateMeasurementRecord` | `HealthDataType.heartRate`       |
| `HealthDataType.heartRateSeriesRecord`      | `HealthDataType.heartRateSeries` |
| `record.beatsPerMinute`                     | `record.rate`                    |

##### Migration

```dart
// `v2.x.x`
final record = HeartRateMeasurementRecord(
  time: DateTime.now(),
  beatsPerMinute: Frequency.perMinute(72),
  metadata: Metadata.manualEntry(),
);

// `v3.0.0`
final record = HeartRateRecord(
  time: DateTime.now(),
  rate: Frequency.perMinute(72),
  metadata: Metadata.manualEntry(),
);
```

---

#### 2.5 Health Data Type Renaming

**Difficulty**: Simple

Removed redundant "Health" prefix from data type names.

##### What Changed

**Pattern**: `*HealthDataType` → `*DataType`

```dart
// `v2.x.x`
WeightHealthDataType
HeightHealthDataType
BloodGlucoseHealthDataType

// `v3.0.0`
WeightDataType
HeightDataType
BloodGlucoseDataType
```

---

#### 2.6 Enum Renaming

**Difficulty**: Simple

Removed redundant "Type" suffix from enum names following Dart naming conventions.

##### What Changed

| `v2.x.x`                           | `v3.0.0`                       |
|------------------------------------|--------------------------------|
| `CervicalMucusAppearanceType`      | `CervicalMucusAppearance`      |
| `CervicalMucusSensationType`       | `CervicalMucusSensation`       |
| `MenstrualFlowType`                | `MenstrualFlow`                |
| `OvulationTestResultType`          | `OvulationTestResult`          |
| `SexualActivityProtectionUsedType` | `SexualActivityProtectionUsed` |

##### Migration

```dart
// `v2.x.x`
record.appearance == CervicalMucusAppearanceType.watery

// `v3.0.0`
record.appearance == CervicalMucusAppearance.watery
```

---

#### 2.7 Series Sample Class Renaming

**Difficulty**: Simple

Renamed "Measurement" suffix to "Sample" for time-series data, and "SleepStage" to
"SleepStageSample".

##### What Changed

| `v2.x.x`                | `v3.0.0`           |
|-------------------------|--------------------|
| `PowerMeasurement`      | `PowerSample`      |
| `SpeedMeasurement`      | `SpeedSample`      |
| `HeartRateMeasurement`  | `HeartRateSample`  |
| `SleepStage` (class)    | `SleepStageSample` |
| `SleepStageType` (enum) | `SleepStage`       |

---

### 3. Health Record Property Type Changes

**Difficulty**: Simple

Some health record properties have changed their types to use more appropriate measurement units.

#### Cycling Cadence: `Number` → `Frequency`

Simplified cycling cadence structure and changed to use `Frequency` measurement unit.

**Before:**

```dart
CyclingPedalingCadenceMeasurementRecord(
  time: DateTime.now(),
  measurement: CyclingPedalingCadenceMeasurement(
    revolutionsPerMinute: Number(85),
  ),
)
```

**After:**

```dart
CyclingPedalingCadenceRecord(
  time: DateTime.now(),
  cadence: Frequency.perMinute(85),
)
```

#### Heart Rate Variability: `Number` → `TimeDuration`

Heart rate variability changed from `Number` to `TimeDuration`:

**Before:**

```dart
// `v2.x.x`
HeartRateVariabilityRMSSDRecord(
  heartRateVariabilityMillis: Number(45.0),
)
```

**After:**

```dart
// `v3.0.0`
HeartRateVariabilityRMSSDRecord(
  rmssd: TimeDuration.milliseconds(45.0),
)
```

---

### 4. Meal Type Unification

**Difficulty**: Simple

Unified all meal type enums into single `MealType` enum across all records.

#### What Changed

Previously, different health records used separate meal type enums:

- `BloodGlucoseRecord` used `BloodGlucoseMealType` enum
- Nutrition records (e.g., `DietaryProteinRecord`) used `MealType` enum

In `v3.0.0`, all records now use a single unified `MealType` enum.

#### Migration Steps

**Before (`v2.x.x`) - Separate meal type enums:**

```dart
// `v2.x.x` - Blood glucose had its own enum
final glucoseRecord = BloodGlucoseRecord(
  time: DateTime.now(),
  bloodGlucose: BloodGlucose.millimolesPerLiter(5.5),
  mealType: BloodGlucoseMealType.breakfast, // Blood glucose-specific enum
  relationToMeal: BloodGlucoseRelationToMeal.afterMeal,
  metadata: Metadata.manualEntry(),
);

// `v2.x.x` - Nutrition records used different enum
final proteinRecord = ProteinNutrientRecord(
  startTime: DateTime.now(),
  endTime: DateTime.now().add(Duration(hours: 1)),
  nutritionValue: Mass.grams(25.0),
  mealType: MealType.breakfast, // Different enum with same name
  metadata: Metadata.manualEntry(),
);
```

**After (`v3.0.0`) - Single unified enum:**

```dart
// `v3.0.0` - Blood glucose uses unified MealType
final glucoseRecord = BloodGlucoseRecord(
  time: DateTime.now(),
  glucoseLevel: BloodGlucose.millimolesPerLiter(5.5),
  mealType: MealType.breakfast, // Unified MealType enum
  relationToMeal: BloodGlucoseRelationToMeal.afterMeal,
  metadata: Metadata.manualEntry(),
);

// `v3.0.0` - Nutrition records use same unified MealType
final proteinRecord = DietaryProteinRecord(
  startTime: DateTime.now(),
  endTime: DateTime.now().add(Duration(hours: 1)),
  value: Mass.grams(25.0),
  mealType: MealType.breakfast, // Same unified MealType enum
  metadata: Metadata.manualEntry(),
);
```

#### Why This Change?

- **Consistency**: Single enum for meal types across all health records
- **Simplified API**: No need to remember which enum to use for which record type
- **Reduced Duplication**: Eliminates redundant enum definitions with identical values

---

### 5. Metadata Constructor Changes

**Difficulty**: Simple

Removed non-functional `dataOrigin` parameter from `Metadata` constructors.

#### What Changed

The `dataOrigin` parameter has been removed from all `Metadata` constructor methods:

- `Metadata.manualEntry()`
- `Metadata.automaticallyRecorded()`
- `metadata.copyWith()`

#### Migration Steps

**Before (`v2.x.x`):**

```dart
// `v2.x.x` - dataOrigin parameter accepted but ignored
Metadata.manualEntry(
  dataOrigin: DataOrigin('com.example.app'), // Ignored by platform
)

Metadata.automaticallyRecorded(
  device: Device.fromType(DeviceType.watch),
  dataOrigin: DataOrigin('com.example.app'), // Ignored by platform
)

// copyWith also had dataOrigin parameter
metadata.copyWith(
  dataOrigin: DataOrigin('com.example.app'), // Ignored by platform
)
```

**After (`v3.0.0`):**

```dart
// `v3.0.0` - No dataOrigin parameter
Metadata.manualEntry()

Metadata.automaticallyRecorded(
  device: Device.fromType(DeviceType.watch),
)

// copyWith no longer accepts dataOrigin
metadata.copyWith(
  // dataOrigin parameter removed
)

// dataOrigin is now read-only and only present on retrieved records
final retrievedRecords = await connector.readRecords(...);
final origin = retrievedRecords.first.metadata.dataOrigin; // Nullable, set by platform
```

#### Why This Change?

- **Platform Behavior**: Both iOS HealthKit and Android Health Connect SDKs automatically assign
  `dataOrigin` internally based on the app's bundle identifier (iOS) or package name (Android).
  Custom `dataOrigin` values provided by callers were always ignored.
- **API Clarity**: Removing the non-functional parameter eliminates confusion and makes it clear
  that `dataOrigin` cannot be customized by the application.
- **Read-Only Property**: `dataOrigin` is now properly exposed as a read-only property that reflects
  the platform-assigned value when reading records from the health store.
- **Cleaner API**: Eliminates misleading parameters that had no effect on the stored data.

---

### 6. Exception Hierarchy & Error Handling

**Difficulty**: Moderate

The exception and error handling system has been refactored to provide a unified, platform-agnostic
taxonomy. The new hierarchy better aligns with platform-specific errors while providing a consistent
API across iOS and Android.

#### 6.1 Renamed Error Codes

The `HealthConnectorErrorCode` enum has been updated to use more descriptive and platform-neutral names.

| `v2.x.x` Code                                | `v3.0.0` Code                               |
|----------------------------------------------|---------------------------------------------|
| `healthPlatformUnavailable`                  | `healthServiceUnavailable`                  |
| `healthPlatformNotInstalledOrUpdateRequired` | `healthServiceNotInstalledOrUpdateRequired` |
| `invalidConfiguration`                       | `permissionNotDeclared`                     |
| `notAuthorized`                              | `permissionNotGranted`                      |
| `unknown`                                    | `unknownError`                              |
| `syncTokenExpired`                           | `invalidArgument`                           |

#### 6.2 Removed & Replaced Exceptions

Several specific exception classes have been removed and replaced with more general, categorized exceptions. You can identify the specific error using the `code` property.

| `v2.x.x` Exception                                    | `v3.0.0` Replacement                | Identification (`e.code`)                                                   |
|-------------------------------------------------------|-------------------------------------|-----------------------------------------------------------------------------|
| `NotAuthorizedException`                              | `AuthorizationException`            | `permissionNotGranted`                                                      |
| `InvalidConfigurationException`                       | `ConfigurationException`            | `permissionNotDeclared`                                                     |
| `HealthPlatformUnavailableException`                  | `HealthServiceUnavailableException` | `healthServiceUnavailable`                                                  |
| `HealthPlatformNotInstalledOrUpdateRequiredException` | `HealthServiceUnavailableException` | `healthServiceNotInstalledOrUpdateRequired`                                 |
| `RemoteErrorException`                                | `HealthServiceException`            | `remoteError`, `ioError`, `rateLimitExceeded`, `dataSyncInProgress`         |
| `SyncTokenExpiredException`                           | `InvalidArgumentException`          | `invalidArgument`                                                           |

#### 6.3 Migration Examples

**Example 1: Handling Permissions**

```dart
// `v2.x.x`
try {
  await connector.writeRecord(record);
} on NotAuthorizedException catch (e) {
  // Handle permission denied
}

// `v3.0.0`
try {
  await connector.writeRecord(record);
} on AuthorizationException catch (e) {
  // Handle permission denied (code: permissionNotGranted)
}
```

**Example 2: Handling Service Availability**

```dart
// `v2.x.x`
try {
  // ...
} on HealthPlatformUnavailableException {
  // Handle unavailable
} on HealthPlatformNotInstalledOrUpdateRequiredException {
  // Handle not installed
}

// `v3.0.0`
try {
  // ...
} on HealthServiceUnavailableException catch (e) {
  if (e.code == HealthConnectorErrorCode.healthServiceNotInstalledOrUpdateRequired) {
    // Handle not installed
  } else {
    // Handle unavailable
  }
}
```

**Example 3: Handling Remote/IO Errors**

```dart
// `v2.x.x`
try {
  // ...
} on RemoteErrorException {
  // Handle temporary failures
}

// `v3.0.0`
try {
  // ...
} on HealthServiceException catch (e) {
  // Handle operational errors (remote, IO, rate limit, sync in progress)
}
```

---

## New Features in `v3.0.0`

### 1. Incremental Sync API

**The most significant addition in v3.0.0.**

The new Incremental Sync API transforms how your app synchronizes health data. Instead of inefficiently querying time ranges and manually deduplicating data, you can now simply ask for *"what changed since last time"*.

**Why it's a game changer:**

- **Maximum Efficiency**: Drastically reduces bandwidth and processing power by fetching **only** deltas (new, modified, or deleted records).
- **Data Integrity**: Automatically tracks deleted records so you can remove them from your local database—a feature previously difficult to implement reliably.
- **Better UX**: Faster syncs mean a more responsive app and less battery impact.

Efficient delta syncing with change tokens:

```dart
Future<void> syncHealthData() async {
  // 1. Load existing token (if any)
  // If null, the sync will act as an Initial Sync (Baseline)
  HealthDataSyncToken? currentToken;
  final savedTokenJson = await storage.read('sync_token');
  if (savedTokenJson != null) {
    currentToken = HealthDataSyncToken.fromJson(savedTokenJson);
  }

  // 2. Perform Sync Loop (Handles both Initial & Incremental)
  var hasMore = true;

  do {
    final result = await connector.synchronize(
      dataTypes: [HealthDataType.steps, HealthDataType.heartRate],
      syncToken: currentToken,
    );

    // 3. Process Data
    if (result.upsertedRecords.isNotEmpty) {
      print('Processing ${result.upsertedRecords.length} updates...');
      await database.batchUpsert(result.upsertedRecords);
    }

    if (result.deletedRecordIds.isNotEmpty) {
      print('Processing ${result.deletedRecordIds.length} deletions...');
      await database.batchDelete(result.deletedRecordIds);
    }

    // 4. Update state for pagination
    hasMore = result.hasMore;
    currentToken = result.nextSyncToken;

  } while (hasMore);

  // 5. Save final token for next time
  if (currentToken != null) {
    await storage.write('sync_token', currentToken.toJson());
  }
}
```

### 2. Record Sorting

You can now sort records by time when reading from the health store. This is useful for UI display (e.g., showing most recent records first) and processing logic.

```dart
final request = HealthDataType.steps.readInTimeRange(
  startTime: start,
  endTime: end,
  sortDescriptor: SortDescriptor.timeAscending, // or SortDescriptor.timeDescending
);
```

### 3. HealthDataTypeCategory

Data types are now organized into 9 distinct semantic categories (e.g., Activity, Vitals, Nutrition). This metadata is helpful for building categorized UIs or filtering data types dynamically.

Organize data types into 9 categories:

```dart
final category = HealthDataType.steps.category;
// Returns: HealthDataTypeCategory.activity

// Filter by category
final vitalTypes = HealthDataType.values
  .where((type) => type.category == HealthDataTypeCategory.vitals)
  .toList();
```

---

**Need Help?**

- [API Documentation](https://pub.dev/documentation/health_connector/latest/)
- [File an Issue](https://github.com/fam-tung-lam/health_connector/issues)
- [Discussion Forum](https://github.com/fam-tung-lam/health_connector/discussions)

Happy migrating! 🚀

For migration from `v1.x.x` to `v2.0.0` see [Migration Guide from v1.x.x to v2.0.0](migration-guide-v1.x.x-to-v2.0.0.md).
