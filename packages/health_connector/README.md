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

- [🚀 Quick Start](#-quick-start)
  - [📋 Requirements](#-requirements)
  - [📦 Installation](#-installation)
  - [🔧 Platform Setup](#-platform-setup)
  - [⚡ Quick Demo](#-quick-demo)
  - [🔍 Explore SDK Capabilities](#-exploring-sdk-capabilities-using-health-connector-toolbox)

- [📘 Developer Guide](#-developer-guide)
  - [🔐 Permission Management](#-permission-management)
  - [📖 Reading Health Data](#-reading-health-data)
  - [💾 Writing Health Data](#-writing-health-data)
  - [✍️ Updating Health Records](#-updating-health-records)
  - [🗑️ Deleting Health Records](#-deleting-health-records)
  - [➕ Aggregating Health Data](#-aggregating-health-data)
  - [⚙️ Feature Management](#-feature-management)
  - [⚠️ Error Handling](#-error-handling)
  - [🔧 Troubleshooting](#-troubleshooting)
  - [❓ FAQ](#-faq)
  - [🎯 Real-World Use Cases](#-real-world-use-cases)

- [📚 References](#-references)
  - [🔑 Key SDK Concepts](#-key-sdk-concepts)
  - [📋 Supported Health Data Types](#-supported-health-data-types)
  - [🔄 Migration Guides](#-migration-guides)
  - [🤝 Contributing](#-contributing)
  - [📄 License](#-license)
  - [📝 Changelog](#-changelog)

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

##### Update AndroidManifest.xml

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

##### Update MainActivity (Android 14+)

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

##### Enable AndroidX

Health Connect is built on AndroidX libraries. `android.useAndroidX=true` enables AndroidX support,
and `android.enableJetifier=true` automatically migrates third-party libraries to use AndroidX.

Update `android/gradle.properties`:

```properties
# Your existing configuration

android.enableJetifier=true
android.useAndroidX=true
```

</details>

<details>
<summary><b>🍎 iOS HealthKit Setup</b></summary>

##### Enable HealthKit Capability

1. Open your project in Xcode (`ios/Runner.xcworkspace`)
2. Select your app target
3. Go to **Signing & Capabilities** tab
4. Click **+ Capability**
5. Add **HealthKit**

##### Update Info.plist

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
    HealthConnectorConfig(isLoggerEnabled: true),
  );

  // 3. Request permissions for steps
  // **Note**: Feel free to use any other data type you want.
  final results = await connector.requestPermissions([
    HealthDataType.steps.readPermission,
    HealthDataType.steps.writePermission,
  ]);

  // 4. Check if all permissions were granted
  final arePermissionsGranted = results.every((r) => r.status == PermissionStatus.granted);

  if (!arePermissionsGranted) {
    print('Permissions not granted');
    return;
  }

  // 5. Write multiple step records
  final stepsRecords = [
    StepsRecord(
      startTime: DateTime.now().subtract(Duration(hours: 3)),
      endTime: DateTime.now().subtract(Duration(hours: 2)),
      count: Numeric(1500),
      metadata: Metadata.automaticallyRecorded(
        device: Device.fromType(DeviceType.phone),
      ),
    ),
    StepsRecord(
      startTime: DateTime.now().subtract(Duration(hours: 2)),
      endTime: DateTime.now().subtract(Duration(hours: 1)),
      count: Numeric(2000),
      metadata: Metadata.automaticallyRecorded(
        device: Device.fromType(DeviceType.phone),
      ),
    ),
    StepsRecord(
      startTime: DateTime.now().subtract(Duration(hours: 1)),
      endTime: DateTime.now(),
      count: Numeric(1800),
      metadata: Metadata.automaticallyRecorded(
        device: Device.fromType(DeviceType.phone),
      ),
    ),
  ];
  final recordIds = await connector.writeRecords(stepsRecords);
  print('Wrote ${recordIds.length} records');


  // 6. Read today's step records
  final response = await connector.readRecords(
    HealthDataType.steps.readInTimeRange(
      startTime: DateTime.now().subtract(Duration(days: 1)),
      endTime: DateTime.now(),
    ),
  );

  for (final record in response.records) {
    print('Record: ${record.count.value} (${record.startTime} - ${record.endTime})');
  }
}
```

### 🔍 Exploring SDK Capabilities using Health Connector Toolbox

<div align="center">
  <table>
    <tr>
      <th>Permission Request</th>
      <th>Read Data</th>
      <th>Write Data</th>
      <th>Delete Data</th>
      <th>Aggregate Data</th>
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

To explore the SDK's capabilities hands-on, you can use the **Health Connector Toolbox** app
included in the repository.

##### What the Toolbox Offers

- Interactive demonstrations of core SDK capabilities
  - Permission management
  - Read, write, update, and delete operations
  - Data aggregation
- Visual representation of health records

> **ℹ️ Note:** The toolbox is intended as a **demonstration and internal testing tool** only.
> It is **not recommended** as a reference for building production applications.

##### Running the Toolbox

```bash
# Clone the repository
git clone https://github.com/fam-tung-lam/health_connector.git
cd health_connector

# Navigate to the toolbox app
cd examples/health_connector_toolbox

# Install dependencies
flutter pub get

# Run on your device
flutter run
```

---

## 📘 Developer Guide

### 🔐 Permission Management

#### Request Permissions

> **iOS Privacy Note**: Read permissions always return `PermissionStatus.unknown` on iOS.
> This is intentional—Apple prevents apps from detecting whether users have health data by checking permission status.

```dart
final permissions = [
  // Data permissions
  HealthDataType.steps.readPermission,
  HealthDataType.steps.writePermission,
  HealthDataType.weight.readPermission,
  HealthDataType.weight.writePermission,
  
  // Feature permissions
  HealthPlatformFeature.readHealthDataInBackground.permission,
];

final results = await connector.requestPermissions(permissions);

for (final result in results) {
  print('${result.permission}: ${result.status}');
}
```

#### Check Individual Permission Status

```dart
final status = await connector.getPermissionStatus(
  HealthDataType.steps.readPermission,
);

switch (status) {
  case PermissionStatus.granted:
    print('Permission granted');
  case PermissionStatus.denied:
    print('Permission denied');
  case PermissionStatus.unknown:
    print('Cannot determine (iOS read permission)');
}
```

#### Get All Granted Permissions (Android Health Connect Only)

> **iOS Privacy Note**: This API is not available on iOS. HealthKit does not provide a way to query
> all granted permissions to protect user privacy. Apps cannot enumerate what health data access
> they have been granted.

```dart
try {
  final grantedPermissions = await connector.getGrantedPermissions();
  for (final permission in grantedPermissions) {
    if (permission is HealthDataPermission) {
      print('${permission.dataType} (${permission.accessType})');
    }
  }
} on UnsupportedOperationException {
  print('Only available on Android');
}
```

#### Revoke All Permissions (Android Health Connect Only)

> **iOS Privacy Note**: This API is not available on iOS. HealthKit requires users to manually
> revoke permissions through the iOS Settings app. This ensures users have full control and
> visibility over their health data permissions.

```dart
try {
  await connector.revokeAllPermissions();
} on UnsupportedOperationException {
  print('Only available on Android');
}
```

### 📖 Reading Health Data

> **Platform Note - Historical Data Access**
>
> **Android Health Connect**: By default, Health Connect only provides access to the **last 30 days** of historical health data.
> To read data older than 30 days, the `HealthPlatformFeature.readHealthDataHistory` feature must be
> available and its permission must be granted.
>
> **iOS HealthKit**: HealthKit has **no default limitation** on historical data access. Apps can read health data from
> any time period, subject only to user permission.

#### Read by ID

```dart
final recordId = HealthRecordId('existing-record-id');
final request = HealthDataType.steps.readRecord(recordId);
final record = await connector.readRecord(request);

if (record != null) {
  print('Steps: ${record.count.value}');
} else {
  print('Record not found');
}
```

#### Read Multiple Records

```dart
final request = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
  pageSize: 100,
);

final response = await connector.readRecords(request);

for (final record in response.records) {
  print('Steps: ${record.count.value} (${record.startTime} - ${record.endTime})');
}
```

#### Pagination

```dart
var request = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
  pageSize: 100,
);

final allRecords = <StepsRecord>[];

while (true) {
  final response = await connector.readRecords(request);
  allRecords.addAll(response.records.cast<StepsRecord>());

  if (response.nextPageRequest == null) break;
  request = response.nextPageRequest!;
}

print('Total records: ${allRecords.length}');
```

### 💾 Writing Health Data

#### Write Single Record

```dart
final stepRecord = StepsRecord(
  id: HealthRecordId.none, // Must be .none for new records
  startTime: DateTime.now().subtract(Duration(hours: 1)),
  endTime: DateTime.now(),
  count: Numeric(5000),
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.phone),
  ),
);

final recordId = await connector.writeRecord(stepRecord);
print('Record ID: $recordId');
```

#### Atomic Write Multiple Records

All records succeed or all fail together:

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
  StepsRecord(
    id: HealthRecordId.none,
    startTime: DateTime.now().subtract(Duration(hours: 1)),
    endTime: DateTime.now(),
    count: Numeric(2000),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  ),
];

final recordIds = await connector.writeRecords(records);
print('Wrote ${recordIds.length} records');
```

### ✍️ Updating Health Records

> **iOS Privacy Note**: HealthKit does not provide an update API because it uses an **immutable data
> model**. Once a health record is written to HealthKit, it cannot be modified—only deleted.

#### Update Record (Android Health Connect Only)

```dart
final recordId = HealthRecordId('existing-record-id');
final request = HealthDataType.steps.readRecord(recordId);
final existingRecord = await connector.readRecord(request);

if (existingRecord != null) {
  final updatedRecord = existingRecord.copyWith(
    count: Numeric(existingRecord.count.value + 500),
  );

  await connector.updateRecord(updatedRecord);
  print('Record updated');
}
```

#### Atomic Update Multiple Records (Android Health Connect Only)

Update multiple records atomically—all succeed or all fail together:

```dart
// Read existing records
final readRequest = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);
final response = await connector.readRecords(readRequest);

// Update all records by adding 100 steps to each
final updatedRecords = response.records.map((record) {
  return record.copyWith(
    count: Numeric(record.count.value + 100),
  );
}).toList();

// Batch update all records
await connector.updateRecords(updatedRecords);
print('Updated ${updatedRecords.length} records');
```

#### iOS HealthKit Update Workaround (Delete + Write)

```dart
// 1. Delete existing record
await connector.deleteRecords(
  HealthDataType.steps.deleteByIds([existingRecord.id]),
);

// 2. Write new record with updated values
final newRecord = StepsRecord(
  id: HealthRecordId.none,
  startTime: existingRecord.startTime,
  endTime: existingRecord.endTime,
  count: Numeric(newValue),
  metadata: existingRecord.metadata,
);

final newId = await connector.writeRecord(newRecord);
// Note: newId will be different from the original ID
```

### 🗑️ Deleting Health Records

#### Atomic Delete by IDs

```dart
await connector.deleteRecords(
  HealthDataType.steps.deleteByIds([
    HealthRecordId('id-1'),
    HealthRecordId('id-2'),
  ]),
);
```

#### Atomic Delete by Time Range

```dart
await connector.deleteRecords(
  HealthDataType.steps.deleteInTimeRange(
    startTime: DateTime.now().subtract(Duration(days: 7)),
    endTime: DateTime.now(),
  ),
);
```

> **Important**: Apps can only delete records they created.
> Attempting to delete records from other apps will lead to `NotAuthorizedException`.

### ➕ Aggregating Health Data

#### Sum Aggregation

Get the total value over a period, such as total steps for a day:

```dart
final sumRequest = HealthDataType.steps.aggregateSum(
  startTime: DateTime.now().subtract(Duration(days: 1)),
  endTime: DateTime.now(),
);

final sumResponse = await connector.aggregate(sumRequest);
print('Total steps: ${sumResponse.value.value}');
```

#### Average Aggregation

Get the average value over 30 days:

```dart
final avgRequest = HealthDataType.weight.aggregateAvg(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);

final avgResponse = await connector.aggregate(avgRequest);
print('Average weight: ${avgResponse.value.inKilograms} kg');
```

#### Minimum Aggregation

Get the minimum recorded value over a period:

```dart
final minRequest = HealthDataType.weight.aggregateMin(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);

final minResponse = await connector.aggregate(minRequest);
print('Min weight: ${minResponse.value.inKilograms} kg');
```

#### Maximum Aggregation

Get the maximum recorded value over a period:

```dart
final maxRequest = HealthDataType.weight.aggregateMax(
  startTime: DateTime.now().subtract(Duration(days: 30)),
  endTime: DateTime.now(),
);

final maxResponse = await connector.aggregate(maxRequest);
print('Max weight: ${maxResponse.value.inKilograms} kg');
```

### ⚙️ Feature Management

Platform features have different availability characteristics across platforms.

#### Platform Differences

- **iOS HealthKit**:
  - All features are **available and granted by default**
  - When checking feature status with `getFeatureStatus()`, the SDK always returns
      `HealthPlatformFeatureStatus.available`
  - When requesting feature permissions with `requestPermissions()`, the SDK always returns
      `PermissionStatus.granted`
- **Android Health Connect**:
  - Feature availability **depends on Android version and Health Connect SDK version**
  - Some features require specific minimum versions, f.e. background health data reading requires
      Health Connect SDK `v1.1.0-alpha04`

#### Checking Feature Availability

```dart
// Check if background reading is available
final status = await connector.getFeatureStatus(
  HealthPlatformFeature.readHealthDataInBackground,
);

if (status == HealthPlatformFeatureStatus.available) {
  // Feature is supported - safe to request permission
  await connector.requestPermissions([
    HealthPlatformFeature.readHealthDataInBackground.permission,
  ]);
} else {
  // Feature not available on this device/version
  print('Background reading not available');
  // Implement fallback or disable feature in UI
}
```

#### Feature Permission Status

When checking the status of a feature permission:

```dart
final permissionStatus = await connector.getPermissionStatus(
  HealthPlatformFeature.readHealthDataInBackground.permission,
);

// On iOS: Always returns PermissionStatus.granted
// On Android: Returns actual status (granted/denied)
```

### ⚠️ Error Handling

The SDK provides two approaches for handling errors.

#### Approach 1: Catching Specific Exceptions

Use Dart's type-based exception handling to catch specific error types.

```dart
try {
  await connector.requestPermissions([...]);
  await connector.writeRecord(record);
} on NotAuthorizedException catch (e) {
  // User denied or revoked permissions
  // Recovery: Explain why permission is needed, guide to settings
  print('Permission denied: ${e.message}');
} on InvalidConfigurationException catch (e) {
  // Missing AndroidManifest.xml or Info.plist configuration
  // Recovery: Fix app configuration (development-time error)
  print('Configuration error: ${e.message}');
} on UnsupportedOperationException catch (e) {
  // Platform doesn't support this operation
  // Recovery: Check platform before calling, use alternative approach
  print('Not supported: ${e.message}');
} on InvalidArgumentException catch (e) {
  // Invalid input (e.g., startTime > endTime, negative values)
  // Recovery: Validate inputs before calling
  print('Invalid argument: ${e.message}');
} on HealthPlatformUnavailableException catch (e) {
  // Device doesn't support health API
  // Recovery: Disable health features for this device
  print('Health unavailable: ${e.message}');
} on HealthPlatformNotInstalledOrUpdateRequiredException catch (e) {
  // Health Connect needs installation/update (Android Health Connect Only)
  // Recovery: Prompt user to install/update Health Connect
  print('Health Connect needs update: ${e.message}');
} on RemoteErrorException catch (e) {
  // Transient I/O or communication error
  // Recovery: Retry with exponential backoff
  print('Remote error: ${e.message}');
} on HealthConnectorException catch (e) {
  // Generic fallback for unexpected errors
  print('Unknown error [${e.code}]: ${e.message}');
}
```

#### Approach 2: Handling by Error Code

Catch the base `HealthConnectorException` and switch on `HealthConnectorErrorCode`.

```dart
try {
  await connector.requestPermissions([...]);
  await connector.writeRecord(record);
} on HealthConnectorException catch (e) {
  switch (e.code) {
    case HealthConnectorErrorCode.notAuthorized:
      print('Permission denied: ${e.message}');
    case HealthConnectorErrorCode.invalidConfiguration:
      print('Configuration error: ${e.message}');
    case HealthConnectorErrorCode.unsupportedOperation:
      print('Not supported: ${e.message}');
    case HealthConnectorErrorCode.invalidArgument:
      print('Invalid argument: ${e.message}');
    case HealthConnectorErrorCode.healthPlatformUnavailable:
      print('Health unavailable: ${e.message}');
    case HealthConnectorErrorCode.healthPlatformNotInstalledOrUpdateRequired:
      print('Health Connect needs update: ${e.message}');
    case HealthConnectorErrorCode.remoteError:
      print('Remote error: ${e.message}');
    case HealthConnectorErrorCode.unknown:
      print('Unknown error [${e.code}]: ${e.message}');
  }
}
```

#### Exception Quick Reference

| Exception                                             | Cause                      | Recovery                |
|-------------------------------------------------------|----------------------------|-------------------------|
| `NotAuthorizedException`                              | Permission denied/revoked  | Guide user to settings  |
| `InvalidConfigurationException`                       | Missing manifest entries   | Fix configuration       |
| `UnsupportedOperationException`                       | API not available          | Check platform first    |
| `InvalidArgumentException`                            | Invalid input values       | Validate inputs         |
| `HealthPlatformUnavailableException`                  | Device unsupported         | Disable health features |
| `HealthPlatformNotInstalledOrUpdateRequiredException` | Health Connect app missing | Prompt installation     |

### 🔧 Troubleshooting

#### Common Issues

| Issue                                                 | Platform               | Solution                                                                                                                  |
|-------------------------------------------------------|------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `HealthPlatformUnavailableException`                  | iOS HealthKit          | Add HealthKit capability in Xcode → Signing & Capabilities                                                                |
| `HealthPlatformUnavailableException`                  | Android Health Connect | Device doesn't support Health Connect (requires Android 8.0+)                                                             |
| `HealthPlatformNotInstalledOrUpdateRequiredException` | Android Health Connect | Prompt user to install [Health Connect](https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata) |
| `InvalidConfigurationException`                       | Android Health Connect | Add required permissions to `AndroidManifest.xml`                                                                         |
| `InvalidConfigurationException`                       | iOS HealthKit          | Add `NSHealthShareUsageDescription` and `NSHealthUpdateUsageDescription` to `Info.plist`                                  |
| Read permissions return `unknown`                     | iOS HealthKit          | Normal behavior—iOS doesn't expose read permission status for privacy                                                     |
| Can't delete/update records                           | Both                   | Apps can only modify records they created                                                                                 |

#### Debug Logging

Enable detailed logs to troubleshoot issues:

```dart
final connector = await HealthConnector.create(
  HealthConnectorConfig(isLoggerEnabled: true),
);
```

### ❓ FAQ

#### Why do iOS read permissions always return `unknown`?

Apple intentionally hides read permission status to protect user privacy. This prevents apps from
inferring whether a user has any health data by checking if read permission was denied.

#### How do I handle Health Connect not being installed?

```dart
final status = await HealthConnector.getHealthPlatformStatus();
if (status == HealthPlatformStatus.installationOrUpdateRequired) {
  // Show dialog prompting user to install Health Connect
  // Open Play Store: https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata
}
```

#### What's the difference between `heartRateSeriesRecord` and `heartRateMeasurementRecord`?

- **Android Health Connect**: Uses `heartRateSeriesRecord` — a single record with multiple samples
  over a time interval
- **iOS HealthKit**: Uses `heartRateMeasurementRecord` — each measurement is a separate record with
  its own ID

#### Can I read health data from other apps?

Yes, with user permission. When granted read access, you can read health data from all sources (
other apps, devices, manual entries).

#### Can I delete health data from other apps?

No. Apps can only delete records they created. This is a platform security restriction.

### 🎯 Real-World Use Cases

#### Fitness Tracker

Track daily activity with steps, calories, and distance:

```dart
Future<Map<String, double>> getDailyActivitySummary(
  HealthConnector connector,
  DateTime date,
) async {
  final startOfDay = DateTime(date.year, date.month, date.day);
  final endOfDay = startOfDay.add(Duration(days: 1));

  final steps = await connector.aggregate(
    HealthDataType.steps.aggregateSum(
      startTime: startOfDay,
      endTime: endOfDay,
    ),
  );

  final calories = await connector.aggregate(
    HealthDataType.activeCaloriesBurned.aggregateSum(
      startTime: startOfDay,
      endTime: endOfDay,
    ),
  );

  return {
    'steps': steps.value.value,
    'calories': calories.value.inKilocalories,
  };
}
```

#### Health Dashboard

Display vital signs with recent measurements:

```dart
Future<void> displayVitals(HealthConnector connector) async {
  final now = DateTime.now();
  final weekAgo = now.subtract(Duration(days: 7));

  // Get latest weight
  final weightResponse = await connector.readRecords(
    HealthDataType.weight.readInTimeRange(
      startTime: weekAgo,
      endTime: now,
      pageSize: 1,
    ),
  );

  if (weightResponse.records.isNotEmpty) {
    final latestWeight = weightResponse.records.first as WeightRecord;
    print('Latest weight: ${latestWeight.weight.inKilograms} kg');
  }

  // Get heart rate average
  final heartRateAvg = await connector.aggregate(
    HealthDataType.restingHeartRate.aggregateAvg(
      startTime: weekAgo,
      endTime: now,
    ),
  );
  print('Avg resting HR: ${heartRateAvg.value.inBeatsPerMinute} bpm');
}
```

#### Nutrition Logger

Log meals with macronutrients:

```dart
Future<void> logMeal({
  required HealthConnector connector,
  required String mealName,
  required double calories,
  required double proteinGrams,
  required double carbsGrams,
  required double fatGrams,
}) async {
  final now = DateTime.now();

  final nutritionRecord = NutritionRecord(
    id: HealthRecordId.none,
    startTime: now.subtract(Duration(minutes: 30)),
    endTime: now,
    mealType: MealType.lunch,
    name: mealName,
    energy: Energy.kilocalories(calories),
    protein: Mass.grams(proteinGrams),
    totalCarbohydrate: Mass.grams(carbsGrams),
    totalFat: Mass.grams(fatGrams),
    metadata: Metadata.manual(),
  );

  await connector.writeRecord(nutritionRecord);
  print('Meal logged: $mealName');
}
```

---

## 📚 References

### 🔑 Key SDK Concepts

#### Key Types

| Type                    | Description                                                   |
|-------------------------|---------------------------------------------------------------|
| `HealthConnector`       | Main entry point for all health data operations               |
| `HealthDataType`        | Enumeration of supported metrics (steps, weight, etc.)        |
| `HealthRecord`          | Base class for all health data records                        |
| `Permission`            | Base class for data and feature permission types              |
| `Request/Response`      | Request/Response objects for read/aggregate/delete operations |

#### Type-Safe Generics

The SDK leverages Dart generics to provide **compile-time type safety**. Each `HealthDataType` is
parameterized with its corresponding `HealthRecord` type and `MeasurementUnit`, ensuring the correct
types flow through all operations automatically.

```dart
// HealthDataType.weight is defined as `HealthDataType<WeightRecord, Mass>`
// This means:
//   - Read operations return `WeightRecord` (not a generic `HealthRecord`)
//   - Aggregation returns `Mass` (the measurement unit for weight)

// The compiler automatically infers the correct record type
final request = HealthDataType.weight.readInTimeRange(
  startTime: start,
  endTime: end,
);
// request is `ReadRecordsInTimeRangeRequest<WeightRecord>`

final response = await connector.readRecords(request);
// response.records is `List<WeightRecord>`, not `List<HealthRecord>`

// You can directly access `WeightRecord`-specific properties without casting
for (final record in response.records) {
  print('Steps: ${record.weight.value}'); // ✅ No cast needed
}

// Same for aggregation - the measurement unit is inferred
final avgRequest = HealthDataType.weight.aggregateAvg(
  startTime: start,
  endTime: end,
);
// `avgRequest` is `AggregateRequest<WeightRecord, Mass>`

final avgWeight = await connector.aggregate(avgRequest);
// `avgWeight` is `Mass`, not `MeasurementUnit`
print('Total steps: ${total.value}'); // ✅ Correct type automatically
```

This generic approach means:

- **No runtime type casting** — The compiler knows the exact record and unit types
- **Compile-time errors** — Type mismatches are caught before your app runs
- **IDE autocompletion** — Your IDE suggests the correct properties for each record type

#### Request-Response Pattern

The SDK uses a **request-response pattern** for read, aggregate, and delete operations. This design
abstracts the significant API differences between health platforms, providing you with a
consistent interface regardless of the underlying platform.

##### How It Works

Instead of calling methods directly with raw parameters, you create strongly-typed request objects
through the `HealthDataType` class:

```dart
// Reading records: Create request via HealthDataType
final readRequest = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(Duration(days: 7)),
  endTime: DateTime.now(),
);
final response = await connector.readRecords(readRequest);

// Aggregating data: Create request via HealthDataType
final aggregateRequest = HealthDataType.steps.aggregateSum(
  startTime: DateTime.now().subtract(Duration(days: 1)),
  endTime: DateTime.now(),
);
final aggregateResponse = await connector.aggregate(aggregateRequest);

// Deleting records: Create request via HealthDataType
final deleteRequest = HealthDataType.steps.deleteByIds([recordId]);
await connector.deleteRecords(deleteRequest);
```

##### Write and Update Operations

Write and update operations **do not** use the request-response pattern. This is because:

- **Write operations** have consistent APIs across both platforms — both accept health record objects
- **Update operations** are only supported on Android Health Connect, because iOS HealthKit
  uses the **immutable data model**.

### 📋 Supported Health Data Types

#### 🏃 Activity

| Data Type              | Description                                  | Android Health Connect                                                                                                                         | iOS HealthKit                                                                                                                                  | SDK Data Type                                                            | Aggregation |
|------------------------|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|-------------|
| Steps                  | Number of steps taken                        | [StepsRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/StepsRecord)                               | [HKQuantityTypeIdentifier.stepCount](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stepcount)                   | `StepsHealthDataType<StepsRecord, Number>`                               | Sum         |
| Distance (generic)     | Generic distance traveled                    | [DistanceRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/DistanceRecord)                         | ❌                                                                                                                                              | `DistanceHealthDataType<DistanceRecord, Length>`                         | Sum         |
| Active Calories Burned | Energy burned through active movement        | [ActiveCaloriesBurnedRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ActiveCaloriesBurnedRecord) | [HKQuantityTypeIdentifier.activeEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/activeenergyburned) | `ActiveCaloriesBurnedHealthDataType<ActiveCaloriesBurnedRecord, Energy>` | Sum         |
| Floors Climbed         | Number of floors (flights of stairs) climbed | [FloorsClimbedRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/FloorsClimbedRecord)               | [HKQuantityTypeIdentifier.flightsClimbed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/flightsclimbed)         | `FloorsClimbedHealthDataType<FloorsClimbedRecord, Number>`               | Sum         |
| Wheelchair Pushes      | Number of wheelchair pushes                  | [WheelchairPushesRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WheelchairPushesRecord)         | [HKQuantityTypeIdentifier.pushCount](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/pushcount)                   | `WheelchairPushesHealthDataType<WheelchairPushesRecord, Number>`         | Sum         |

#### 📏 Distance Types

| Data Type                     | Description                                  | Android Health Connect                                                                                                 | iOS HealthKit                                                                                                                                                  | SDK Data Type                                                                        | Aggregation |
|-------------------------------|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------|-------------|
| Distance (generic)            | Generic distance traveled                    | [DistanceRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/DistanceRecord) | ❌                                                                                                                                                              | `DistanceHealthDataType<DistanceRecord, Length>`                                     | Sum         |
| Walking/Running Distance      | Distance covered by walking or running       | ❌                                                                                                                      | [HKQuantityTypeIdentifier.distanceWalkingRunning](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewalkingrunning)         | `WalkingRunningDistanceHealthDataType<WalkingRunningDistanceRecord, Length>`         | Sum         |
| Cycling Distance              | Distance covered by cycling                  | ❌                                                                                                                      | [HKQuantityTypeIdentifier.distanceCycling](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancecycling)                       | `CyclingDistanceHealthDataType<CyclingDistanceRecord, Length>`                       | Sum         |
| Swimming Distance             | Distance covered by swimming                 | ❌                                                                                                                      | [HKQuantityTypeIdentifier.distanceSwimming](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distanceswimming)                     | `SwimmingDistanceHealthDataType<SwimmingDistanceRecord, Length>`                     | Sum         |
| Wheelchair Distance           | Distance covered using a wheelchair          | ❌                                                                                                                      | [HKQuantityTypeIdentifier.distanceWheelchair](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewheelchair)                 | `WheelchairDistanceHealthDataType<WheelchairDistanceRecord, Length>`                 | Sum         |
| Downhill Snow Sports Distance | Distance covered during downhill snow sports | ❌                                                                                                                      | [HKQuantityTypeIdentifier.distanceDownhillSnowSports](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancedownhillsnowsports) | `DownhillSnowSportsDistanceHealthDataType<DownhillSnowSportsDistanceRecord, Length>` | Sum         |
| Cross Country Skiing Distance | Distance covered during cross country skiing | ❌                                                                                                                      | [HKQuantityTypeIdentifier.distanceCrossCountrySkiing](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancecrosscountryskiing) | `CrossCountrySkiingDistanceDataType<CrossCountrySkiingDistanceRecord, Length>`       | Sum         |
| Paddle Sports Distance        | Distance covered during paddle sports        | ❌                                                                                                                      | [HKQuantityTypeIdentifier.distancePaddleSports](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancepaddlesports)             | `PaddleSportsDistanceDataType<PaddleSportsDistanceRecord, Length>`                   | Sum         |
| Rowing Distance               | Distance covered during rowing               | ❌                                                                                                                      | [HKQuantityTypeIdentifier.distanceRowing](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancerowing)                         | `RowingDistanceDataType<RowingDistanceRecord, Length>`                               | Sum         |
| Skating Sports Distance       | Distance covered during skating sports       | ❌                                                                                                                      | [HKQuantityTypeIdentifier.distanceSkatingSports](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distanceskatingsports)           | `SkatingSportsDistanceDataType<SkatingSportsDistanceRecord, Length>`                 | Sum         |
| Six Minute Walk Test Distance | Distance covered during 6-minute walk test   | ❌                                                                                                                      | [HKQuantityTypeIdentifier.sixMinuteWalkTestDistance](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/sixminutewalktestdistance)   | `SixMinuteWalkTestDistanceDataType<SixMinuteWalkTestDistanceRecord, Length>`         | Sum         |

#### 📏 Body Measurements

| Data Type           | Description                | Android Health Connect                                                                                                               | iOS HealthKit                                                                                                                                | SDK Data Type                                                          | Aggregation   |
|---------------------|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|---------------|
| Weight              | Body weight measurement    | [WeightRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WeightRecord)                   | [HKQuantityTypeIdentifier.bodyMass](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymass)                   | `WeightHealthDataType<WeightRecord, Mass>`                             | Avg, Min, Max |
| Height              | Body height measurement    | [HeightRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeightRecord)                   | [HKQuantityTypeIdentifier.height](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/height)                       | `HeightHealthDataType<HeightRecord, Length>`                           | Avg, Min, Max |
| Body Fat Percentage | Percentage of body fat     | [BodyFatRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyFatRecord)                 | [HKQuantityTypeIdentifier.bodyFatPercentage](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodyfatpercentage) | `BodyFatPercentageHealthDataType<BodyFatPercentageRecord, Percentage>` | Avg, Min, Max |
| Lean Body Mass      | Mass of body excluding fat | [LeanBodyMassRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/LeanBodyMassRecord)       | [HKQuantityTypeIdentifier.leanBodyMass](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/leanbodymass)           | `LeanBodyMassHealthDataType<LeanBodyMassRecord, Mass>`                 | Avg, Min, Max |
| Body Temperature    | Core body temperature      | [BodyTemperatureRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyTemperatureRecord) | [HKQuantityTypeIdentifier.bodyTemperature](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodytemperature)     | `BodyTemperatureHealthDataType<BodyTemperatureRecord, Temperature>`    | Avg, Min, Max |

#### ❤️ Vitals

| Data Type                | Description                           | Android Health Connect                                                                                                                 | iOS HealthKit                                                                                                                                          | SDK Data Type                                                                     | Aggregation   |
|--------------------------|---------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|---------------|
| Heart Rate Series        | Heart rate measurements over time     | [HeartRateRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateRecord)               | ❌                                                                                                                                                      | `HeartRateSeriesRecordHealthDataType<HeartRateSeriesRecord, Frequency>`           | Avg, Min, Max |
| Heart Rate Measurement   | Single heart rate measurement         | ❌                                                                                                                                      | [HKQuantityTypeIdentifier.heartRate](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartrate)                           | `HeartRateMeasurementRecordHealthDataType<HeartRateMeasurementRecord, Frequency>` | Avg, Min, Max |
| Resting Heart Rate       | Heart rate while at rest              | [RestingHeartRateRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RestingHeartRateRecord) | [HKQuantityTypeIdentifier.restingHeartRate](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/restingheartrate)             | `RestingHeartRateHealthDataType<RestingHeartRateRecord, Frequency>`               | Avg, Min, Max |
| Blood Pressure           | Systolic and diastolic blood pressure | [BloodPressureRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodPressureRecord)       | [HKCorrelationTypeIdentifier.bloodPressure](https://developer.apple.com/documentation/healthkit/hkcorrelationtypeidentifier/bloodpressure/)            | `BloodPressureHealthDataType<BloodPressureRecord, Pressure>`                      | Avg, Min, Max |
| Systolic Blood Pressure  | Upper blood pressure value            | ❌                                                                                                                                      | [HKQuantityTypeIdentifier.bloodPressureSystolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressuresystolic)   | `SystolicBloodPressureHealthDataType<SystolicBloodPressureRecord, Pressure>`      | Avg, Min, Max |
| Diastolic Blood Pressure | Lower blood pressure value            | ❌                                                                                                                                      | [HKQuantityTypeIdentifier.bloodPressureDiastolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodpressurediastolic) | `DiastolicBloodPressureHealthDataType<DiastolicBloodPressureRecord, Pressure>`    | Avg, Min, Max |
| Oxygen Saturation        | Blood oxygen saturation percentage    | [OxygenSaturationRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OxygenSaturationRecord) | [HKQuantityTypeIdentifier.oxygenSaturation](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/oxygensaturation)             | `OxygenSaturationHealthDataType<OxygenSaturationRecord, Percentage>`              | Avg, Min, Max |
| Respiratory Rate         | Breathing rate (breaths per minute)   | [RespiratoryRateRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RespiratoryRateRecord)   | [HKQuantityTypeIdentifier.respiratoryRate](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/respiratoryrate)               | `RespiratoryRateHealthDataType<RespiratoryRateRecord, Frequency>`                 | Avg, Min, Max |
| VO₂ Max                  | Maximum oxygen consumption            | [Vo2MaxRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/Vo2MaxRecord)                     | [HKQuantityTypeIdentifier.vo2Max](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/vo2max)                                 | `Vo2MaxHealthDataType<Vo2MaxRecord, Vo2Max>`                                      | Avg, Min, Max |
| Blood Glucose            | Blood glucose concentration           | [BloodGlucoseRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodGlucoseRecord)         | [HKQuantityTypeIdentifier.bloodGlucose](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodglucose)                     | `BloodGlucoseHealthDataType<BloodGlucoseRecord, BloodGlucose>`                    | Avg, Min, Max |

#### 😴 Sleep

| Data Type          | Description                              | Android Health Connect                                                                                                         | iOS HealthKit                                                                                                                        | SDK Data Type                                                | Aggregation |
|--------------------|------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|-------------|
| Sleep Session      | Complete sleep session with sleep stages | [SleepSessionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SleepSessionRecord) | ❌                                                                                                                                    | `SleepSessionHealthDataType<SleepSessionRecord, Duration>`   | -           |
| Sleep Stage Record | Individual sleep stage measurement       | ❌                                                                                                                              | [HKCategoryTypeIdentifier.sleepAnalysis](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sleepanalysis) | `SleepStageRecordHealthDataType<SleepStageRecord, Duration>` | -           |

#### 🏋️ Exercise & Workouts

| Data Type        | Description                                           | Android Health Connect                                                                                                                     | iOS HealthKit                                                                                                | SDK Data Type                                                        | Aggregation |
|------------------|-------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|-------------|
| Exercise Session | Complete workout session with exercise type and stats | [ExerciseSessionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSessionRecord)       | [HKWorkout](https://developer.apple.com/documentation/healthkit/hkworkout)                                   | `ExerciseSessionHealthDataType<ExerciseSessionRecord, Duration>`     | Duration    |

The SDK supports **100+ exercise types** across both platforms. For complete exercise type
documentation, please see the [`ExerciseType` enum documentation](https://github.com/fam-tung-lam/health_connector/blob/main/packages/health_connector_core/lib/src/models/health_records/exercise_records/exercise_type.dart).

#### 🍎 Nutrition

##### Core & Hydration

| Data Type             | Description                                              | Android Health Connect                                                                                                                                  | iOS HealthKit                                                                                                                                        | SDK Data Type                                                                     | Aggregation |
|-----------------------|----------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|-------------|
| Nutrition (composite) | Complete nutrition record with macros and micronutrients | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)                                | [HKCorrelationType.food](https://developer.apple.com/documentation/healthkit/hkcorrelationtypeidentifier/food)                                       | `NutritionHealthDataType<NutritionRecord, Energy>`                                | -           |
| Energy                | Total energy intake from food                            | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.energy field) | [HKQuantityTypeIdentifier.dietaryEnergyConsumed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryenergyconsumed) | `EnergyNutrientHealthDataType<EnergyNutrientRecord, Energy>` (iOS HealthKit Only) | Sum         |
| Hydration/Water       | Water and fluid intake                                   | [HydrationRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HydrationRecord)                                | [HKQuantityTypeIdentifier.dietaryWater](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarywater)                   | `HydrationHealthDataType<HydrationRecord, Volume>`                                | Sum         |

##### Macronutrients

| Data Type          | Description        | Android Health Connect                                                                                                                              | iOS HealthKit                                                                                                                                       | SDK Data Type                                                                                   | Aggregation |
|--------------------|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------|-------------|
| Protein            | Protein intake     | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.protein)  | [HKQuantityTypeIdentifier.dietaryProtein](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryprotein)              | `ProteinNutrientDataType<ProteinNutrientRecord, Mass>` (iOS HealthKit Only)                     | Sum         |
| Total Carbohydrate | Total carbs intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.carbs)    | [HKQuantityType Identifier.dietaryCarbohydrates](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycarbohydrates) | `TotalCarbohydrateNutrientDataType<TotalCarbohydrateNutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Total Fat          | Total fat intake   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.totalFat) | [HKQuantityTypeIdentifier.dietaryFatTotal](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfattotal)            | `TotalFatNutrientDataType<TotalFatNutrientRecord, Mass>` (iOS HealthKit Only)                   | Sum         |
| Caffeine           | Caffeine intake    | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.caffeine) | [HKQuantityTypeIdentifier.dietaryCaffeine](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycaffeine)            | `CaffeineNutrientDataType<CaffeineNutrientRecord, Mass>` (iOS HealthKit Only)                   | Sum         |

##### Fats

| Data Type           | Description                | Android Health Connect                                                                                                                                        | iOS HealthKit                                                                                                                                                | SDK Data Type                                                                                     | Aggregation |
|---------------------|----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|-------------|
| Saturated Fat       | Saturated fat intake       | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.saturatedFat)       | [HKQuantityTypeIdentifier.dietaryFatSaturated](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatsaturated)             | `SaturatedFatNutrientDataType<SaturatedFatNutrientRecord, Mass>` (iOS HealthKit Only)             | Sum         |
| Monounsaturated Fat | Monounsaturated fat intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.monounsaturatedFat) | [HKQuantityTypeIdentifier.dietaryFatMonounsaturated](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatmonounsaturated) | `MonounsaturatedFatNutrientDataType<MonounsaturatedFatNutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Polyunsaturated Fat | Polyunsaturated fat intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.polyunsaturatedFat) | [HKQuantityTypeIdentifier.dietaryFatPolyunsaturated](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatpolyunsaturated) | `PolyunsaturatedFatNutrientDataType<PolyunsaturatedFatNutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Cholesterol         | Cholesterol intake         | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.cholesterol)        | [HKQuantityTypeIdentifier.dietaryCholesterol](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycholesterol)               | `CholesterolNutrientDataType<CholesterolNutrientRecord, Mass>` (iOS HealthKit Only)               | Sum         |

##### Fiber & Sugar

| Data Type     | Description          | Android Health Connect                                                                                                                                  | iOS HealthKit                                                                                                                      | SDK Data Type                                                                         | Aggregation |
|---------------|----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|-------------|
| Dietary Fiber | Dietary fiber intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.dietaryFiber) | [HKQuantityTypeIdentifier.dietaryFiber](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfiber) | `DietaryFiberNutrientDataType<DietaryFiberNutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Sugar         | Sugar intake         | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.sugar)        | [HKQuantityTypeIdentifier.dietarySugar](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarysugar) | `SugarNutrientDataType<SugarNutrientRecord, Mass>` (iOS HealthKit Only)               | Sum         |

##### Minerals

| Data Type  | Description       | Android Health Connect                                                                                                                                | iOS HealthKit                                                                                                                                | SDK Data Type                                                                     | Aggregation |
|------------|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|-------------|
| Calcium    | Calcium intake    | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.calcium)    | [HKQuantityTypeIdentifier.dietaryCalcium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycalcium)       | `CalciumNutrientDataType<CalciumNutrientRecord, Mass>` (iOS HealthKit Only)       | Sum         |
| Iron       | Iron intake       | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.iron)       | [HKQuantityTypeIdentifier.dietaryIron](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryiron)             | `IronNutrientDataType<IronNutrientRecord, Mass>` (iOS HealthKit Only)             | Sum         |
| Magnesium  | Magnesium intake  | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.magnesium)  | [HKQuantityTypeIdentifier.dietaryMagnesium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarymagnesium)   | `MagnesiumNutrientDataType<MagnesiumNutrientRecord, Mass>` (iOS HealthKit Only)   | Sum         |
| Manganese  | Manganese intake  | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.manganese)  | [HKQuantityTypeIdentifier.dietaryManganese](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarymanganese)   | `ManganeseNutrientDataType<ManganeseNutrientRecord, Mass>` (iOS HealthKit Only)   | Sum         |
| Phosphorus | Phosphorus intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.phosphorus) | [HKQuantityTypeIdentifier.dietaryPhosphorus](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryphosphorus) | `PhosphorusNutrientDataType<PhosphorusNutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Potassium  | Potassium intake  | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.potassium)  | [HKQuantityTypeIdentifier.dietaryPotassium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarypotassium)   | `PotassiumNutrientDataType<PotassiumNutrientRecord, Mass>` (iOS HealthKit Only)   | Sum         |
| Selenium   | Selenium intake   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.selenium)   | [HKQuantityTypeIdentifier.dietarySelenium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryselenium)     | `SeleniumNutrientDataType<SeleniumNutrientRecord, Mass>` (iOS HealthKit Only)     | Sum         |
| Sodium     | Sodium intake     | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.sodium)     | [HKQuantityTypeIdentifier.dietarySodium](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarysodium)         | `SodiumNutrientDataType<SodiumNutrientRecord, Mass>` (iOS HealthKit Only)         | Sum         |
| Zinc       | Zinc intake       | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.zinc)       | [HKQuantityTypeIdentifier.dietaryZinc](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryzinc)             | `ZincNutrientDataType<ZincNutrientRecord, Mass>` (iOS HealthKit Only)             | Sum         |

##### B Vitamins

| Data Type             | Description                   | Android Health Connect                                                                                                                                     | iOS HealthKit                                                                                                                                          | SDK Data Type                                                                               | Aggregation |
|-----------------------|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|-------------|
| Thiamin (B1)          | Thiamin (vitamin B1) intake   | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.thiamin)         | [HKQuantityTypeIdentifier.dietaryThiamin](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarythiamin)                 | `ThiaminNutrientDataType<ThiaminNutrientRecord, Mass>` (iOS HealthKit Only)                 | Sum         |
| Riboflavin (B2)       | Riboflavin (vitamin B2)       | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.riboflavin)      | [HKQuantityTypeIdentifier.dietaryRiboflavin](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryriboflavin)           | `RiboflavinNutrientDataType<RiboflavinNutrientRecord, Mass>` (iOS HealthKit Only)           | Sum         |
| Niacin (B3)           | Niacin (vitamin B3) intake    | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.niacin)          | [HKQuantityTypeIdentifier.dietaryNiacin](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryniacin)                   | `NiacinNutrientDataType<NiacinNutrientRecord, Mass>` (iOS HealthKit Only)                   | Sum         |
| Pantothenic Acid (B5) | Pantothenic acid (vitamin B5) | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.pantothenicAcid) | [HKQuantityTypeIdentifier.dietaryPantothenicAcid](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarypantothenicacid) | `PantothenicAcidNutrientDataType<PantothenicAcidNutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Vitamin B6            | Vitamin B6 intake             | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminB6)       | [HKQuantityTypeIdentifier.dietaryVitaminB6](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb6)             | `VitaminB6NutrientDataType<VitaminB6NutrientRecord, Mass>` (iOS HealthKit Only)             | Sum         |
| Biotin (B7)           | Biotin (vitamin B7) intake    | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.biotin)          | [HKQuantityTypeIdentifier.dietaryBiotin](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarybiotin)                   | `BiotinNutrientDataType<BiotinNutrientRecord, Mass>` (iOS HealthKit Only)                   | Sum         |
| Folate (B9)           | Folate (vitamin B9) intake    | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.folate)          | [HKQuantityTypeIdentifier.dietaryFolate](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfolate)                   | `FolateNutrientDataType<FolateNutrientRecord, Mass>` (iOS HealthKit Only)                   | Sum         |
| Vitamin B12           | Vitamin B12 intake            | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminB12)      | [HKQuantityTypeIdentifier.dietaryVitaminB12](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminb12)           | `VitaminB12NutrientDataType<VitaminB12NutrientRecord, Mass>` (iOS HealthKit Only)           | Sum         |

##### Other Vitamins

| Data Type | Description      | Android Health Connect                                                                                                                              | iOS HealthKit                                                                                                                            | SDK Data Type                                                                 | Aggregation |
|-----------|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|-------------|
| Vitamin A | Vitamin A intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminA) | [HKQuantityTypeIdentifier.dietaryVitaminA](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamina) | `VitaminANutrientDataType<VitaminANutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Vitamin C | Vitamin C intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminC) | [HKQuantityTypeIdentifier.dietaryVitaminC](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitaminc) | `VitaminCNutrientDataType<VitaminCNutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Vitamin D | Vitamin D intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminD) | [HKQuantityTypeIdentifier.dietaryVitaminD](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamind) | `VitaminDNutrientDataType<VitaminDNutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Vitamin E | Vitamin E intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminE) | [HKQuantityTypeIdentifier.dietaryVitaminE](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamine) | `VitaminENutrientDataType<VitaminENutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |
| Vitamin K | Vitamin K intake | [NutritionRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord) (NutritionRecord.vitaminK) | [HKQuantityTypeIdentifier.dietaryVitaminK](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamink) | `VitaminKNutrientDataType<VitaminKNutrientRecord, Mass>` (iOS HealthKit Only) | Sum         |

#### 🏃 Speed

| Data Type           | Description                   | Android Health Connect                                                                                           | iOS HealthKit                                                                                                                                | SDK Data Type                                                   | Aggregation |
|---------------------|-------------------------------|------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------|-------------|
| Speed Series        | Speed measurements over time  | [SpeedRecord](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SpeedRecord) | ❌                                                                                                                                            | `SpeedSeriesDataType<SpeedSeriesRecord, Velocity>`              | -           |
| Walking Speed       | Walking speed measurement     | ❌                                                                                                                | [HKQuantityTypeIdentifier.walkingSpeed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingspeed)           | `WalkingSpeedDataType<WalkingSpeedRecord, Velocity>`            | -           |
| Running Speed       | Running speed measurement     | ❌                                                                                                                | [HKQuantityTypeIdentifier.runningSpeed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningspeed)           | `RunningSpeedDataType<RunningSpeedRecord, Velocity>`            | -           |
| Stair Ascent Speed  | Speed while climbing stairs   | ❌                                                                                                                | [HKQuantityTypeIdentifier.stairAscentSpeed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairascentspeed)   | `StairAscentSpeedDataType<StairAscentSpeedRecord, Velocity>`    | -           |
| Stair Descent Speed | Speed while descending stairs | ❌                                                                                                                | [HKQuantityTypeIdentifier.stairDescentSpeed](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairdescentspeed) | `StairDescentSpeed DataType<StairDescentSpeedRecord, Velocity>` | -           |

### 🔄 Migration Guides

- [Migration Guide from `v1.x.x` to `v2.x.x`](../../doc/guides/migration_guides/migration-guide-v1.x.x-to-v2.x.x.md)

### 🤝 Contributing

Contributions are welcome! See our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues) to report bugs or request features.

#### Development Setup

```bash
# Clone the repository
git clone https://github.com/fam-tung-lam/health_connector.git
cd health_connector

# Bootstrap the monorepo
melos bootstrap

# Install dependencies
melos get

# Run analysis
melos analyze:dart
```

#### Code Style

This project uses `health_connector_lint` for consistent code style. Run `dart analyze` before submitting PRs.

### 📄 License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.

### 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.
