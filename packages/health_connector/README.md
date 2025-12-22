# health_connector

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector"><img src="https://img.shields.io/pub/v/health_connector.svg?style=popout"/></a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector/score"><img src="https://img.shields.io/pub/points/health_connector?color=2E8B57&label=pub%20points"/></a>
</p>

---

## 📖 Overview

`health_connector` provides a unified, type-safe API for accessing health data across Android and
iOS platforms. It abstracts platform differences while exposing platform-specific features when
needed.


### ✨ Features

| Feature                         | Description                                                                                                            |
|---------------------------------|------------------------------------------------------------------------------------------------------------------------|
| 🔐 **Permission Management**    | Request/check/revoke permissions                                                                                       |
| 📖 **Reading Health Data**      | Read a single health record by ID   or multiple  health records within a specified date/time range with **pagination** |
| ✍️ **Writing Health Data**      | Write health records                                                                                                   |
| 🔄 **Updating Health Records**  | Modify existing record                                                                                                 |
| 🗑️ **Deleting Health Records** | Remove specific records by their IDs  or within a date/time range                                                      |
| ➕ **Aggregating Health Data**   | Sum/Avg/Min/Max Aggregation                                                                                            |

Explore the plugin's capabilities using
the [Health Connector Toolbox](../../examples/health_connector_toolbox) example app:

<div style="text-align: center">
    <table>
        <tr>
            <th style="text-align: center">Permission Request</th>
            <th>Read Health Data</th>
            <th>Write Health Data</th>
            <th>Aggregate Health Data</th>
        </tr>
        <tr>
            <td style="text-align: center">
                <img src="../../doc/assets/ios_permission_request.gif" width="200"/>
                <img src="../../doc/assets/android_permission_request.gif" width="200"/>
            </td>    
            <td style="text-align: center">
                <img src="../../doc/assets/ios_read_health_data.gif" width="200"/>
            </td>    
            <td style="text-align: center">
                <img src="../../doc/assets/android_write_health_data.gif" width="200"/>
            </td>
            <td style="text-align: center">
                <img src="../../doc/assets/ios_aggregate_health_data.gif" width="200"/>
            </td>    
        </tr>
    </table>
</div>

---

## 🎯 Requirements

- Flutter >=3.3.0
- Dart >=3.9.2
- **Android:**
  - minSdkVersion: 26 (Android 8.0)
  - compileSdk: 34+
- **iOS:**
  - iOS >=15.0
  - Xcode >=14.0

---

## 🚀 Getting Started

### 📦 Installation

Add `health_connector` to your project:

```bash
flutter pub add health_connector
```

Or manually add to your `pubspec.yaml`:

```yaml
dependencies:
  health_connector: [latest_version]
```

### ⚙️ Platform Setup

For platform-specific setup instructions, see:

- **Android**: See [health_connector_hc_android](../health_connector_hc_android/README.md#-android-setup)
- **iOS**: See [health_connector_hk_ios](../health_connector_hk_ios/README.md#-ios-setup)

### 📚 Usage

#### Import Package

```dart
import 'package:health_connector/health_connector.dart';
```

#### Check Platform Availability

```dart
final status = await HealthConnector.getHealthPlatformStatus();

switch (status) {
  case HealthPlatformStatus.available:
    print('Health platform ready');
    break;
  case HealthPlatformStatus.installationOrUpdateRequired:
    print('Please install or update health platform');
    break;
  case HealthPlatformStatus.unavailable:
    print('Health platform not supported');
    break;
}
```

#### Create HealthConnector Instance

```dart
final connector = await HealthConnector.create(
  HealthConnectorConfig(
    isLoggerEnabled: true, // Enable debug logging
  ),
);

// Check which platform is being used
print('Platform: ${connector.healthPlatform.name}');
// Prints: "healthConnect" on Android, "appleHealth" on iOS
```

#### Permissions

##### Request Permissions

```dart
final permissions = [
  HealthDataType.steps.readPermission,
  HealthDataType.steps.writePermission,
  HealthDataType.weight.readPermission,
  HealthDataType.weight.writePermission,
  // ...
];

final results = await connector.requestPermissions(permissions);

for (final result in results) {
  print('${result.permission}: ${result.status}');
}
```

> **Important**: On iOS, **read** permissions always return `PermissionStatus.unknown` for 
> privacy reasons. This prevents apps from detecting if a user has any health data.

#### Read Health Records

##### Read Health Record by ID

```dart
final recordId = HealthRecordId('existing-record-id');
final readRequest = HealthDataType.steps.readRecord(recordId);
final record = await connector.readRecord(readRequest);

if (record != null) {
  print('Steps: ${record.count.value} from ${record.startTime} to ${record.endTime}');
} else {
  print('Record not found');
}
```

##### Read Multiple Health Records

```dart
// Read step records for the last 7 days
final request = HealthDataType.steps.readRecords(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
  pageSize: 100,
);

final response = await connector.readRecords(request);

for (final record in response.records) {
  print('Steps: ${record.count.value} from ${record.startTime} to ${record.endTime}');
}
```

##### Read Multiple Health Records with Pagination

```dart
// Initialize pagination request
var request = HealthDataType.steps.readRecords(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
  pageSize: 100, // Request 100 records per page
);

var allRecords = <StepsRecord>[];
var pageNumber = 1;

print('Starting pagination with pageSize: 100');

// Paginate through all records
while (true) {
  print('\n--- Page $pageNumber ---');
  
  // Fetch the current page
  final response = await connector.readRecords(request);
  
  print('Records returned: ${response.records.length}');
  print('Has nextPageRequest: ${response.nextPageRequest != null}');
  
  // Add records to our collection
  allRecords.addAll(response.records.cast<StepsRecord>());
  print('Total records collected so far: ${allRecords.length}');
  
  // Platform-specific pagination handling
  if (response.nextPageRequest == null) {
    print('No nextPageRequest - pagination complete');
    break;
  }
  
  // Move to next page
  request = response.nextPageRequest!;
  pageNumber++;
}

print('\n=== Pagination Complete ===');
print('Total records fetched: ${allRecords.length}');
print('Total pages processed: $pageNumber');
```

#### Write Health Records

##### Write Single Health Record

```dart
final stepRecord = StepsRecord(
  id: HealthRecordId.none, // Must be none for new records
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  count: Numeric(5000),
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.phone),
  ),
);

final recordId = await connector.writeRecord(stepRecord);
print('Record written with ID: $recordId');
```

##### Write Multiple Health Records

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
  DistanceRecord(
    id: HealthRecordId.none,
    startTime: DateTime.now().subtract(Duration(hours: 1)),
    endTime: DateTime.now(),
    distance: Length(5000),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  ),
  // Other health records ...
];

final recordIds = await connector.writeRecords(records);
print('Wrote ${recordIds.length} records');
```

#### Update Health Records

```dart
// Read existing record
final recordId = HealthRecordId('existing-record-id');
final readRequest = HealthDataType.steps.readRecord(recordId);
final existingRecord = await connector.readRecord(readRequest);

if (existingRecord != null) {
  // Create updated record
  final updatedRecord = existingRecord.copyWith(
    startTime: existingRecord.startTime,
    endTime: existingRecord.endTime,
    count: Numeric(existingRecord.count.value + 100),
    metadata: existingRecord.metadata,
  );

  // Update returns ID (same on Android, new on iOS)
  final newId = await connector.updateRecord(updatedRecord);
  
  print('Original ID: $originalId');
  print('New ID: $newId');
  // originalId == newId on Android (originalId != newId on iOS)
}
```

#### Delete Health Records

##### Delete Health Records by IDs

```dart
await connector.deleteRecordsByIds(
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
await connector.deleteRecords(
  dataType: HealthDataType.steps,
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);

print('Records deleted');
```

#### Aggregate Health Data

```dart
// Get total steps for today
final sumRequest = HealthDataType.steps.aggregateSum(
  startTime: DateTime.now().startOfDay,
  endTime: DateTime.now(),
);

final sumResponse = await connector.aggregate(sumRequest);
print('Total steps today: ${sumResponse.value.value}');

// Get average weight for the last month
final avgRequest = HealthDataType.weight.aggregateAvg(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);

final avgResponse = await connector.aggregate(avgRequest);
print('Average weight: ${avgResponse.value.inKilograms} kg');

// Get min/max weight
final minRequest = HealthDataType.weight.aggregateMin(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);
final minResponse = await connector.aggregate(minRequest);
print('Min weight: ${minResponse.value.inKilograms} kg');

final maxRequest = HealthDataType.weight.aggregateMax(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);
final maxResponse = await connector.aggregate(maxRequest);
print('Max weight: ${maxResponse.value.inKilograms} kg');
```

---

## ⚒️ Platform Specific Features

While `health_connector` provides a unified API across platforms, some features are only available 
on specific platforms due to platform capabilities and limitations.

### 🤖 Android-only API

#### Get All Granted Permissions

Retrieve a list of all permissions that have been granted to your app.

```dart
try {
    final grantedPermissions = await connector.getGrantedPermissions();
    print('Granted permissions: ${grantedPermissions.length}');
    
    // Iterate through granted permissions
    for (final permission in grantedPermissions) {
      print('Permission: ${permission.permission} - Status: ${permission.status}');
    }
} on HealthConnectorException catch (e) {
    if (e.errorCode == HealthConnectorErrorCode.unsupportedHealthPlatformApi) {
      print('This API is only available on Android');
    } else {
      print('Error: ${e.message}');
    }
}
```

#### Revoke All Granted Permissions

Revoke all permissions that have been granted to your app.

```dart
try {
    await connector.revokeAllPermissions();
    print('All permissions revoked successfully');
} on HealthConnectorException catch (e) {
    if (e.errorCode == HealthConnectorErrorCode.unsupportedHealthPlatformApi) {
      print('This API is only available on Android');
    } else {
      print('Error: ${e.message}');
    }
}
```

---

## 📋 Supported Health Data Types

### 🏃 Activity

| Data Type                      | Android | iOS | Documentation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|--------------------------------|---------|-----|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Steps**                      | ✅       | ✅   | • Android: [`StepsRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/StepsRecord)<br>• iOS: [`HKQuantityTypeIdentifier.stepCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stepcount)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| **Distance**                   | ✅       | ✅   | • Android: [`DistanceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/DistanceRecord)<br>• iOS: [`HKQuantityTypeIdentifier.distanceWalkingRunning`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewalkingrunning), [`HKQuantityTypeIdentifier.distanceCycling`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancecycling), [`HKQuantityTypeIdentifier.distanceSwimming`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distanceswimming), [`HKQuantityTypeIdentifier.distanceWheelchair`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewheelchair), [`HKQuantityTypeIdentifier.distanceWheelchair`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewheelchair), [`HKQuantityTypeIdentifier.sixMinuteWalkTestDistance`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/sixminutewalktestdistance) |
| **Active Calories Burned**     | ✅       | ✅   | • Android: [`ActiveCaloriesBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ActiveCaloriesBurnedRecord)<br>• iOS: [`HKQuantityTypeIdentifier.activeEnergyBurned`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/activeenergyburned)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| **Floors Climbed**             | ✅       | ✅   | • Android: [`FloorsClimbedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/FloorsClimbedRecord)<br>• iOS: [`HKQuantityTypeIdentifier.flightsClimbed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/flightsclimbed)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| **Wheelchair Pushes**          | ✅       | ✅   | • Android: [`WheelchairPushesRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WheelchairPushesRecord)<br>• iOS: [`HKQuantityTypeIdentifier.pushCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/pushcount)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Exercise Session / Workout** | ❌       | ❌   | • Android: [`ExerciseSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSessionRecord)<br>• iOS: [`HKWorkoutTypeIdentifier`](https://developer.apple.com/documentation/healthkit/hkworkouttypeidentifier)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **Total Calories Burned**      | ❌       | ❌   | • Android: [`TotalCaloriesBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/TotalCaloriesBurnedRecord)<br>• iOS: [`HKQuantityTypeIdentifier.basalEnergyBurned`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalenergyburned)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| **Cycling Pedaling Cadence**   | ❌       | ❌   | • Android: [`CyclingPedalingCadenceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CyclingPedalingCadenceRecord)<br>• iOS: *Not available*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **Power**                      | ❌       | ❌   | • Android: [`PowerRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/PowerRecord)<br>• iOS: [`HKQuantityTypeIdentifier.cyclingPower`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingpower)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Speed**                      | ❌       | ❌   | • Android: [`SpeedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SpeedRecord)<br>• iOS: [`HKQuantityTypeIdentifier.walkingSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingspeed), [`HKQuantityTypeIdentifier.runningSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningspeed), [`HKQuantityTypeIdentifier.stairAscentSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairascentspeed), [`HKQuantityTypeIdentifier.stairDescentSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairdescentspeed)                                                                                                                                                                                                                                                                                                                                                     |
| **Apple Exercise Time**        | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.appleExerciseTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/appleexercisetime)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Apple Stand Time**           | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.appleStandTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/applestandtime)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| **Nike Fuel**                  | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.nikeFuel`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/nikefuel)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| **Swimming Stroke Count**      | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.swimmingStrokeCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/swimmingstrokecount)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |

### 📏 Body Measurements

| Data Type                | Android | iOS | Documentation                                                                                                                                                                                                                                                                              |
|--------------------------|---------|-----|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Weight**               | ✅       | ✅   | • Android: [`WeightRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WeightRecord)<br>• iOS: [`HKQuantityTypeIdentifier.bodyMass`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymass)                     |
| **Height**               | ✅       | ✅   | • Android: [`HeightRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeightRecord)<br>• iOS: [`HKQuantityTypeIdentifier.height`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/height)                         |
| **Body Fat Percentage**  | ✅       | ✅   | • Android: [`BodyFatRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyFatRecord)<br>• iOS: [`HKQuantityTypeIdentifier.bodyFatPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodyfatpercentage) |
| **Lean Body Mass**       | ✅       | ✅   | • Android: [`LeanBodyMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/LeanBodyMassRecord)<br>• iOS: [`HKQuantityTypeIdentifier.leanBodyMass`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/leanbodymass) |
| **Bone Mass**            | ❌       | ❌   | • Android: [`BoneMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BoneMassRecord)<br>• iOS: *Not available*                                                                                                                              |
| **Body Mass Index**      | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.bodyMassIndex`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymassindex)                                                                                                                |
| **Waist Circumference**  | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.waistCircumference`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/waistcircumference)                                                                                                      |
| **Basal Metabolic Rate** | ❌       | ❌   | • Android: [`BasalMetabolicRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalMetabolicRateRecord)<br>• iOS: *Not available*                                                                                                          |

### 🩸 Cycle Tracking / Reproductive Health

| Data Type                    | Android | iOS | Documentation                                                                                                                                                                                                                                                                                                              |
|------------------------------|---------|-----|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Menstruation Flow**        | ❌       | ❌   | • Android: [`MenstruationFlowRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MenstruationFlowRecord)<br>• iOS: [`HKCategoryTypeIdentifier.menstrualFlow`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/menstrualflow)                       |
| **Cervical Mucus**           | ❌       | ❌   | • Android: [`CervicalMucusRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CervicalMucusRecord)<br>• iOS: [`HKCategoryTypeIdentifier.cervicalMucusQuality`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/cervicalmucusquality)               |
| **Ovulation Test**           | ❌       | ❌   | • Android: [`OvulationTestRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OvulationTestRecord)<br>• iOS: [`HKCategoryTypeIdentifier.ovulationTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/ovulationtestresult)                 |
| **Basal Body Temperature**   | ❌       | ❌   | • Android: [`BasalBodyTemperatureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalBodyTemperatureRecord)<br>• iOS: [`HKQuantityTypeIdentifier.basalBodyTemperature`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalbodytemperature) |
| **Sexual Activity**          | ❌       | ❌   | • Android: [`SexualActivityRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SexualActivityRecord)<br>• iOS: [`HKCategoryTypeIdentifier.sexualActivity`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sexualactivity)                         |
| **Intermenstrual Bleeding**  | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKCategoryTypeIdentifier.intermenstrualBleeding`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/intermenstrualbleeding)                                                                                                                              |
| **Pregnancy Test Result**    | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKCategoryTypeIdentifier.pregnancyTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/pregnancytestresult)                                                                                                                                    |
| **Progesterone Test Result** | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKCategoryTypeIdentifier.progesteroneTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/progesteronetestresult)                                                                                                                              |

### 🍎 Nutrition

| Data Type                       | Android | iOS | Documentation                                                                                                                                                                                                                                                                                          |
|---------------------------------|---------|-----|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Hydration / Water**           | ✅       | ✅   | • Android: [`HydrationRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HydrationRecord)<br>• iOS: [`HKQuantityTypeIdentifier.dietaryWater`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarywater)                   |
| **Nutrition / Dietary Energy**  | ✅       | ✅   | • Android: [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)<br>• iOS: [`HKQuantityTypeIdentifier.dietaryEnergyConsumed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryenergyconsumed) |
| **Dietary Protein**             | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryProtein`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryprotein)                                                                                                              |
| **Dietary Carbohydrates**       | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryCarbohydrates`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycarbohydrates)                                                                                                  |
| **Dietary Fat Total**           | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryFatTotal`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfattotal)                                                                                                            |
| **Dietary Fat Saturated**       | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryFatSaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatsaturated)                                                                                                    |
| **Dietary Fat Polyunsaturated** | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryFatPolyunsaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatpolyunsaturated)                                                                                        |
| **Dietary Fat Monounsaturated** | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryFatMonounsaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatmonounsaturated)                                                                                        |
| **Dietary Cholesterol**         | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryCholesterol`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycholesterol)                                                                                                      |
| **Dietary Sodium**              | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietarySodium`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarysodium)                                                                                                                |
| **Dietary Fiber**               | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryFiber`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfiber)                                                                                                                  |
| **Dietary Sugar**               | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietarySugar`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarysugar)                                                                                                                  |
| **Dietary Calcium**             | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryCalcium`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycalcium)                                                                                                              |
| **Dietary Iron**                | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryIron`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryiron)                                                                                                                    |
| **Dietary Vitamin C**           | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryVitaminC`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminc)                                                                                                            |
| **Dietary Vitamin D**           | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryVitaminD`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamind)                                                                                                            |
| **Dietary Vitamin E**           | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryVitaminE`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamine)                                                                                                            |
| **Dietary Vitamin K**           | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryVitaminK`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamink)                                                                                                            |
| **Dietary Vitamin B6**          | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryVitaminB6`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb6)                                                                                                          |
| **Dietary Vitamin B12**         | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryVitaminB12`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb12)                                                                                                        |
| **Dietary Thiamin (B1)**        | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryThiamin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarythiamin)                                                                                                              |
| **Dietary Riboflavin (B2)**     | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryRiboflavin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryriboflavin)                                                                                                        |
| **Dietary Niacin (B3)**         | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryNiacin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryniacin)                                                                                                                |
| **Dietary Folate**              | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryFolate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfolate)                                                                                                                |
| **Dietary Biotin**              | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryBiotin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarybiotin)                                                                                                                |
| **Dietary Pantothenic Acid**    | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryPantothenicAcid`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarypantothenicacid)                                                                                              |
| **Caffeine**                    | ✅       | ✅   | • Android: *Part of `NutritionRecord`*<br>• iOS: [`HKQuantityTypeIdentifier.dietaryCaffeine`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycaffeine)                                                                                                            |

### 😴 Sleep

| Data Type               | Android | iOS | Documentation                                                                                                                                                                                                                                                                                |
|-------------------------|---------|-----|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Sleep Session/Stage** | ✅       | ✅   | • Android: [`SleepSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SleepSessionRecord)<br>• iOS: [`HKCategoryTypeIdentifier.sleepAnalysis`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sleepanalysis) |

### ❤️ Vitals

| Data Type                           | Android | iOS | Documentation                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|-------------------------------------|---------|-----|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Heart Rate (Series/Measurement)** | ✅       | ✅   | • Android: [`HeartRateSeriesRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateSeriesRecord)<br>• iOS: [`HKQuantityTypeIdentifier.heartRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartrate)                                                                                                                                                                               |
| **Resting Heart Rate**              | ✅       | ✅   | • Android: [`RestingHeartRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RestingHeartRateRecord)<br>• iOS: [`HKQuantityTypeIdentifier.restingHeartRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/restingheartrate)                                                                                                                                                               |
| **Blood Pressure**                  | ✅       | ✅   | • Android: [`BloodPressureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodPressureRecord)<br>• iOS: [`HKQuantityTypeIdentifier.bloodPressureSystolic`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressuresystolic), [`HKQuantityTypeIdentifier.bloodPressureDiastolic`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressurediastolic) |
| **Body Temperature**                | ✅       | ✅   | • Android: [`BodyTemperatureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyTemperatureRecord)<br>• iOS: [`HKQuantityTypeIdentifier.bodyTemperature`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodytemperature)                                                                                                                                                                   |
| **Oxygen Saturation**               | ✅       | ✅   | • Android: [`OxygenSaturationRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OxygenSaturationRecord)<br>• iOS: [`HKQuantityTypeIdentifier.oxygenSaturation`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/oxygenaturation)                                                                                                                                                                |
| **Respiratory Rate**                | ✅       | ✅   | • Android: [`RespiratoryRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RespiratoryRateRecord)<br>• iOS: [`HKQuantityTypeIdentifier.respiratoryRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/respiratoryrate)                                                                                                                                                                   |
| **Vo2 Max**                         | ✅       | ✅   | • Android: [`Vo2MaxRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/Vo2MaxRecord)<br>• iOS: [`HKQuantityTypeIdentifier.vo2Max`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/vo2max)                                                                                                                                                                                                       |
| **Blood Glucose**                   | ✅       | ✅   | • Android: [`BloodGlucoseRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodGlucoseRecord)<br>• iOS: [`HKQuantityTypeIdentifier.bloodGlucose`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodglucose)                                                                                                                                                                               |
| **Walking Heart Rate Average**      | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.walkingHeartRateAverage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingheartrateaverage)                                                                                                                                                                                                                                                                          |
| **Heart Rate Variability SDNN**     | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.heartRateVariabilitySDNN`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartratevariabilitysdnn)                                                                                                                                                                                                                                                                        |
| **Peripheral Perfusion Index**      | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.peripheralPerfusionIndex`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/peripheralperfusionindex)                                                                                                                                                                                                                                                                        |
| **Blood Alcohol Content**           | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.bloodAlcoholContent`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodalcoholcontent)                                                                                                                                                                                                                                                                                  |
| **Forced Vital Capacity**           | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.forcedVitalCapacity`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/forcedvitalcapacity)                                                                                                                                                                                                                                                                                  |
| **Forced Expiratory Volume**        | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.forcedExpiratoryVolume1`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/forcedexpiratoryvolume1)                                                                                                                                                                                                                                                                          |
| **Peak Expiratory Flow Rate**       | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.peakExpiratoryFlowRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/peakexpiratoryflowrate)                                                                                                                                                                                                                                                                            |

### 🧘 Wellness / Mental Health

| Data Type               | Android | iOS | Documentation                                                                                                                                                                                                                                                                                              |
|-------------------------|---------|-----|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Mindfulness Session** | ❌       | ❌   | • Android: [`MindfulnessSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MindfulnessSessionRecord)<br>• iOS: [`HKCategoryTypeIdentifier.mindfulSession`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/mindfulsession) |

### 🏥 Clinical Records

| Data Type                   | Android | iOS | Documentation                                                                                                                           |
|-----------------------------|---------|-----|-----------------------------------------------------------------------------------------------------------------------------------------|
| **Electrocardiogram (ECG)** | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKElectrocardiogram`](https://developer.apple.com/documentation/healthkit/hkelectrocardiogram)   |
| **Vision Prescription**     | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKVisionPrescription`](https://developer.apple.com/documentation/healthkit/hkvisionprescription) |

### 🎧 Audio Exposure

| Data Type                        | Android | iOS | Documentation                                                                                                                                                                                                   |
|----------------------------------|---------|-----|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Headphone Audio Exposure**     | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.headphoneAudioExposureEvent`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/headphoneaudioexposureevent)         |
| **Environmental Audio Exposure** | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.environmentalAudioExposureEvent`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/environmentalaudioexposureevent) |

### 🚶 Mobility & Gait Analysis

| Data Type                             | Android | iOS | Documentation                                                                                                                                                                                                 |
|---------------------------------------|---------|-----|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Step Length**                       | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.stepLength`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/steplength)                                         |
| **Walking Asymmetry Percentage**      | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.walkingAsymmetryPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingasymmetrypercentage)         |
| **Walking Double Support Percentage** | ❌       | ❌   | • Android: *Not available*<br>• iOS: [`HKQuantityTypeIdentifier.walkingDoubleSupportPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingdoublesupportpercentage) |

---

## 🤝 Contributing

Contributions are welcome!

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
