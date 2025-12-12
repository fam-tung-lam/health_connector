# health_connector_hc_android

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector_hc_android"><img src="https://img.shields.io/pub/v/health_connector_hc_android.svg?style=popout"/></a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector_hc_android/score"><img src="https://img.shields.io/pub/points/health_connector_hc_android?color=2E8B57&label=pub%20points"/></a>
</p>

---

## 📖 Overview

`health_connector_hc_android` is the Android platform implementation for the Health Connector plugin.
It provides integration with Android's Health Connect SDK, enabling Flutter apps to read, write, and
aggregate health data on Android devices.


### ✨ Features

| Feature                         | Description                                                                                               |
|---------------------------------|-----------------------------------------------------------------------------------------------------------|
| 🔐 **Permission Management**    | Request/check/revoke permissions                                                                          |
| 📖 **Reading Health Data**      | Read a single health record by ID or multiple health records within a date/time range with **pagination** |
| ✍️ **Writing Health Data**      | Write health records                                                                                      |
| 🔄 **Updating Health Records**  | Native in-place record updates with preserved IDs                                                         |
| 🗑️ **Deleting Health Records** | Remove specific records by their IDs or within a date/time range                                          |
| ➕ **Aggregating Health Data**   | Sum/Avg/Min/Max Aggregation                                                                               |

---

## 🎯 Requirements

- Flutter >=3.3.0
- Dart >=3.9.2
- Android SDK: API level 26+ (Android 8.0)
- Kotlin: 1.9.0+
- Java: 11+

---

## 🚀 Getting Started

### 📦 Installation

Add to your `pubspec.yaml`:

```bash
flutter pub add health_connector_hc_android
```

Or manually add:

```yaml
dependencies:
  health_connector_hc_android: [latest_version]
```

### ⚙️ Android Setup

<details>
<summary>AndroidManifest.xml Configuration</summary>

#### Update `AndroidManifest.xml`

Add Health Connect permissions and intent filter to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application>
        <!-- Your existing configuration -->

        <!-- Health Connect intent filter -->
        <activity-alias
            android:name="ViewPermissionUsageActivity"
            android:exported="true"
            android:targetActivity=".MainActivity"
            android:permission="android.permission.START_VIEW_PERMISSION_USAGE">
            <intent-filter>
                <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE" />
            </intent-filter>
        </activity-alias>
    </application>

    <!-- Declare Health Connect permissions -->
    <!-- Read permissions -->
    <uses-permission android:name="android.permission.health.READ_STEPS" />
    <uses-permission android:name="android.permission.health.READ_WEIGHT" />

    <!-- Write permissions -->
    <uses-permission android:name="android.permission.health.WRITE_STEPS" />
    <uses-permission android:name="android.permission.health.WRITE_WEIGHT" />
</manifest>
```

> **Important:** Add permissions for each health data type you plan to use.

</details>

<details>
<summary>Health Connect Availability</summary>

</details>

### 📚 Usage

#### Import Package

```dart
import 'package:health_connector/health_connector.dart';
```

#### Create HealthConnectorHCClient Instance

```dart
final client = HealthConnectorHCClient();
```

#### Check Health Connect Availability

```dart
final status = await client.getHealthPlatformStatus();

switch (status) {
  case HealthPlatformStatus.available:
    print('Health Connect ready');
    break;
  case HealthPlatformStatus.installationOrUpdateRequired:
    print('Please install or update Health Connect');
    break;
  case HealthPlatformStatus.unavailable:
    print('Health Connect not supported on this device');
    break;
}
```

#### Check Health Platform Feature Status

```dart
final featureStatus = await client.getFeatureStatus(
  HealthPlatformFeature.readHealthDataInBackground,
);

if (featureStatus == HealthPlatformFeatureStatus.available) {
  // Request feature permission if needed
}
```

#### Permissions

##### Request Permissions

```dart
final permissions = [
  // Health data permissions
  HealthDataType.steps.readPermission,
  HealthDataType.steps.writePermission,
  HealthDataType.weight.readPermission,
  HealthDataType.weight.writePermission,
  // ...
  
  // Feature permissions
  HealthPlatformFeature.readHealthDataInBackground,
  HealthPlatformFeature.readHealthDataHistory,
  // ...
];

final results = await client.requestPermissions(permissions);

for (final result in results) {
  print('${result.permission}: ${result.status}');
}
```

##### Check All Granted Permissions

```dart
final grantedPermissions = await client.getGrantedPermissions();
print('Granted permissions: ${grantedPermissions.length}');
```

##### Revoke All Granted Permissions

```dart
await client.revokeAllPermissions();
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
  
  if (response.nextPageRequest == null) {
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
  final updatedRecord = existingRecord.copyWith(
    startTime: existingRecord.startTime,
    endTime: existingRecord.endTime,
    count: Numeric(existingRecord.count.value + 100),
    metadata: existingRecord.metadata,
  );

  final updatedId = await client.updateRecord(updatedRecord);
  
  print('Original ID: $recordId');
  print('Updated ID: $updatedId');
  // originalId == updatedId on Android
}
```

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

> **Note:** For a complete list of all Health Connect data types, see the
> [official Health Connect documentation](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/package-summary).


### 🏃 Activity

| Data Type                    | Supported | Documentation                                                                                                                                        |
|------------------------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Steps**                    | ✅         | [`StepsRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/StepsRecord)                                   |
| **Distance**                 | ✅         | [`DistanceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/DistanceRecord)                             |
| **Active Calories Burned**   | ✅         | [`ActiveCaloriesBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ActiveCaloriesBurnedRecord)     |
| **Exercise Session**         | ❌         | [`ExerciseSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSessionRecord)               |
| **Floors Climbed**           | ✅         | [`FloorsClimbedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/FloorsClimbedRecord)                   |
| **Total Calories Burned**    | ❌         | [`TotalCaloriesBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/TotalCaloriesBurnedRecord)       |
| **Cycling Pedaling Cadence** | ❌         | [`CyclingPedalingCadenceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CyclingPedalingCadenceRecord) |
| **Power**                    | ❌         | [`PowerRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/PowerRecord)                                   |
| **Speed**                    | ❌         | [`SpeedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SpeedRecord)                                   |
| **Wheelchair Pushes**        | ✅         | [`WheelchairPushesRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WheelchairPushesRecord)             |

### 📏 Body Measurements

| Data Type                | Supported | Documentation                                                                                                                                |
|--------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------|
| **Weight**               | ✅         | [`WeightRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WeightRecord)                         |
| **Height**               | ✅         | [`HeightRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeightRecord)                         |
| **Body Fat Percentage**  | ✅         | [`BodyFatRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyFatRecord)                       |
| **Bone Mass**            | ❌         | [`BoneMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BoneMassRecord)                     |
| **Lean Body Mass**       | ✅         | [`LeanBodyMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/LeanBodyMassRecord)             |
| **Basal Metabolic Rate** | ❌         | [`BasalMetabolicRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalMetabolicRateRecord) |

### 🩸 Cycle Tracking / Reproductive Health

| Data Type                  | Supported | Documentation                                                                                                                                    |
|----------------------------|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| **Menstruation Flow**      | ❌         | [`MenstruationFlowRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MenstruationFlowRecord)         |
| **Cervical Mucus**         | ❌         | [`CervicalMucusRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CervicalMucusRecord)               |
| **Ovulation Test**         | ❌         | [`OvulationTestRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OvulationTestRecord)               |
| **Basal Body Temperature** | ❌         | [`BasalBodyTemperatureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalBodyTemperatureRecord) |
| **Sexual Activity**        | ❌         | [`SexualActivityRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SexualActivityRecord)             |

### 🍎 Nutrition

| Data Type                      | Supported | Documentation                                                                                                              |
|--------------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------|
| **Hydration / Water**          | ✅         | [`HydrationRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HydrationRecord) |
| **Nutrition / Dietary Energy** | ✅         | [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) |

### 😴 Sleep

| Data Type         | Supported | Documentation                                                                                                                    |
|-------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------|
| **Sleep Session** | ✅         | [`SleepSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SleepSessionRecord) |
| **Sleep Stage**   | ❌         | [`SleepStageRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SleepStageRecord)     |

### ❤️ Vitals

| Data Type               | Supported | Documentation                                                                                                                            |
|-------------------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------|
| **Heart Rate (Series)** | ✅         | [`HeartRateSeriesRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateSeriesRecord)   |
| **Resting Heart Rate**  | ✅         | [`RestingHeartRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RestingHeartRateRecord) |
| **Blood Pressure**      | ✅         | [`BloodPressureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodPressureRecord)       |
| **Body Temperature**    | ✅         | [`BodyTemperatureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyTemperatureRecord)   |
| **Oxygen Saturation**   | ✅         | [`OxygenSaturationRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OxygenSaturationRecord) |
| **Respiratory Rate**    | ✅         | [`RespiratoryRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RespiratoryRateRecord)   |
| **Vo2 Max**             | ✅         | [`Vo2MaxRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/Vo2MaxRecord)                     |
| **Blood Glucose**       | ✅         | [`BloodGlucoseRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodGlucoseRecord)         |

### 🧘 Wellness / Mental Health

| Data Type               | Supported | Documentation                                                                                                                                |
|-------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------|
| **Mindfulness Session** | ❌         | [`MindfulnessSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MindfulnessSessionRecord) |

---

## 🤝 Contributing

Contributions are welcome!

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
