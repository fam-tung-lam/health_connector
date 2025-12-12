# health_connector_hk_ios

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector_hk_ios"><img src="https://img.shields.io/pub/v/health_connector_hk_ios.svg?style=popout"/></a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector_hk_ios/score"><img src="https://img.shields.io/pub/points/health_connector_hk_ios?color=2E8B57&label=pub%20points"/></a>
</p>

---

## 📖 Overview

`health_connector_hk_ios` is the iOS platform implementation for the Health Connector plugin. It
provides integration with Apple's HealthKit framework, enabling Flutter apps to read, write, and
aggregate health data on iOS devices.


### ✨ Features

| Feature                         | Description                                                                                               |
|---------------------------------|-----------------------------------------------------------------------------------------------------------|
| 🔐 **Permission Management**    | Request read/write permissions for health data types                                                      |
| 📖 **Reading Health Data**      | Read a single health record by ID or multiple health records within a date/time range with **pagination** |
| ✍️ **Writing Health Data**      | Write health records with metadata                                                                        |
| 🔄 **Updating Health Records**  | Modify existing records (delete-then-insert pattern)                                                      |
| 🗑️ **Deleting Health Records** | Remove specific records by their IDs or within a date/time range                                          |
| ➕ **Aggregating Health Data**   | Sum/Avg/Min/Max Aggregation                                                                               |

---

## 🎯 Requirements

- Flutter >=3.3.0
- Dart >=3.9.2
- iOS >=15.0
- Xcode >=14.0

### 🤔 Why iOS 15.0?

Although Swift's concurrency features can be back-deployed to **iOS 13.0+** using **Xcode 13.2+**,
we intentionally set **iOS 15.0** as the minimum supported version to ensure:

- Full access to the native Swift concurrency runtime without back-deployment shims
- A simpler and more reliable runtime environment with no compatibility layers
- Better long-term maintainability and reduced technical debt

> **Note:** HealthKit itself has been available since **iOS 8.0**.
> The **iOS 15.0** requirement is a conscious architectural decision driven by native
> concurrency support - not a limitation of HealthKit.

---

## 🚀 Getting Started

### 📦 Installation

Add to your `pubspec.yaml`:

```bash
flutter pub add health_connector_hk_ios
```

Or manually add:

```yaml
dependencies:
  health_connector_hk_ios: [latest_version]
```

### ⚙️ iOS Setup

<details>
<summary>Enable HealthKit Capability</summary>

Open your project in Xcode (`ios/Runner.xcworkspace`) and:

1. Select your app target
2. Go to **Signing & Capabilities** tab
3. Click **+ Capability**
4. Add **HealthKit**

</details>

<details>
<summary>Update Info.plist</summary>

Add usage descriptions to `ios/Runner/Info.plist`:

```xml
<dict>
    <!-- Existing keys -->

    <!-- HealthKit usage description -->
    <key>NSHealthShareUsageDescription</key>
    <string>This app needs to read your health data to provide personalized insights.</string>

    <key>NSHealthUpdateUsageDescription</key>
    <string>This app needs to save health data to track your progress.</string>

    <!-- Optional: For background delivery -->
    <key>UIBackgroundModes</key>
    <array>
        <string>processing</string>
    </array>
</dict>
```

> **Important:** Provide clear, user-friendly descriptions. Vague descriptions may result in 
> App Store rejection.

</details>

### 📚 Usage

#### Import Package

```dart
import 'package:health_connector/health_connector.dart';
```

#### Create HealthConnectorHKClient Instance

```dart
final client = HealthConnectorHKClient();
```

#### Check Platform Availability

```dart
final status = await client.getHealthPlatformStatus();

switch (status) {
  case HealthPlatformStatus.available:
    print('HealthKit ready');
    break;
  case HealthPlatformStatus.unavailable:
    print('HealthKit not supported on this device');
    break;
  case HealthPlatformStatus.installationOrUpdateRequired:
    print('Please install or update Apple Health');
    break;
}
```

#### Check Health Platform Feature Status

> **Note**: On iOS HealthKit, all health platform features are available by default.
> The `getFeatureStatus()` always returns `HealthPlatformFeatureStatus.available` for all features.

```dart
// Feature status check - always returns available on iOS
final status = await client.getFeatureStatus(
  HealthPlatformFeature.readHealthDataInBackground,
);

// status == HealthPlatformFeatureStatus.available
```

#### Permissions

> **Note**: 
> - On iOS HealthKit, all health platform features are granted by default. 
>   Requesting feature permissions always returns `PermissionStatus.granted`.
> - **Read** permissions always return `PermissionStatus.unknown` for privacy reasons. 

##### Request Permissions

```dart
final permissions = [
  HealthDataType.steps.readPermission,
  HealthDataType.steps.writePermission,
  HealthDataType.weight.readPermission,
  HealthDataType.weight.writePermission,
  // ...
];

final results = await client.requestPermissions(permissions);

for (final result in results) {
  print('${result.permission}: ${result.status}');
}
```

#### Read Health Records

##### Read Health Record by ID

```dart
final recordId = HealthRecordId('existing-record-id');
final readRequest = HealthDataType.steps.readRecord(recordId);
final record = await client.readRecord(readRequest);

if (record != null) {
  print('Steps: ${record.count.value} from ${record.startTime} to ${record.endTime}');
} else {
  print('Record not found');
}
```

##### Read Multiple Health Records

```dart
final request = HealthDataType.steps.readRecords(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
  pageSize: 100,
);

final response = await client.readRecords(request);

for (final record in response.records) {
  print('Steps: ${record.count.value} from ${record.startTime} to ${record.endTime}');
}
```

##### Read Multiple Health Records with Pagination

```dart
var request = HealthDataType.steps.readRecords(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
  pageSize: 100,
);

var allRecords = <StepRecord>[];
var pageNumber = 1;

while (true) {
  final response = await client.readRecords(request);
  
  allRecords.addAll(response.records.cast<StepRecord>());
  
  if (response.nextPageRequest == null || response.records.isEmpty) {
    break;
  }
  
  request = response.nextPageRequest!;
  pageNumber++;
}

print('Total records fetched: ${allRecords.length}');
```

#### Write Health Records

##### Write Single Health Record

```dart
final stepRecord = StepRecord(
  id: HealthRecordId.none,
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  count: Numeric(5000),
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.phone),
  ),
);

final recordId = await client.writeRecord(stepRecord);
print('Record written with ID: $recordId');
```

##### Write Multiple Health Records

```dart
final records = [
  StepRecord(
    id: HealthRecordId.none,
    startTime: DateTime.now().subtract(Duration(hours: 2)),
    endTime: DateTime.now().subtract(Duration(hours: 1)),
    count: Numeric(3000),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  ),
  DistanceRecord(
    id: HealthRecordId.none,
    startTime: DateTime.now().subtract(Duration(hours: 1)),
    endTime: DateTime.now(),
    distance: Length(5000),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  ),
  // ...
];

final recordIds = await client.writeRecords(records);
print('Wrote ${recordIds.length} records');
```

#### Update Health Records

```dart
final recordId = HealthRecordId('existing-record-id');
final readRequest = HealthDataType.steps.readRecord(recordId);
final existingRecord = await client.readRecord(readRequest);

if (existingRecord != null) {
  final originalId = existingRecord.id;
  
  final updatedRecord = existingRecord.copyWith(
    startTime: existingRecord.startTime,
    endTime: existingRecord.endTime,
    count: Numeric(existingRecord.count.value + 100),
    metadata: existingRecord.metadata,
  );

  final newId = await client.updateRecord(updatedRecord);
  
  print('Original ID: $originalId');
  print('New ID: $newId');
  // originalId != newId on iOS
}
```

> **Important:** HealthKit uses an immutable data model. Existing samples cannot be modified
> after being saved. The plugin implements updates as **delete-then-insert**, so the record
> ID changes after update (new UUID assigned).

#### Delete Health Records

##### Delete Health Records by IDs

```dart
await client.deleteRecordsByIds(
  dataType: HealthDataType.steps,
  recordIds: [
    HealthRecordId('id-1'),
    HealthRecordId('id-2'),
  ],
);

print('Records deleted');
```

##### Delete Health Records by Date Range

```dart
await client.deleteRecords(
  dataType: HealthDataType.steps,
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

print('Records deleted');
```

#### Aggregate Health Data

```dart
final sumRequest = HealthDataType.steps.aggregateSum(
  startTime: DateTime.now().startOfDay,
  endTime: DateTime.now(),
);

final sumResponse = await client.aggregate(sumRequest);
print('Total steps today: ${sumResponse.value.value}');

final avgRequest = HealthDataType.weight.aggregateAvg(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);

final avgResponse = await client.aggregate(avgRequest);
print('Average weight: ${avgResponse.value.inKilograms} kg');

final minRequest = HealthDataType.weight.aggregateMin(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);
final minResponse = await client.aggregate(minRequest);
print('Min weight: ${minResponse.value.inKilograms} kg');

final maxRequest = HealthDataType.weight.aggregateMax(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);
final maxResponse = await client.aggregate(maxRequest);
print('Max weight: ${maxResponse.value.inKilograms} kg');
```

---

## 📋 Supported Health Data Types

> **Note:** For a complete list of all HealthKit data types, see the
> [official HealthKit documentation](https://developer.apple.com/documentation/healthkit).


### 🏃 Activity

| Data Type                  | Supported | Documentation                                                                                                                                                                                                                                                              |
|----------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Steps**                  | ✅         | [`HKQuantityTypeIdentifier.stepCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stepcount)                                                                                                                                             |
| **Distance**               | ✅         | [`HKQuantityTypeIdentifier.distanceWalkingRunning`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewalkingrunning)                                                                                                                   |
| **Active Calories Burned** | ✅         | [`HKQuantityTypeIdentifier.activeEnergyBurned`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/activeenergyburned)                                                                                                                           |
| **Workout**                | ❌         | [`HKWorkoutTypeIdentifier`](https://developer.apple.com/documentation/healthkit/hkworkouttypeidentifier)                                                                                                                                                                   |
| **Floors Climbed**         | ✅         | [`HKQuantityTypeIdentifier.flightsClimbed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/flightsclimbed)                                                                                                                                   |
| **Total Calories Burned**  | ❌         | [`HKQuantityTypeIdentifier.basalEnergyBurned`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalenergyburned)                                                                                                                             |
| **Power**                  | ❌         | [`HKQuantityTypeIdentifier.cyclingPower`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingpower)                                                                                                                                       |
| **Speed**                  | ❌         | [`HKQuantityTypeIdentifier.walkingSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingspeed), [`HKQuantityTypeIdentifier.runningSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningspeed) |
| **Wheelchair Pushes**      | ✅         | [`HKQuantityTypeIdentifier.pushCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/pushcount)                                                                                                                                             |
| **Distance Cycling**       | ❌         | [`HKQuantityTypeIdentifier.distanceCycling`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancecycling)                                                                                                                                 |
| **Distance Swimming**      | ❌         | [`HKQuantityTypeIdentifier.distanceSwimming`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distanceswimming)                                                                                                                               |
| **Distance Wheelchair**    | ❌         | [`HKQuantityTypeIdentifier.distanceWheelchair`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewheelchair)                                                                                                                           |
| **Apple Exercise Time**    | ❌         | [`HKQuantityTypeIdentifier.appleExerciseTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/appleexercisetime)                                                                                                                             |
| **Apple Stand Time**       | ❌         | [`HKQuantityTypeIdentifier.appleStandTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/applestandtime)                                                                                                                                   |
| **Nike Fuel**              | ❌         | [`HKQuantityTypeIdentifier.nikeFuel`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/nikefuel)                                                                                                                                               |
| **Swimming Stroke Count**  | ❌         | [`HKQuantityTypeIdentifier.swimmingStrokeCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/swimmingstrokecount)                                                                                                                         |

### 📏 Body Measurements

| Data Type               | Supported | Documentation                                                                                                                                    |
|-------------------------|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| **Weight**              | ✅         | [`HKQuantityTypeIdentifier.bodyMass`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymass)                     |
| **Height**              | ✅         | [`HKQuantityTypeIdentifier.height`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/height)                         |
| **Body Fat Percentage** | ✅         | [`HKQuantityTypeIdentifier.bodyFatPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodyfatpercentage)   |
| **Lean Body Mass**      | ✅         | [`HKQuantityTypeIdentifier.leanBodyMass`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/leanbodymass)             |
| **Body Mass Index**     | ❌         | [`HKQuantityTypeIdentifier.bodyMassIndex`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymassindex)           |
| **Waist Circumference** | ❌         | [`HKQuantityTypeIdentifier.waistCircumference`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/waistcircumference) |

### 🩸 Cycle Tracking / Reproductive Health

| Data Type                    | Supported | Documentation                                                                                                                                            |
|------------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Menstruation Flow**        | ❌         | [`HKCategoryTypeIdentifier.menstrualFlow`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/menstrualflow)                   |
| **Cervical Mucus**           | ❌         | [`HKCategoryTypeIdentifier.cervicalMucusQuality`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/cervicalmucusquality)     |
| **Ovulation Test**           | ❌         | [`HKCategoryTypeIdentifier.ovulationTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/ovulationtestresult)       |
| **Basal Body Temperature**   | ❌         | [`HKQuantityTypeIdentifier.basalBodyTemperature`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalbodytemperature)     |
| **Sexual Activity**          | ❌         | [`HKCategoryTypeIdentifier.sexualActivity`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sexualactivity)                 |
| **Intermenstrual Bleeding**  | ❌         | [`HKCategoryTypeIdentifier.intermenstrualBleeding`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/intermenstrualbleeding) |
| **Pregnancy Test Result**    | ❌         | [`HKCategoryTypeIdentifier.pregnancyTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/pregnancytestresult)       |
| **Progesterone Test Result** | ❌         | [`HKCategoryTypeIdentifier.progesteroneTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/progesteronetestresult) |

### 🍎 Nutrition

| Data Type                       | Supported | Documentation                                                                                                                                                                                                                                                                                        |
|---------------------------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Hydration / Water**           | ✅         | [`HKQuantityTypeIdentifier.dietaryWater`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarywater)                                                                                                                                                                 |
| **Nutrition / Dietary Energy**  | ✅         | [`HKQuantityTypeIdentifier.dietaryEnergyConsumed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryenergyconsumed)                                                                                                                                               |
| **Macronutrients**              | ✅         | [`HKQuantityTypeIdentifier.dietaryProtein`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryprotein), [`HKQuantityTypeIdentifier.dietaryCarbohydrates`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycarbohydrates), etc. |
| **Vitamins & Minerals**         | ✅         | Multiple identifiers (Vitamin C, D, Iron, Calcium, etc.)                                                                                                                                                                                                                                             |
| **Dietary Protein**             | ✅         | [`HKQuantityTypeIdentifier.dietaryProtein`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryprotein)                                                                                                                                                             |
| **Dietary Carbohydrates**       | ✅         | [`HKQuantityTypeIdentifier.dietaryCarbohydrates`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycarbohydrates)                                                                                                                                                 |
| **Dietary Fat Total**           | ✅         | [`HKQuantityTypeIdentifier.dietaryFatTotal`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfattotal)                                                                                                                                                           |
| **Dietary Fat Saturated**       | ✅         | [`HKQuantityTypeIdentifier.dietaryFatSaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatsaturated)                                                                                                                                                   |
| **Dietary Fat Polyunsaturated** | ✅         | [`HKQuantityTypeIdentifier.dietaryFatPolyunsaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatpolyunsaturated)                                                                                                                                       |
| **Dietary Fat Monounsaturated** | ✅         | [`HKQuantityTypeIdentifier.dietaryFatMonounsaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatmonounsaturated)                                                                                                                                       |
| **Dietary Cholesterol**         | ✅         | [`HKQuantityTypeIdentifier.dietaryCholesterol`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycholesterol)                                                                                                                                                     |
| **Dietary Sodium**              | ✅         | [`HKQuantityTypeIdentifier.dietarySodium`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarysodium)                                                                                                                                                               |
| **Dietary Fiber**               | ✅         | [`HKQuantityTypeIdentifier.dietaryFiber`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfiber)                                                                                                                                                                 |
| **Dietary Sugar**               | ✅         | [`HKQuantityTypeIdentifier.dietarySugar`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarysugar)                                                                                                                                                                 |
| **Dietary Calcium**             | ✅         | [`HKQuantityTypeIdentifier.dietaryCalcium`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycalcium)                                                                                                                                                             |
| **Dietary Iron**                | ✅         | [`HKQuantityTypeIdentifier.dietaryIron`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryiron)                                                                                                                                                                   |
| **Dietary Vitamin C**           | ✅         | [`HKQuantityTypeIdentifier.dietaryVitaminC`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminc)                                                                                                                                                           |
| **Dietary Vitamin D**           | ✅         | [`HKQuantityTypeIdentifier.dietaryVitaminD`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamind)                                                                                                                                                           |
| **Dietary Vitamin E**           | ✅         | [`HKQuantityTypeIdentifier.dietaryVitaminE`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamine)                                                                                                                                                           |
| **Dietary Vitamin K**           | ✅         | [`HKQuantityTypeIdentifier.dietaryVitaminK`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamink)                                                                                                                                                           |
| **Dietary Vitamin B6**          | ✅         | [`HKQuantityTypeIdentifier.dietaryVitaminB6`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb6)                                                                                                                                                         |
| **Dietary Vitamin B12**         | ✅         | [`HKQuantityTypeIdentifier.dietaryVitaminB12`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb12)                                                                                                                                                       |
| **Dietary Thiamin (B1)**        | ✅         | [`HKQuantityTypeIdentifier.dietaryThiamin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarythiamin)                                                                                                                                                             |
| **Dietary Riboflavin (B2)**     | ✅         | [`HKQuantityTypeIdentifier.dietaryRiboflavin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryriboflavin)                                                                                                                                                       |
| **Dietary Niacin (B3)**         | ✅         | [`HKQuantityTypeIdentifier.dietaryNiacin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryniacin)                                                                                                                                                               |
| **Dietary Folate**              | ✅         | [`HKQuantityTypeIdentifier.dietaryFolate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfolate)                                                                                                                                                               |
| **Dietary Biotin**              | ✅         | [`HKQuantityTypeIdentifier.dietaryBiotin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarybiotin)                                                                                                                                                               |
| **Dietary Pantothenic Acid**    | ✅         | [`HKQuantityTypeIdentifier.dietaryPantothenicAcid`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarypantothenicacid)                                                                                                                                             |
| **Caffeine**                    | ✅         | [`HKQuantityTypeIdentifier.dietaryCaffeine`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycaffeine)                                                                                                                                                           |

### 😴 Sleep

| Data Type         | Supported | Documentation                                                                                                                          |
|-------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------|
| **Sleep Stage**   | ✅         | [`HKCategoryTypeIdentifier.sleepAnalysis`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sleepanalysis)                                                                                                              |

### ❤️ Vitals

| Data Type                       | Supported | Documentation                                                                                                                                                                                                                                                                                                    |
|---------------------------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Heart Rate (Measurement)**    | ✅         | [`HKQuantityTypeIdentifier.heartRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartrate)                                                                                                                                                                                   |
| **Resting Heart Rate**          | ✅         | [`HKQuantityTypeIdentifier.restingHeartRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/restingheartrate)                                                                                                                                                                     |
| **Blood Pressure**              | ✅         | [`HKQuantityTypeIdentifier.bloodPressureSystolic`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressuresystolic), [`HKQuantityTypeIdentifier.bloodPressureDiastolic`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressurediastolic) |
| **Body Temperature**            | ✅         | [`HKQuantityTypeIdentifier.bodyTemperature`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodytemperature)                                                                                                                                                                       |
| **Oxygen Saturation**           | ✅         | [`HKQuantityTypeIdentifier.oxygenSaturation`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/oxygenaturation)                                                                                                                                                                      |
| **Respiratory Rate**            | ✅         | [`HKQuantityTypeIdentifier.respiratoryRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/respiratoryrate)                                                                                                                                                                       |
| **Vo2 Max**                     | ✅         | [`HKQuantityTypeIdentifier.vo2Max`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/vo2max)                                                                                                                                                                                         |
| **Blood Glucose**               | ❌         | [`HKQuantityTypeIdentifier.bloodGlucose`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodglucose)                                                                                                                                                                             |
| **Walking Heart Rate Average**  | ❌         | [`HKQuantityTypeIdentifier.walkingHeartRateAverage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingheartrateaverage)                                                                                                                                                       |
| **Heart Rate Variability SDNN** | ❌         | [`HKQuantityTypeIdentifier.heartRateVariabilitySDNN`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartratevariabilitysdnn)                                                                                                                                                     |
| **Peripheral Perfusion Index**  | ❌         | [`HKQuantityTypeIdentifier.peripheralPerfusionIndex`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/peripheralperfusionindex)                                                                                                                                                     |
| **Blood Alcohol Content**       | ❌         | [`HKQuantityTypeIdentifier.bloodAlcoholContent`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodalcoholcontent)                                                                                                                                                               |
| **Forced Vital Capacity**       | ❌         | [`HKQuantityTypeIdentifier.forcedVitalCapacity`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/forcedvitalcapacity)                                                                                                                                                               |
| **Forced Expiratory Volume**    | ❌         | [`HKQuantityTypeIdentifier.forcedExpiratoryVolume1`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/forcedexpiratoryvolume1)                                                                                                                                                       |
| **Peak Expiratory Flow Rate**   | ❌         | [`HKQuantityTypeIdentifier.peakExpiratoryFlowRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/peakexpiratoryflowrate)                                                                                                                                                         |

### 🧘 Wellness / Mental Health

| Data Type               | Supported | Documentation                                                                                                                            |
|-------------------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------|
| **Mindfulness Session** | ❌         | [`HKCategoryTypeIdentifier.mindfulSession`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/mindfulsession) |

### 🏥 Clinical Records

| Data Type                   | Supported | Documentation                                                                                      |
|-----------------------------|-----------|----------------------------------------------------------------------------------------------------|
| **Electrocardiogram (ECG)** | ❌         | [`HKElectrocardiogram`](https://developer.apple.com/documentation/healthkit/hkelectrocardiogram)   |
| **Vision Prescription**     | ❌         | [`HKVisionPrescription`](https://developer.apple.com/documentation/healthkit/hkvisionprescription) |

### 🎧 Audio Exposure

| Data Type                        | Supported | Documentation                                                                                                                                                              |
|----------------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Headphone Audio Exposure**     | ❌         | [`HKQuantityTypeIdentifier.headphoneAudioExposureEvent`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/headphoneaudioexposureevent)         |
| **Environmental Audio Exposure** | ❌         | [`HKQuantityTypeIdentifier.environmentalAudioExposureEvent`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/environmentalaudioexposureevent) |

### 🚶 Mobility & Gait Analysis

| Data Type                             | Supported | Documentation                                                                                                                                                            |
|---------------------------------------|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Walking Speed**                     | ❌         | [`HKQuantityTypeIdentifier.walkingSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingspeed)                                     |
| **Running Speed**                     | ❌         | [`HKQuantityTypeIdentifier.runningSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningspeed)                                     |
| **Step Length**                       | ❌         | [`HKQuantityTypeIdentifier.stepLength`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/steplength)                                         |
| **Walking Asymmetry Percentage**      | ❌         | [`HKQuantityTypeIdentifier.walkingAsymmetryPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingasymmetrypercentage)         |
| **Walking Double Support Percentage** | ❌         | [`HKQuantityTypeIdentifier.walkingDoubleSupportPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingdoublesupportpercentage) |
| **Six Minute Walk Test Distance**     | ❌         | [`HKQuantityTypeIdentifier.sixMinuteWalkTestDistance`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/sixminutewalktestdistance)           |
| **Stair Ascent Speed**                | ❌         | [`HKQuantityTypeIdentifier.stairAscentSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairascentspeed)                             |
| **Stair Descent Speed**               | ❌         | [`HKQuantityTypeIdentifier.stairDescentSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairdescentspeed)                           |

---

## 🤝 Contributing

Contributions are welcome!

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
