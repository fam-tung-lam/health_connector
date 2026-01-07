# health_connector

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector"><img alt="Pub Version" src="https://img.shields.io/pub/v/health_connector.svg?style=popout"/></a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector/score"><img alt="Pub Points" src="https://img.shields.io/pub/points/health_connector?color=2E8B57&label=pub%20points"/></a>
  <a title="License" href="LICENSE"><img alt="License" src="https://img.shields.io/badge/license-Apache%202.0-blue.svg"/></a>
  <img alt="Platform" src="https://img.shields.io/badge/platform-iOS%20%7C%20Android-blue"/>
</p>

**The most complete Flutter health SDK** — unified, type-safe access to **100+ health data types** across iOS HealthKit and Android Health Connect.

---

## 📖 Table of Contents

- [🎮 See It In Action](#-see-it-in-action--interactive-toolbox-demo)

- [🚀 Quick Start](#-quick-start)
  - [📋 Requirements](#-requirements)
  - [📦 Installation](#-installation)
  - [🔧 Platform Setup](#-platform-setup)
  - [⚡ Quick Demo](#-quick-demo)

- [📘 Developer Guide](#-developer-guide)
  - [🔐 Permission Management](#-permission-management)
  - [📖 Reading Health Data](#-reading-health-data)
  - [✍️ Writing Health Data](#-writing-health-data)
  - [🔄 Updating Health Records](#-updating-health-records)
  - [🗑️ Deleting Health Records](#-deleting-health-records)
  - [➕ Aggregating Health Data](#-aggregating-health-data)
  - [⚙️ Feature Management](#-feature-management)
  - [⚠️ Error Handling](#-error-handling)
  - [📝 Logging](#-logging)
  - [❓ Troubleshooting & FAQ](#-troubleshooting--faq)
  - [🎯 Real-World Use Cases](#-real-world-use-cases)

- [📚 References](#-references)
  - [📋 Supported Health Data Types](#-supported-health-data-types)
  - [🔄 Migration Guides](#-migration-guides)
  - [🤝 Contributing](#-contributing)
  - [📄 License](#-license)

---

## 🎮 See It In Action — Interactive Toolbox Demo

**See what's possible.** The Health Connector Toolbox showcases the full power of the SDK with live,
interactive demonstrations running on both iOS and Android.

<div align="center">
  <table>
    <tr>
      <th>🔐 Permissions</th>
      <th>📖 Read</th>
      <th>✍️ Write</th>
      <th>🗑️ Delete</th>
      <th>📊 Aggregate</th>
    </tr>
    <tr>
      <td><img alt="Permission Request" src="../../doc/assets/videos/ios_request_permissions_demo.gif" width="160"/></td>
      <td><img alt="Read Data" src="../../doc/assets/videos/ios_read_health_records_demo.gif" width="160"/></td>
      <td><img alt="Write Data" src="../../doc/assets/videos/ios_write_health_record_demo.gif" width="160"/></td>
      <td><img alt="Delete Data" src="../../doc/assets/videos/ios_delete_health_records_demo.gif" width="160"/></td>
      <td><img alt="Aggregate Data" src="../../doc/assets/videos/ios_aggregate_health_data_demo.gif" width="160"/></td>
    </tr>
    <tr>
      <td><img alt="Permission Request" src="../../doc/assets/videos/android_request_permissions_demo.gif" width="160"/></td>
      <td><img alt="Read Data" src="../../doc/assets/videos/android_read_health_records_demo.gif" width="160"/></td>
      <td><img alt="Write Data" src="../../doc/assets/videos/android_write_health_record_demo.gif" width="160"/></td>
      <td><img alt="Delete Data" src="../../doc/assets/videos/android_delete_health_records_demo.gif" width="160"/></td>
      <td><img alt="Aggregate Data" src="../../doc/assets/videos/android_aggregate_health_data_demo.gif" width="160"/></td>
    </tr>
  </table>
</div>

### 🚀 Try It Yourself

```bash
git clone https://github.com/fam-tung-lam/health_connector.git
cd health_connector/examples/health_connector_toolbox
flutter pub get && flutter run
```

**Explore:**

- 🔐 Permission flows for HealthKit & Health Connect
- 📊 Real-time health data visualization
- ✍️ CRUD operations with live feedback
- 🧪 Feature detection and platform capabilities

> **💡 Note:** The toolbox is a demonstration tool—perfect for exploring APIs, not for production reference.

---

## 🚀 Quick Start

### 📋 Requirements

| Platform    | Minimum Version |
|-------------|-----------------|
| **Android** | API 26+         |
| **iOS**     | ≥15.0           |

### 📦 Installation

```bash
flutter pub add health_connector
```

Or add manually to `pubspec.yaml`:

```yaml
dependencies:
  health_connector: [latest_version]
```

### 🔧 Platform Setup

<details>
<summary><b>🤖 Android Health Connect Setup</b></summary>

##### Step 1: Update AndroidManifest.xml

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application>
        <!-- Your existing configuration -->

        <!-- Health Connect intent filter for showing permissions rationale -->
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

    <!-- Declare Health Connect permissions for each data type you use -->

    <!-- Read permissions -->
    <uses-permission android:name="android.permission.health.READ_STEPS" />
    <uses-permission android:name="android.permission.health.READ_WEIGHT" />
    <uses-permission android:name="android.permission.health.READ_HEART_RATE" />
    <!-- Add more read permissions... -->
    
    <!-- Write permissions -->
    <uses-permission android:name="android.permission.health.WRITE_STEPS" />
    <uses-permission android:name="android.permission.health.WRITE_WEIGHT" />
    <uses-permission android:name="android.permission.health.WRITE_HEART_RATE" />
    <!-- Add more write permissions... -->

    <!-- Feature permissions -->
    <uses-permission android:name="android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND" />
    <uses-permission android:name="android.permission.health.READ_HEALTH_DATA_HISTORY" />
    <!-- Add more feature permissions... -->
</manifest>
```

> **❗ Important**: You must declare a permission for _each_ health data type and feature your app accesses.
> See the [Health Connect data types list](https://developer.android.com/health-and-fitness/guides/health-connect/plan/data-types) for all available permissions.

##### Step 2: Update MainActivity (Android 14+)

This SDK uses the modern `registerForActivityResult` API when requesting permissions from Health
Connect. For this to work correctly, your app's `MainActivity` must extend `FlutterFragmentActivity`
instead of `FlutterActivity`. This is required because `registerForActivityResult` is only available
in `ComponentActivity` and its subclasses.

Update `android/app/src/main/kotlin/.../MainActivity.kt`:

```kotlin
package com.example.yourapp

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    // Your existing code
}
```

##### Step 3: Enable AndroidX

Health Connect is built on AndroidX libraries. `android.useAndroidX=true` enables AndroidX support,
and `android.enableJetifier=true` automatically migrates third-party libraries to use AndroidX.

Update `android/gradle.properties`:

```properties
# Your existing configuration

android.enableJetifier=true
android.useAndroidX=true
```

##### Step 4: Set Minimum Android Version

Health Connect requires Android 8.0 (API 26) or higher. Update `android/app/build.gradle`:

```gradle
android {
    // Your existing configuration

    defaultConfig {
        // Your existing configuration

        minSdkVersion 26  // Required for Health Connect
    }
}
```

</details>

<details>
<summary><b>🍎 iOS HealthKit Setup</b></summary>

##### Step 1: Configure Xcode

1. Open your project in Xcode (`ios/Runner.xcworkspace`)
2. Select your app target
3. In **General** tab → Set **Minimum Deployments** to **15.0**
4. In **Signing & Capabilities** tab → Click **+ Capability** → Add **HealthKit**

##### Step 2: Update Info.plist

Add to `ios/Runner/Info.plist`:

```xml
<dict>
    <!-- Existing keys -->

    <!-- Required: Describe why your app reads health data -->
    <key>NSHealthShareUsageDescription</key>
    <string>This app needs to read your health data to provide personalized insights.</string>

    <!-- Required: Describe why your app writes health data -->
    <key>NSHealthUpdateUsageDescription</key>
    <string>This app needs to save health data to track your progress.</string>
</dict>
```

> **⚠️ Warning**: Vague or generic usage descriptions may result in App Store rejection.
> Be specific about _what_ data you access and _why_.

</details>

### ⚡ Quick Demo

```dart
import 'package:health_connector/health_connector.dart';

Future<void> quickStart() async {
  // 1. Check platform availability
  final status = await HealthConnector.getHealthPlatformStatus();
  if (status != HealthPlatformStatus.available) {
    print('Health platform not available: $status');
    return;
  }

  // 2. Create connector instance
  final connector = await HealthConnector.create(
    const HealthConnectorConfig(isLoggerEnabled: true),
  );

  // 3. Request permissions
  final results = await connector.requestPermissions([
    HealthDataType.steps.readPermission,
    HealthDataType.steps.writePermission,
  ]);

  // 4. Verify permissions were granted
  final granted = results.every((r) => r.status != PermissionStatus.denied);
  if (!granted) {
    print('Permissions denied');
    return;
  }

  // 5. Write health data
  final now = DateTime.now();
  final records = [
    _createStepsRecord(now.subtract(Duration(hours: 3)), 1500),
    _createStepsRecord(now.subtract(Duration(hours: 2)), 2000),
    _createStepsRecord(now.subtract(Duration(hours: 1)), 1800),
  ];
  
  final recordIds = await connector.writeRecords(records);
  print('✅ Wrote ${recordIds.length} records');

  // 6. Read health data
  final response = await connector.readRecords(
    HealthDataType.steps.readInTimeRange(
      startTime: now.subtract(Duration(days: 1)),
      endTime: now,
    ),
  );

  print('📊 Found ${response.records.length} records:');
  for (final record in response.records) {
    print('  → ${record.count.value} steps (${record.startTime})');
  }
}

// Helper to create step records
StepsRecord _createStepsRecord(DateTime time, int steps) {
  return StepsRecord(
    startTime: time,
    endTime: time.add(Duration(hours: 1)),
    count: Number(steps),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  );
}
```

> **💡 What's Next?** Check out the [Developer Guide](#-developer-guide) for full API documentation, error handling, and advanced features.

---

## 📘 Developer Guide

### 🔐 Permission Management

#### Request Permissions

```dart
final permissions = [
  HealthDataType.steps.readPermission,
  HealthDataType.steps.writePermission,
  HealthDataType.weight.readPermission,
  HealthPlatformFeature.readHealthDataInBackground.permission,
];

final results = await connector.requestPermissions(permissions);

// Process results
for (final result in results) {
  if (result.status == PermissionStatus.granted) {
    print('✅ ${result.permission}');
  } else if (result.status == PermissionStatus.unknown) {
    print('❓ ${result.permission} (iOS read permission)');
  }
}
```

> **iOS Privacy:** Read permissions always return `unknown` to prevent apps from inferring whether users have health data.

#### Check Permission Status

```dart
final status = await connector.getPermissionStatus(
  HealthDataType.steps.readPermission,
);

switch (status) {
  case PermissionStatus.granted:
    // Permission granted
  case PermissionStatus.denied:
    // Permission denied
  case PermissionStatus.unknown:
    // iOS read permission (cannot determine)
}
```

#### iOS Read Permission Workaround

**Strategy:** Attempt a minimal read operation and catch `NotAuthorizedException`.

```dart
Future<bool> hasReadPermission(HealthDataType dataType) async {
  try {
    await connector.readRecords(
      dataType.readInTimeRange(
        startTime: DateTime.now().subtract(Duration(days: 1)),
        endTime: DateTime.now(),
        pageSize: 1,
      ),
    );
    return true;  // Read succeeded = permission granted
  } on NotAuthorizedException {
    return false; // Permission denied
  }
}
```

> **Disclaimer:** Not officially recommended by Apple. Use only if your app genuinely needs to determine read permission status.

#### Get All Granted Permissions (Android only)

> **iOS Privacy:** HealthKit doesn't allow apps to enumerate granted permissions.

```dart
try {
  final granted = await connector.getGrantedPermissions();
  for (final p in granted) {
    print('${p.dataType} (${p.accessType})');
  }
} on UnsupportedOperationException {
  // iOS doesn't support this API
}
```

#### Revoke All Permissions (Android only)

> **iOS Privacy:** Not supported by HealthKit. Users must revoke permissions manually via Settings app.

```dart
try {
  await connector.revokeAllPermissions();
} on UnsupportedOperationException {
  // iOS users must revoke via Settings app
}
```

### 📖 Reading Health Data

#### Read by ID

```dart
final record = await connector.readRecord(
  HealthDataType.steps.readRecord(HealthRecordId('record-id')),
);

if (record != null) {
  print('✅ Found: ${record.count.value} steps');
}
```

#### Read by Time Range

```dart
final response = await connector.readRecords(
  HealthDataType.steps.readInTimeRange(
    startTime: DateTime.now().subtract(Duration(days: 7)),
    endTime: DateTime.now(),
    pageSize: 100,
  ),
);

print('📊 Found ${response.records.length} records');
for (final record in response.records) {
  print('${record.count.value} steps on ${record.startTime}');
}
```

> **Historical Data Access:** Android Health Connect defaults to 30 days—request `HealthPlatformFeature.readHealthDataHistory` permission for older data. iOS HealthKit has no restrictions.

#### Paginate Through All Records

```dart
var request = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
  pageSize: 100,
);

final allRecords = <StepsRecord>[];

// Fetch all pages
while (true) {
  final response = await connector.readRecords(request);
  allRecords.addAll(response.records.cast<StepsRecord>());

  // Check if there are more pages
  if (response.nextPageRequest == null) break;
  request = response.nextPageRequest!;
}

print('📊 Total: ${allRecords.length} records');
```

[📤 Back to top](#-table-of-contents)

### ✍️ Writing Health Data

#### Write Single Record

```dart
final record = StepsRecord(
  id: HealthRecordId.none, // Must be .none for new records
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  count: Number(5000),
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.phone),
  ),
);

final recordId = await connector.writeRecord(record);
print('✅ Saved: $recordId');
```

#### Batch Write Multiple Records

All records succeed or all fail together:

```dart
// Helper to create step records
StepsRecord _createSteps(DateTime time, int steps) => StepsRecord(
  id: HealthRecordId.none,
  startTime: time,
  endTime: time.add(Duration(hours: 1)),
  count: Number(steps),
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.phone),
  ),
);

final now = DateTime.now();
final records = [
  _createSteps(now.subtract(Duration(hours: 3)), 1500),
  _createSteps(now.subtract(Duration(hours: 2)), 2000),
  _createSteps(now.subtract(Duration(hours: 1)), 1800),
];

final ids = await connector.writeRecords(records);
print('✅ Wrote ${ids.length} records');
```

[📤 Back to top](#-table-of-contents)

### 🔄 Updating Health Records

> **iOS Note:** HealthKit uses an immutable data model—records cannot be updated, only deleted and recreated.

#### Update Single Record (Android only)

```dart
final record = await connector.readRecord(
  HealthDataType.steps.readRecord(HealthRecordId('record-id')),
);

if (record != null) {
  await connector.updateRecord(
    record.copyWith(count: Number(record.count.value + 500)),
  );
  print('✅ Record updated');
}
```

#### Batch Update (Android only)

Update multiple records atomically—all succeed or all fail.

```dart
// Fetch records to update
final response = await connector.readRecords(
  HealthDataType.steps.readInTimeRange(
    startTime: DateTime.now().subtract(Duration(days: 7)),
    endTime: DateTime.now(),
  ),
);

// Apply updates
final updated = response.records.map((r) => 
  r.copyWith(count: Number(r.count.value + 100))
).toList();

await connector.updateRecords(updated);
print('✅ Updated ${updated.length} records');
```

#### iOS Workaround: Delete + Recreate

```dart
// Delete existing
await connector.deleteRecords(
  HealthDataType.steps.deleteByIds([existingRecord.id]),
);

// Write new record with updated values
final newRecord = existingRecord.copyWith(
  id: HealthRecordId.none,
  count: Number(newValue),
);

final newId = await connector.writeRecord(newRecord);
// ⚠️ Note: ID changes after recreation
```

[📤 Back to top](#-table-of-contents)

### 🗑️ Deleting Health Records

> **Limitation:** Apps can only delete records they created—platform security restriction.

#### Delete by IDs

```dart
try {
  await connector.deleteRecords(
    HealthDataType.steps.deleteByIds([
      HealthRecordId('id-1'),
      HealthRecordId('id-2'),
    ]),
  );
  print('✅ Deleted');
} on NotAuthorizedException {
  print('❌ Cannot delete records from other apps');
}
```

#### Delete by Time Range

```dart
await connector.deleteRecords(
  HealthDataType.steps.deleteInTimeRange(
    startTime: DateTime.now().subtract(Duration(days: 7)),
    endTime: DateTime.now(),
  ),
);
```

[📤 Back to top](#-table-of-contents)

### 📊 Aggregating Health Data

#### Example: Sum

```dart
final response = await connector.aggregate(
  HealthDataType.steps.aggregateSum(
    startTime: DateTime.now().subtract(Duration(days: 1)),
    endTime: DateTime.now(),
  ),
);

print('📊 Total steps: ${response.value.value}');
```

#### Example: Average, Min, Max

```dart
final now = DateTime.now();
final thirtyDaysAgo = now.subtract(Duration(days: 30));

// Get average weight
final avg = await connector.aggregate(
  HealthDataType.weight.aggregateAvg(
    startTime: thirtyDaysAgo,
    endTime: now,
  ),
);

// Get min/max weight
final min = await connector.aggregate(
  HealthDataType.weight.aggregateMin(
    startTime: thirtyDaysAgo,
    endTime: now,
  ),
);

// Get min/max weight
final max = await connector.aggregate(
  HealthDataType.weight.aggregateMax(
    startTime: thirtyDaysAgo,
    endTime: now,
  ),
);

print('Avg: ${avg.value.inKilograms} kg');
print('Min: ${min.value.inKilograms} kg');
print('Max: ${max.value.inKilograms} kg');
```

[📤 Back to top](#-table-of-contents)

### ⚙️ Feature Management

> **Platform Behavior:** iOS HealthKit features are always available (built into iOS). Android Health Connect features depend on app version—check `getFeatureStatus()` before requesting permissions.

#### Check Feature Availability

```dart
final status = await connector.getFeatureStatus(
  HealthPlatformFeature.readHealthDataInBackground,
);

if (status == HealthPlatformFeatureStatus.available) {
  await connector.requestPermissions([
    HealthPlatformFeature.readHealthDataInBackground.permission,
  ]);
  print('✅ Feature available and requested');
} else {
  print('❌ Feature not available—implement fallback');
}

// Note: iOS always returns 'available', Android returns actual status
```

[📤 Back to top](#-table-of-contents)

### ⚠️ Error Handling

#### Exception Quick Reference

| Exception | Recovery Strategy |
|-----------|-------------------|
| `NotAuthorizedException` | Guide user to System Settings to enable permissions |
| `HealthPlatformUnavailableException` | Disable health features gracefully (device unsupported) |
| `InvalidConfigurationException` | Dev error: check `AndroidManifest.xml` / `Info.plist` |
| `UnsupportedOperationException` | Check `getFeatureStatus()` before calling platform-specific APIs |

#### Standard Exception Handling

```dart
try {
  await connector.writeRecord(record);
} on NotAuthorizedException catch (e) {
  print('❌ Permission denied: ${e.message}');
  // Show UI prompting user to check settings
} on HealthPlatformUnavailableException {
  print('❌ Health API unavailable on this device');
} on HealthConnectorException catch (e) {
  print('❌ Error [${e.code}]: ${e.message}');
}
```

[📤 Back to top](#-table-of-contents)

### 📝 Logging

> **Zero-intrusion:** Logs are emitted to a stream (`HealthConnectorLogger.logs`) and never printed automatically. You control the output.

#### Setup & Subscribing

```dart
// 1. Enable logging during initialization
final connector = await HealthConnector.create(
  const HealthConnectorConfig(isLoggerEnabled: true),
);

// 2. Subscribe and filter
HealthConnectorLogger.logs
  .where((log) => log.level == HealthConnectorLogLevel.error) // Optional filter
  .listen((log) {
    print(log.structuredMessage);
    // OR send to Crashlytics:
    // Crashlytics.recordError(log.exception, log.stackTrace, reason: log.message);
  });
```

#### Log Structure Example

```text
[HEALTHCONNECTOR] [INFO]:
{
    datetime: 06-01-2026 18:15:32.456,
    message: HealthConnector created successfully,
    operation: create,
    context: { platform: healthConnect },
}

[HEALTHCONNECTOR] [ERROR]:
{
    datetime: 06-01-2026 18:15:34.123,
    message: Failed to read records,
    exception: { cause: NotAuthorizedException... },
}
```

[📤 Back to top](#-table-of-contents)

### 🔧 Troubleshooting & FAQ

| Issue / Question                                                                        | Platform / Context     | Solution / Answer                                                                                     |
|-----------------------------------------------------------------------------------------|------------------------|-------------------------------------------------------------------------------------------------------|
| `HealthPlatformUnavailableException`                                                    | iOS HealthKit          | Add HealthKit capability in Xcode → Signing & Capabilities                                            |
| `HealthPlatformUnavailableException`                                                    | Android Health Connect | Device doesn't support Health Connect (requires Android 8.0+)                                         |
| `HealthPlatformNotInstalledOrUpdateRequiredException`                                   | Android Health Connect | Check `getHealthPlatformStatus()` and call `launchHealthAppPageInAppStore()` to open Play Store       |
| `InvalidConfigurationException`                                                         | Android Health Connect | Add required permissions to `AndroidManifest.xml`                                                     |
| `InvalidConfigurationException`                                                         | iOS HealthKit          | Add `NSHealthShareUsageDescription` and `NSHealthUpdateUsageDescription` to `Info.plist`              |
| Why do iOS read permissions return `unknown`?                                           | iOS HealthKit          | Apple hides read permission status to protect privacy — apps cannot infer if a user has health data   |
| What's the difference between `heartRateSeriesRecord` and `heartRateMeasurementRecord`? | Cross-platform         | Android uses series records (multiple samples in one record); iOS uses individual measurement records |
| Can I read health data from other apps?                                                 | Both platforms         | Yes — with user permission, you can read data from all sources (apps, devices, manual entries)        |
| Can I modify/delete data from other apps?                                               | Both platforms         | No — apps can only modify or delete records they created (platform security restriction)              |

[📤 Back to top](#-table-of-contents)

### 🎯 Real-World Use Cases

#### 🏃 Fitness Dashboard

```dart
// Get daily summary: steps & calories
Future<Map<String, double>> getDailySummary(HealthConnector connector) async {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(Duration(days: 1));

  final steps = await connector.aggregate(
    HealthDataType.steps.aggregateSum(startTime: today, endTime: tomorrow),
  );

  final calories = await connector.aggregate(
    HealthDataType.activeCaloriesBurned.aggregateSum(startTime: today, endTime: tomorrow),
  );

  return {
    'steps': steps.value.value,
    'calories': calories.value.inKilocalories,
  };
}
```

#### ❤️ Vitals Monitor

```dart
Future<void> logVitals(HealthConnector connector) async {
  final weekAgo = DateTime.now().subtract(Duration(days: 7));
  final now = DateTime.now();

  // 1. Get latest weight
  final weight = await connector.readRecords(
    HealthDataType.weight.readInTimeRange(
      startTime: weekAgo, endTime: now, pageSize: 1,
    ),
  );
  if (weight.records.isNotEmpty) {
    print('⚖️ Latest weight: ${(weight.records.first as WeightRecord).weight.inKilograms} kg');
  }

  // 2. Get avg resting heart rate
  final hr = await connector.aggregate(
    HealthDataType.restingHeartRate.aggregateAvg(startTime: weekAgo, endTime: now),
  );
  print('💓 Avg Resting HR: ${hr.value.inBeatsPerMinute} bpm');
}
```

#### 🥗 Nutrition Tracker

```dart
Future<void> logLunch(HealthConnector connector) async {
  final entry = NutritionRecord(
    id: HealthRecordId.none,
    startTime: DateTime.now().subtract(Duration(minutes: 30)),
    endTime: DateTime.now(),
    name: 'Grilled Chicken Salad',
    energy: Energy.kilocalories(450),
    protein: Mass.grams(40),
    totalCarbohydrate: Mass.grams(12),
    totalFat: Mass.grams(15),
    metadata: Metadata.manual(),
  );

  await connector.writeRecord(entry);
  print('✅ Meal logged');
}
```

[📤 Back to top](#-table-of-contents)

---

## 📚 References

### 📋 Supported Health Data Types

#### 🏃 Activity

##### General Activity

| Data Type              | Description                                  | Data Type                               | Supported Aggregation | Android Health Connect API                                                                                                                         | iOS HealthKit API                                                                                                                              |
|------------------------|----------------------------------------------|-----------------------------------------|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| Steps                  | Number of steps taken                        | `HealthDataType.steps`                  | Sum                   | [StepsRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/StepsRecord)                                   | [HKQuantityTypeIdentifier.stepCount](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stepcount)                   |
| Active Calories Burned | Energy burned through active movement        | `HealthDataType.activeCaloriesBurned`   | Sum                   | [ActiveCaloriesBurnedRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ActiveCaloriesBurnedRecord)     | [HKQuantityTypeIdentifier.activeEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/activeenergyburned) |
| Floors Climbed         | Number of floors (flights of stairs) climbed | `HealthDataType.floorsClimbed`          | Sum                   | [FloorsClimbedRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/FloorsClimbedRecord)                   | [HKQuantityTypeIdentifier.flightsClimbed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/flightsclimbed)         |
| Sexual Activity        | Sexual activity tracking                     | `HealthDataType.sexualActivity`         | -                     | [SexualActivityRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SexualActivityRecord)                 | [HKCategoryTypeIdentifier.sexualActivity](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sexualactivity)         |
| Wheelchair Pushes      | Number of wheelchair pushes                  | `HealthDataType.wheelchairPushes`       | Sum                   | [WheelchairPushesRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WheelchairPushesRecord)             | [HKQuantityTypeIdentifier.pushCount](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/pushcount)                   |
| Cycling Cadence        | Cycling pedaling cadence                     | `HealthDataType.cyclingPedalingCadence` | Avg, Min, Max         | [CyclingPedalingCadenceRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CyclingPedalingCadenceRecord) | [HKQuantityTypeIdentifier.cyclingCadence](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingcadence)         |
| Total Calories Burned  | Total energy burned (active + basal)         | `HealthDataType.totalCaloriesBurned`    | Sum                   | [TotalCaloriesBurnedRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/TotalCaloriesBurnedRecord)       | -                                                                                                                                              |
| Basal Energy Burned    | Energy burned by basal metabolism            | `HealthDataType.basalEnergyBurned`      | Sum                   | -                                                                                                                                                  | [HKQuantityTypeIdentifier.basalEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalenergyburned)   |

##### Distance Types

| Data Type                     | Description                                  | Data Type                                   | Supported Aggregation | Android Health Connect API                                                                                             | iOS HealthKit API                                                                                                                                              |
|-------------------------------|----------------------------------------------|---------------------------------------------|-----------------------|------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Distance (generic)            | Generic distance traveled                    | `HealthDataType.distance`                   | Sum                   | [DistanceRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/DistanceRecord) | -                                                                                                                                                              |
| Walking/Running Distance      | Distance covered by walking or running       | `HealthDataType.walkingRunningDistance`     | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.distanceWalkingRunning](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewalkingrunning)         |
| Cycling Distance              | Distance covered by cycling                  | `HealthDataType.cyclingDistance`            | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.distanceCycling](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancecycling)                       |
| Swimming Distance             | Distance covered by swimming                 | `HealthDataType.swimmingDistance`           | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.distanceSwimming](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distanceswimming)                     |
| Wheelchair Distance           | Distance covered using a wheelchair          | `HealthDataType.wheelchairDistance`         | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.distanceWheelchair](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewheelchair)                 |
| Downhill Snow Sports Distance | Distance covered during downhill snow sports | `HealthDataType.downhillSnowSportsDistance` | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.distanceDownhillSnowSports](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancedownhillsnowsports) |
| Cross Country Skiing Distance | Distance covered during cross country skiing | `HealthDataType.crossCountrySkiingDistance` | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.distanceCrossCountrySkiing](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancecrosscountryskiing) |
| Paddle Sports Distance        | Distance covered during paddle sports        | `HealthDataType.paddleSportsDistance`       | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.distancePaddleSports](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancepaddlesports)             |
| Rowing Distance               | Distance covered during rowing               | `HealthDataType.rowingDistance`             | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.distanceRowing](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancerowing)                         |
| Skating Sports Distance       | Distance covered during skating sports       | `HealthDataType.skatingSportsDistance`      | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.distanceSkatingSports](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distanceskatingsports)           |
| Six Minute Walk Test Distance | Distance covered during 6-minute walk test   | `HealthDataType.sixMinuteWalkTestDistance`  | Sum                   | -                                                                                                                      | [HKQuantityTypeIdentifier.sixMinuteWalkTestDistance](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/sixminutewalktestdistance)   |

##### Speed Types

| Data Type           | Description                   | Data Type                          | Supported Aggregation | Android Health Connect API                                                                                       | iOS HealthKit API                                                                                                                            |
|---------------------|-------------------------------|------------------------------------|-----------------------|------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| Speed Series        | Speed measurements over time  | `HealthDataType.speedSeries`       | -                     | [SpeedRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SpeedRecord) | -                                                                                                                                            |
| Walking Speed       | Walking speed measurement     | `HealthDataType.walkingSpeed`      | -                     | -                                                                                                                | [HKQuantityTypeIdentifier.walkingSpeed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingspeed)           |
| Running Speed       | Running speed measurement     | `HealthDataType.runningSpeed`      | -                     | -                                                                                                                | [HKQuantityTypeIdentifier.runningSpeed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningspeed)           |
| Stair Ascent Speed  | Speed while climbing stairs   | `HealthDataType.stairAscentSpeed`  | -                     | -                                                                                                                | [HKQuantityTypeIdentifier.stairAscentSpeed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairascentspeed)   |
| Stair Descent Speed | Speed while descending stairs | `HealthDataType.stairDescentSpeed` | -                     | -                                                                                                                | [HKQuantityTypeIdentifier.stairDescentSpeed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairdescentspeed) |

##### Power Types

| Data Type     | Description                  | Data Type                     | Supported Aggregation | Android Health Connect API                                                                                       | iOS HealthKit API                                                                                                                  |
|---------------|------------------------------|-------------------------------|-----------------------|------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| Power Series  | Power measurements over time | `HealthDataType.powerSeries`  | Avg, Min, Max         | [PowerRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/PowerRecord) | -                                                                                                                                  |
| Cycling Power | Power output during cycling  | `HealthDataType.cyclingPower` | Avg, Min, Max         | -                                                                                                                | [HKQuantityTypeIdentifier.cyclingPower](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingpower) |

##### Exercise Sessions

| Data Type        | Description                                           | Data Type                        | Supported Aggregation | Android Health Connect API                                                                                                           | iOS HealthKit API                                                          |
|------------------|-------------------------------------------------------|----------------------------------|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------|
| Exercise Session | Complete workout session with exercise type and stats | `HealthDataType.exerciseSession` | Duration              | [ExerciseSessionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSessionRecord) | [HKWorkout](https://developer.apple.com/documentation/healthkit/hkworkout) |

###### Exercise Types

| Exercise Type                                | Android Health Connect | iOS HealthKit |
|----------------------------------------------|------------------------|---------------|
| `ExerciseType.other`                         | ✅                      | ✅             |
| `ExerciseType.running`                       | ✅                      | ✅             |
| `ExerciseType.runningTreadmill`              | ✅                      | ❌             |
| `ExerciseType.walking`                       | ✅                      | ✅             |
| `ExerciseType.cycling`                       | ✅                      | ✅             |
| `ExerciseType.cyclingStationary`             | ✅                      | ❌             |
| `ExerciseType.hiking`                        | ✅                      | ✅             |
| `ExerciseType.handCycling`                   | ❌                      | ✅             |
| `ExerciseType.trackAndField`                 | ❌                      | ✅             |
| `ExerciseType.swimming`                      | ❌                      | ✅             |
| `ExerciseType.swimmingOpenWater`             | ✅                      | ❌             |
| `ExerciseType.swimmingPool`                  | ✅                      | ❌             |
| `ExerciseType.surfing`                       | ✅                      | ✅             |
| `ExerciseType.waterPolo`                     | ✅                      | ✅             |
| `ExerciseType.rowing`                        | ✅                      | ✅             |
| `ExerciseType.sailing`                       | ✅                      | ✅             |
| `ExerciseType.paddling`                      | ✅                      | ✅             |
| `ExerciseType.diving`                        | ✅                      | ✅             |
| `ExerciseType.waterFitness`                  | ❌                      | ✅             |
| `ExerciseType.waterSports`                   | ❌                      | ✅             |
| `ExerciseType.strengthTraining`              | ✅                      | ✅             |
| `ExerciseType.weightlifting`                 | ✅                      | ❌             |
| `ExerciseType.calisthenics`                  | ✅                      | ❌             |
| `ExerciseType.basketball`                    | ✅                      | ✅             |
| `ExerciseType.soccer`                        | ✅                      | ✅             |
| `ExerciseType.americanFootball`              | ✅                      | ✅             |
| `ExerciseType.frisbeeDisc`                   | ✅                      | ✅             |
| `ExerciseType.australianFootball`            | ✅                      | ✅             |
| `ExerciseType.baseball`                      | ✅                      | ✅             |
| `ExerciseType.softball`                      | ✅                      | ✅             |
| `ExerciseType.volleyball`                    | ✅                      | ✅             |
| `ExerciseType.rugby`                         | ✅                      | ✅             |
| `ExerciseType.cricket`                       | ✅                      | ✅             |
| `ExerciseType.handball`                      | ✅                      | ✅             |
| `ExerciseType.iceHockey`                     | ✅                      | ❌             |
| `ExerciseType.rollerHockey`                  | ✅                      | ❌             |
| `ExerciseType.hockey`                        | ❌                      | ✅             |
| `ExerciseType.lacrosse`                      | ❌                      | ✅             |
| `ExerciseType.discSports`                    | ❌                      | ✅             |
| `ExerciseType.tennis`                        | ✅                      | ✅             |
| `ExerciseType.tableTennis`                   | ✅                      | ✅             |
| `ExerciseType.badminton`                     | ✅                      | ✅             |
| `ExerciseType.squash`                        | ✅                      | ✅             |
| `ExerciseType.racquetball`                   | ✅                      | ✅             |
| `ExerciseType.pickleball`                    | ❌                      | ✅             |
| `ExerciseType.skiing`                        | ✅                      | ❌             |
| `ExerciseType.snowboarding`                  | ✅                      | ✅             |
| `ExerciseType.snowshoeing`                   | ✅                      | ❌             |
| `ExerciseType.skating`                       | ✅                      | ✅             |
| `ExerciseType.crossCountrySkiing`            | ❌                      | ✅             |
| `ExerciseType.curling`                       | ❌                      | ✅             |
| `ExerciseType.downhillSkiing`                | ❌                      | ✅             |
| `ExerciseType.snowSports`                    | ❌                      | ✅             |
| `ExerciseType.boxing`                        | ✅                      | ✅             |
| `ExerciseType.kickboxing`                    | ❌                      | ✅             |
| `ExerciseType.martialArts`                   | ✅                      | ✅             |
| `ExerciseType.wrestling`                     | ❌                      | ✅             |
| `ExerciseType.fencing`                       | ✅                      | ✅             |
| `ExerciseType.taiChi`                        | ❌                      | ✅             |
| `ExerciseType.dancing`                       | ✅                      | ❌             |
| `ExerciseType.gymnastics`                    | ✅                      | ✅             |
| `ExerciseType.barre`                         | ❌                      | ✅             |
| `ExerciseType.cardioDance`                   | ❌                      | ✅             |
| `ExerciseType.socialDance`                   | ❌                      | ✅             |
| `ExerciseType.yoga`                          | ✅                      | ✅             |
| `ExerciseType.pilates`                       | ✅                      | ✅             |
| `ExerciseType.highIntensityIntervalTraining` | ✅                      | ✅             |
| `ExerciseType.elliptical`                    | ✅                      | ✅             |
| `ExerciseType.exerciseClass`                 | ✅                      | ❌             |
| `ExerciseType.bootCamp`                      | ✅                      | ❌             |
| `ExerciseType.guidedBreathing`               | ✅                      | ❌             |
| `ExerciseType.stairClimbing`                 | ✅                      | ✅             |
| `ExerciseType.crossTraining`                 | ❌                      | ✅             |
| `ExerciseType.jumpRope`                      | ❌                      | ✅             |
| `ExerciseType.fitnessGaming`                 | ❌                      | ✅             |
| `ExerciseType.mixedCardio`                   | ❌                      | ✅             |
| `ExerciseType.cooldown`                      | ❌                      | ✅             |
| `ExerciseType.flexibility`                   | ✅                      | ✅             |
| `ExerciseType.mindAndBody`                   | ❌                      | ✅             |
| `ExerciseType.preparationAndRecovery`        | ❌                      | ✅             |
| `ExerciseType.stepTraining`                  | ❌                      | ✅             |
| `ExerciseType.coreTraining`                  | ❌                      | ✅             |
| `ExerciseType.golf`                          | ✅                      | ✅             |
| `ExerciseType.archery`                       | ❌                      | ✅             |
| `ExerciseType.bowling`                       | ❌                      | ✅             |
| `ExerciseType.paragliding`                   | ✅                      | ❌             |
| `ExerciseType.climbing`                      | ✅                      | ✅             |
| `ExerciseType.equestrianSports`              | ❌                      | ✅             |
| `ExerciseType.fishing`                       | ❌                      | ✅             |
| `ExerciseType.hunting`                       | ❌                      | ✅             |
| `ExerciseType.play`                          | ❌                      | ✅             |
| `ExerciseType.wheelchair`                    | ✅                      | ❌             |
| `ExerciseType.wheelchairWalkPace`            | ❌                      | ✅             |
| `ExerciseType.wheelchairRunPace`             | ❌                      | ✅             |
| `ExerciseType.transition`                    | ❌                      | ✅             |
| `ExerciseType.swimBikeRun`                   | ❌                      | ✅             |

#### 📏 Body Measurements

| Data Type           | Description                     | Data Type                           | Supported Aggregation | Android Health Connect API                                                                                                           | iOS HealthKit API                                                                                                                              |
|---------------------|---------------------------------|-------------------------------------|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| Weight              | Body weight measurement         | `HealthDataType.weight`             | Avg, Min, Max         | [WeightRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WeightRecord)                   | [HKQuantityTypeIdentifier.bodyMass](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymass)                     |
| Height              | Body height measurement         | `HealthDataType.height`             | Avg, Min, Max         | [HeightRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeightRecord)                   | [HKQuantityTypeIdentifier.height](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/height)                         |
| Body Fat Percentage | Percentage of body fat          | `HealthDataType.bodyFatPercentage`  | Avg, Min, Max         | [BodyFatRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyFatRecord)                 | [HKQuantityTypeIdentifier.bodyFatPercentage](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodyfatpercentage)   |
| Lean Body Mass      | Mass of body excluding fat      | `HealthDataType.leanBodyMass`       | Avg, Min, Max         | [LeanBodyMassRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/LeanBodyMassRecord)       | [HKQuantityTypeIdentifier.leanBodyMass](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/leanbodymass)             |
| Body Temperature    | Core body temperature           | `HealthDataType.bodyTemperature`    | Avg, Min, Max         | [BodyTemperatureRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyTemperatureRecord) | [HKQuantityTypeIdentifier.bodyTemperature](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodytemperature)       |
| Body Water Mass     | Mass of body water              | `HealthDataType.bodyWaterMass`      | Avg, Min, Max         | [BodyWaterMassRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyWaterMassRecord)     | -                                                                                                                                              |
| Bone Mass           | Mass of bone mineral            | `HealthDataType.boneMass`           | Avg, Min, Max         | [BoneMassRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BoneMassRecord)               | -                                                                                                                                              |
| Body Mass Index     | Body Mass Index (BMI)           | `HealthDataType.bodyMassIndex`      | Avg, Min, Max         | -                                                                                                                                    | [HKQuantityTypeIdentifier.bodyMassIndex](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymassindex)           |
| Waist Circumference | Waist circumference measurement | `HealthDataType.waistCircumference` | Avg, Min, Max         | -                                                                                                                                    | [HKQuantityTypeIdentifier.waistCircumference](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/waistcircumference) |

#### ❤️ Vitals

| Data Type                | Description                           | Data Type                                   | Supported Aggregation | Android Health Connect API                                                                                                                               | iOS HealthKit API                                                                                                                                          |
|--------------------------|---------------------------------------|---------------------------------------------|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Heart Rate Series        | Heart rate measurements over time     | `HealthDataType.heartRateSeriesRecord`      | Avg, Min, Max         | [HeartRateRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateRecord)                                 | -                                                                                                                                                          |
| Heart Rate Measurement   | Single heart rate measurement         | `HealthDataType.heartRateMeasurementRecord` | Avg, Min, Max         | -                                                                                                                                                        | [HKQuantityTypeIdentifier.heartRate](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartrate)                               |
| Resting Heart Rate       | Heart rate while at rest              | `HealthDataType.restingHeartRate`           | Avg, Min, Max         | [RestingHeartRateRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RestingHeartRateRecord)                   | [HKQuantityTypeIdentifier.restingHeartRate](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/restingheartrate)                 |
| Blood Pressure           | Systolic and diastolic blood pressure | `HealthDataType.bloodPressure`              | Avg, Min, Max         | [BloodPressureRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodPressureRecord)                         | [HKCorrelationTypeIdentifier.bloodPressure](https://developer.apple.com/documentation/healthkit/hkcorrelationtypeidentifier/bloodpressure/)                |
| Systolic Blood Pressure  | Upper blood pressure value            | `HealthDataType.systolicBloodPressure`      | Avg, Min, Max         | -                                                                                                                                                        | [HKQuantityTypeIdentifier.bloodPressureSystolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressuresystolic)       |
| Diastolic Blood Pressure | Lower blood pressure value            | `HealthDataType.diastolicBloodPressure`     | Avg, Min, Max         | -                                                                                                                                                        | [HKQuantityTypeIdentifier.bloodPressureDiastolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressurediastolic)     |
| Oxygen Saturation        | Blood oxygen saturation percentage    | `HealthDataType.oxygenSaturation`           | Avg, Min, Max         | [OxygenSaturationRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OxygenSaturationRecord)                   | [HKQuantityTypeIdentifier.oxygenSaturation](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/oxygensaturation)                 |
| Respiratory Rate         | Breathing rate (breaths per minute)   | `HealthDataType.respiratoryRate`            | Avg, Min, Max         | [RespiratoryRateRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RespiratoryRateRecord)                     | [HKQuantityTypeIdentifier.respiratoryRate](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/respiratoryrate)                   |
| VO₂ Max                  | Maximum oxygen consumption            | `HealthDataType.vo2Max`                     | Avg, Min, Max         | [Vo2MaxRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/Vo2MaxRecord)                                       | [HKQuantityTypeIdentifier.vo2Max](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/vo2max)                                     |
| Blood Glucose            | Blood glucose concentration           | `HealthDataType.bloodGlucose`               | Avg, Min, Max         | [BloodGlucoseRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodGlucoseRecord)                           | [HKQuantityTypeIdentifier.bloodGlucose](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodglucose)                         |
| HRV RMSSD                | Heart Rate Variability (RMSSD)        | `HealthDataType.heartRateVariabilityRmssd`  | -                     | [HeartRateVariabilityRmssdRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateVariabilityRmssdRecord) | -                                                                                                                                                          |
| HRV SDNN                 | Heart Rate Variability (SDNN)         | `HealthDataType.heartRateVariabilitySdnn`   | -                     | -                                                                                                                                                        | [HKQuantityTypeIdentifier.heartRateVariabilitySDNN](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartratevariabilitysdnn) |

#### 😴 Sleep

| Data Type          | Description                              | Data Type                         | Supported Aggregation | Android Health Connect API                                                                                                     | iOS HealthKit API                                                                                                                    |
|--------------------|------------------------------------------|-----------------------------------|-----------------------|--------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| Sleep Session      | Complete sleep session with sleep stages | `HealthDataType.sleepSession`     | -                     | [SleepSessionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SleepSessionRecord) | -                                                                                                                                    |
| Sleep Stage Record | Individual sleep stage measurement       | `HealthDataType.sleepStageRecord` | -                     | -                                                                                                                              | [HKCategoryTypeIdentifier.sleepAnalysis](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sleepanalysis) |

#### 😋 Nutrition

##### Core & Hydration

| Data Type             | Description                                              | Data Type                                            | Supported Aggregation | Android Health Connect API                                                                                                                              | iOS HealthKit API                                                                                                                                    |
|-----------------------|----------------------------------------------------------|------------------------------------------------------|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| Nutrition (composite) | Complete nutrition record with macros and micronutrients | `HealthDataType.nutrition`                           | -                     | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)                                | [HKCorrelationType.food](https://developer.apple.com/documentation/healthkit/hkcorrelationtypeidentifier/food)                                       |
| Energy                | Total energy intake from food                            | `HealthDataType.energyNutrient` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.energy field) | [HKQuantityTypeIdentifier.dietaryEnergyConsumed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryenergyconsumed) |
| Hydration/Water       | Water and fluid intake                                   | `HealthDataType.hydration`                           | Sum                   | [HydrationRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HydrationRecord)                                | [HKQuantityTypeIdentifier.dietaryWater](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarywater)                   |

##### Macronutrients

| Data Type          | Description        | Data Type                                               | Supported Aggregation | Android Health Connect API                                                                                                                          | iOS HealthKit API                                                                                                                                   |
|--------------------|--------------------|---------------------------------------------------------|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| Protein            | Protein intake     | `HealthDataType.protein` (iOS HealthKit Only)           | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.protein)  | [HKQuantityTypeIdentifier.dietaryProtein](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryprotein)              |
| Total Carbohydrate | Total carbs intake | `HealthDataType.totalCarbohydrate` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.carbs)    | [HKQuantityType Identifier.dietaryCarbohydrates](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycarbohydrates) |
| Total Fat          | Total fat intake   | `HealthDataType.totalFat` (iOS HealthKit Only)          | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.totalFat) | [HKQuantityTypeIdentifier.dietaryFatTotal](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfattotal)            |
| Caffeine           | Caffeine intake    | `HealthDataType.caffeine` (iOS HealthKit Only)          | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.caffeine) | [HKQuantityTypeIdentifier.dietaryCaffeine](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycaffeine)            |

##### Fats

| Data Type           | Description                | Data Type                                                | Supported Aggregation | Android Health Connect API                                                                                                                                    | iOS HealthKit API                                                                                                                                            |
|---------------------|----------------------------|----------------------------------------------------------|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Saturated Fat       | Saturated fat intake       | `HealthDataType.saturatedFat` (iOS HealthKit Only)       | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.saturatedFat)       | [HKQuantityTypeIdentifier.dietaryFatSaturated](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatsaturated)             |
| Monounsaturated Fat | Monounsaturated fat intake | `HealthDataType.monounsaturatedFat` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.monounsaturatedFat) | [HKQuantityTypeIdentifier.dietaryFatMonounsaturated](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatmonounsaturated) |
| Polyunsaturated Fat | Polyunsaturated fat intake | `HealthDataType.polyunsaturatedFat` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.polyunsaturatedFat) | [HKQuantityTypeIdentifier.dietaryFatPolyunsaturated](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatpolyunsaturated) |
| Cholesterol         | Cholesterol intake         | `HealthDataType.cholesterol` (iOS HealthKit Only)        | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.cholesterol)        | [HKQuantityTypeIdentifier.dietaryCholesterol](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycholesterol)               |

##### Fiber & Sugar

| Data Type     | Description          | Data Type                                          | Supported Aggregation | Android Health Connect API                                                                                                                              | iOS HealthKit API                                                                                                                  |
|---------------|----------------------|----------------------------------------------------|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| Dietary Fiber | Dietary fiber intake | `HealthDataType.dietaryFiber` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.dietaryFiber) | [HKQuantityTypeIdentifier.dietaryFiber](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfiber) |
| Sugar         | Sugar intake         | `HealthDataType.sugar` (iOS HealthKit Only)        | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.sugar)        | [HKQuantityTypeIdentifier.dietarySugar](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarysugar) |

##### Minerals

| Data Type  | Description       | Data Type                                        | Supported Aggregation | Android Health Connect API                                                                                                                            | iOS HealthKit API                                                                                                                            |
|------------|-------------------|--------------------------------------------------|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| Calcium    | Calcium intake    | `HealthDataType.calcium` (iOS HealthKit Only)    | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.calcium)    | [HKQuantityTypeIdentifier.dietaryCalcium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycalcium)       |
| Iron       | Iron intake       | `HealthDataType.iron` (iOS HealthKit Only)       | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.iron)       | [HKQuantityTypeIdentifier.dietaryIron](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryiron)             |
| Magnesium  | Magnesium intake  | `HealthDataType.magnesium` (iOS HealthKit Only)  | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.magnesium)  | [HKQuantityTypeIdentifier.dietaryMagnesium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarymagnesium)   |
| Manganese  | Manganese intake  | `HealthDataType.manganese` (iOS HealthKit Only)  | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.manganese)  | [HKQuantityTypeIdentifier.dietaryManganese](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarymanganese)   |
| Phosphorus | Phosphorus intake | `HealthDataType.phosphorus` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.phosphorus) | [HKQuantityTypeIdentifier.dietaryPhosphorus](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryphosphorus) |
| Potassium  | Potassium intake  | `HealthDataType.potassium` (iOS HealthKit Only)  | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.potassium)  | [HKQuantityTypeIdentifier.dietaryPotassium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarypotassium)   |
| Selenium   | Selenium intake   | `HealthDataType.selenium` (iOS HealthKit Only)   | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.selenium)   | [HKQuantityTypeIdentifier.dietarySelenium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryselenium)     |
| Sodium     | Sodium intake     | `HealthDataType.sodium` (iOS HealthKit Only)     | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.sodium)     | [HKQuantityTypeIdentifier.dietarySodium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarysodium)         |
| Zinc       | Zinc intake       | `HealthDataType.zinc` (iOS HealthKit Only)       | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.zinc)       | [HKQuantityTypeIdentifier.dietaryZinc](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryzinc)             |

##### B Vitamins

| Data Type             | Description                   | Data Type                                             | Supported Aggregation | Android Health Connect API                                                                                                                                 | iOS HealthKit API                                                                                                                                      |
|-----------------------|-------------------------------|-------------------------------------------------------|-----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| Thiamin (B1)          | Thiamin (vitamin B1) intake   | `HealthDataType.thiamin` (iOS HealthKit Only)         | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.thiamin)         | [HKQuantityTypeIdentifier.dietaryThiamin](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarythiamin)                 |
| Riboflavin (B2)       | Riboflavin (vitamin B2)       | `HealthDataType.riboflavin` (iOS HealthKit Only)      | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.riboflavin)      | [HKQuantityTypeIdentifier.dietaryRiboflavin](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryriboflavin)           |
| Niacin (B3)           | Niacin (vitamin B3) intake    | `HealthDataType.niacin` (iOS HealthKit Only)          | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.niacin)          | [HKQuantityTypeIdentifier.dietaryNiacin](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryniacin)                   |
| Pantothenic Acid (B5) | Pantothenic acid (vitamin B5) | `HealthDataType.pantothenicAcid` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.pantothenicAcid) | [HKQuantityTypeIdentifier.dietaryPantothenicAcid](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarypantothenicacid) |
| Vitamin B6            | Vitamin B6 intake             | `HealthDataType.vitaminB6` (iOS HealthKit Only)       | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminB6)       | [HKQuantityTypeIdentifier.dietaryVitaminB6](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb6)             |
| Biotin (B7)           | Biotin (vitamin B7) intake    | `HealthDataType.biotin` (iOS HealthKit Only)          | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.biotin)          | [HKQuantityTypeIdentifier.dietaryBiotin](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarybiotin)                   |
| Folate (B9)           | Folate (vitamin B9) intake    | `HealthDataType.folate` (iOS HealthKit Only)          | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.folate)          | [HKQuantityTypeIdentifier.dietaryFolate](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfolate)                   |
| Vitamin B12           | Vitamin B12 intake            | `HealthDataType.vitaminB12` (iOS HealthKit Only)      | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminB12)      | [HKQuantityTypeIdentifier.dietaryVitaminB12](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb12)           |

##### Other Vitamins

| Data Type | Description      | Data Type                                      | Supported Aggregation | Android Health Connect API                                                                                                                          | iOS HealthKit API                                                                                                                        |
|-----------|------------------|------------------------------------------------|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| Vitamin A | Vitamin A intake | `HealthDataType.vitaminA` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminA) | [HKQuantityTypeIdentifier.dietaryVitaminA](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamina) |
| Vitamin C | Vitamin C intake | `HealthDataType.vitaminC` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminC) | [HKQuantityTypeIdentifier.dietaryVitaminC](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminc) |
| Vitamin D | Vitamin D intake | `HealthDataType.vitaminD` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminD) | [HKQuantityTypeIdentifier.dietaryVitaminD](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamind) |
| Vitamin E | Vitamin E intake | `HealthDataType.vitaminE` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminE) | [HKQuantityTypeIdentifier.dietaryVitaminE](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamine) |
| Vitamin K | Vitamin K intake | `HealthDataType.vitaminK` (iOS HealthKit Only) | Sum                   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminK) | [HKQuantityTypeIdentifier.dietaryVitaminK](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamink) |

#### 🧘 Wellness

| Data Type           | Description                         | Data Type                           | Supported Aggregation | Android Health Connect API                                                                                                                 | iOS HealthKit API                                                                                                                      |
|---------------------|-------------------------------------|-------------------------------------|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Mindfulness Session | Meditation and mindfulness sessions | `HealthDataType.mindfulnessSession` | Sum                   | [MindfulnessSessionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MindfulnessSessionRecord) | [HKCategoryTypeIdentifier.mindfulSession](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/mindfulsession) |

#### 🪷 Cycle Tracking

| Data Type               | Description                               | Data Type                               | Supported Aggregation | Android Health Connect API                                                                                                                     | iOS HealthKit API                                                                                                                                                          |
|-------------------------|-------------------------------------------|-----------------------------------------|-----------------------|------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Cervical Mucus          | Cervical mucus observations for fertility | `HealthDataType.cervicalMucus`          | -                     | [CervicalMucusRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CervicalMucusRecord)               | [HKCategoryTypeIdentifier.cervicalMucusQuality](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/cervicalmucusquality)                         |
| Basal Body Temperature  | Basal body temperature                    | `HealthDataType.basalBodyTemperature`   | Avg, Min, Max         | [BasalBodyTemperatureRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalBodyTemperatureRecord) | [HKQuantityTypeIdentifier.basalBodyTemperature](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalbodytemperature)                         |
| Menstruation Flow       | Menstrual flow intensity                  | `HealthDataType.menstrualFlow`          | -                     | [MenstruationFlowRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MenstruationFlowRecord)         | [HKCategoryTypeIdentifier.menstrualFlow](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/menstrualflow)                                       |
| Ovulation Test          | Ovulation test result                     | `HealthDataType.ovulationTest`          | -                     | [OvulationTestRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OvulationTestRecord)               | [HKCategoryTypeIdentifier.ovulationTestResult](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/ovulationtestresult)                           |
| Intermenstrual Bleeding | Intermenstrual bleeding spotting          | `HealthDataType.intermenstrualBleeding` | -                     | -                                                                                                                                              | [HKCategoryTypeIdentifier.persistentIntermenstrualBleeding](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/persistentintermenstrualbleeding) |

[📤 Back to top](#-table-of-contents)

### 🔄 Migration Guides

- [Migration Guide from `v1.x.x` to `v2.x.x`](../../doc/guides/migration_guides/migration-guide-v1.x.x-to-v2.x.x.md)

### 🤝 Contributing

Contributions are welcome! See our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues) to report bugs or request features.

### 📄 License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.
