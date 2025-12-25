# Getting Started

Integrate health data access into your Flutter app with `health_connector`—a unified API for iOS
HealthKit and Android Health Connect. This guide will walk you through installation, platform setup,
and creating your first health data integration.

## Prerequisites

Before you begin, ensure you have:

| Requirement            | Version                | Notes                                |
|------------------------|------------------------|--------------------------------------|
| **Flutter**            | ≥3.3.0                 | Required for package compatibility   |
| **iOS**                | ≥15.0                  | For HealthKit integration            |
| **Android**            | API 26+ (Android 8.0+) | For Health Connect integration       |
| **Health Connect App** | Latest                 | Must be installed on Android devices |

> **Note**: Android users must have the Health Connect app installed. The SDK will check 
> availability at runtime and guide users to install it if needed.

## Installation

### Step 1: Add the Package

Add `health_connector` to your project using the Flutter CLI:

```bash
flutter pub add health_connector
```

Or manually add to your `pubspec.yaml`:

```yaml
dependencies:
  health_connector: ^1.4.0
```

Then install dependencies:

```bash
flutter pub get
```

### Step 2: Platform-Specific Setup

<details>
<summary><b>🍎 iOS HealthKit Setup</b></summary>

#### Enable HealthKit Capability

1. Open your iOS project in Xcode
2. Select your app target (`Runner`)
3. Navigate to the **Signing & Capabilities** tab
4. Click **+ Capability** button
5. Search for and add **HealthKit**

#### Configure Info.plist

Add usage description strings to explain why your app needs health data access. These descriptions
are shown to users when requesting permissions.

Open `ios/Runner/Info.plist` and add:

```xml
<dict>
    <!-- Existing keys -->

    <!-- Required: Explain why your app reads health data -->
    <key>NSHealthShareUsageDescription</key>
    <string>This app needs to read your health data to provide personalized fitness insights and track your wellness progress.</string>

    <!-- Required: Explain why your app writes health data -->
    <key>NSHealthUpdateUsageDescription</key>
    <string>This app needs to save health data to record your activities and sync them with the Health app.</string>
</dict>
```

> **Warning**: Apple reviews these descriptions carefully. Be specific about what data you access and why. Vague descriptions like "We need health data" may result in App Store rejection.

**Best Practices for Usage Descriptions:**

- ✅ Be specific about what data you access (e.g., "steps and weight")
- ✅ Explain the user benefit (e.g., "to track your fitness goals")
- ✅ Keep it concise but informative
- ❌ Avoid generic phrases like "to improve the app experience"
- ❌ Don't list features unrelated to health data

</details>

<details>
<summary><b>🤖 Android Health Connect Setup</b></summary>

#### Update AndroidManifest.xml

Open `android/app/src/main/AndroidManifest.xml` and configure Health Connect integration:

##### 1. Add Activity Alias for Permission Rationale

This allows Health Connect to display your app's permission rationale:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application>
        <!-- Your existing application configuration -->

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

    <!-- Health Connect permissions declared below -->
</manifest>
```

##### 2. Declare Health Data Permissions

Add permissions for each health data type your app will access. Each data type requires separate read and write permissions:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Existing manifest content -->

    <!-- Read permissions -->
    <uses-permission android:name="android.permission.health.READ_STEPS" />
    <uses-permission android:name="android.permission.health.READ_WEIGHT" />
    <uses-permission android:name="android.permission.health.READ_HEART_RATE" />
    <uses-permission android:name="android.permission.health.READ_DISTANCE" />
    <uses-permission android:name="android.permission.health.READ_ACTIVE_CALORIES_BURNED" />

    <!-- Write permissions -->
    <uses-permission android:name="android.permission.health.WRITE_STEPS" />
    <uses-permission android:name="android.permission.health.WRITE_WEIGHT" />
    <uses-permission android:name="android.permission.health.WRITE_HEART_RATE" />
    <uses-permission android:name="android.permission.health.WRITE_DISTANCE" />
    <uses-permission android:name="android.permission.health.WRITE_ACTIVE_CALORIES_BURNED" />
</manifest>
```

##### 3. Feature Permissions (Optional)

If your app needs advanced features, add these permissions:

```xml
<!-- Access health data in the background -->
<uses-permission android:name="android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND" />

<!-- Access health data older than 30 days -->
<uses-permission android:name="android.permission.health.READ_HEALTH_DATA_HISTORY" />
```

> **Important**:
>
> - You must declare a permission for **each** health data type your app accesses
> - Only declare permissions your app actually uses
> - See the complete [Health Connect permissions list](https://developer.android.com/health-and-fitness/guides/health-connect/plan/data-types) for all available data types

#### Declare Health Permissions in Play Console

When publishing to Google Play, you must:

1. Navigate to **App content** → **Data safety**
2. Declare all health data types your app accesses
3. Explain how and why you use each data type

</details>

## Initial Configuration

### Check Platform Availability

Before using the SDK, verify that the health platform is available on the device:

```dart
import 'package:health_connector/health_connector.dart';

Future<void> checkAvailability() async {
  final status = await HealthConnector.getHealthPlatformStatus();
  
  switch (status) {
    case HealthPlatformStatus.available:
      print('Health platform is ready');
      break;
    case HealthPlatformStatus.notInstalled:
      print('Health Connect app not installed (Android only)');
      // Guide user to install Health Connect
      break;
    case HealthPlatformStatus.notSupported:
      print('Health platform not supported on this device');
      break;
  }
}
```

**Platform Status Values:**

- **`HealthPlatformStatus.available`**: Platform is ready to use
- **`HealthPlatformStatus.notInstalled`**: Health Connect app not installed (Android only)
- **`HealthPlatformStatus.notSupported`**: Platform not supported on this OS version

### Create a Connector Instance

Initialize the `HealthConnector` with configuration options:

```dart
final connector = await HealthConnector.create(
  HealthConnectorConfig(
    isLoggerEnabled: true, // Enable logging for debugging
  ),
);
```

**Configuration Options:**

- `isLoggerEnabled`: Enable detailed logging for debugging (default: `false`)

> **Tip**: Enable logging during development to see detailed SDK operations. Disable it in production builds for better performance.

## Quick Start Example

Here's a complete working example that demonstrates the core SDK features:

```dart
import 'package:health_connector/health_connector.dart';

Future<void> quickStart() async {
  // 1. Check if health platform is available
  final status = await HealthConnector.getHealthPlatformStatus();
  if (status != HealthPlatformStatus.available) {
    print('Health platform not available: $status');
    return;
  }

  // 2. Create connector instance with logging enabled
  final connector = await HealthConnector.create(
    HealthConnectorConfig(isLoggerEnabled: true),
  );

  // 3. Request permissions for reading and writing step data
  final permissions = [
    HealthDataType.steps.readPermission,
    HealthDataType.steps.writePermission,
  ];

  final results = await connector.requestPermissions(permissions);

  // 4. Check if write permission was granted
  final writeGranted = results.any((r) =>
      r.permission == HealthDataType.steps.writePermission &&
      r.status == PermissionStatus.granted);

  if (!writeGranted) {
    print('Write permission not granted');
    return;
  }

  // 5. Write a new step record
  final newRecord = StepsRecord(
    id: HealthRecordId.none, // Always use .none for new records
    startTime: DateTime.now().subtract(Duration(hours: 1)),
    endTime: DateTime.now(),
    count: Numeric(1500),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  );

  try {
    final recordId = await connector.writeRecord(newRecord);
    print('✅ Record written with ID: $recordId');

    // 6. Read today's step records
    final readRequest = HealthDataType.steps.readInTimeRange(
      startTime: DateTime.now().subtract(Duration(days: 1)),
      endTime: DateTime.now(),
    );

    final response = await connector.readRecords(readRequest);

    print('\n📊 Step records from the last 24 hours:');
    for (final record in response.records) {
      print('  • ${record.count.value} steps (${record.startTime} - ${record.endTime})');
    }

    // 7. Aggregate total steps for today
    final aggregateRequest = HealthDataType.steps.aggregateSum(
      startTime: DateTime.now().subtract(Duration(days: 1)),
      endTime: DateTime.now(),
    );

    final total = await connector.aggregate(aggregateRequest);
    print('\n🏃 Total steps today: ${total.value}');

  } on NotAuthorizedException catch (e) {
    print('❌ Permission denied: ${e.message}');
  } on HealthConnectorException catch (e) {
    print('❌ Error: ${e.message}');
  }
}
```

**What This Example Demonstrates:**

1. ✅ Platform availability check
2. ✅ Connector initialization with configuration
3. ✅ Permission request for read and write access
4. ✅ Writing a new health record
5. ✅ Reading health records in a time range
6. ✅ Aggregating health data
7. ✅ Proper error handling

## Next Steps

Now that you have the basics working, explore specific SDK features:

### Core Operations

- **[Permissions](permissions.md)** - Learn about permission management, platform differences, and
  best practices
- **[Reading/Writing/Updating/Deleting/Aggregating Health Data](core_api.md)**:
    - Read health records with filtering and pagination
    - Write single or multiple health records atomically
    - Calculate totals, averages, min/max values

### Advanced Topics

- **[Health Data Types](health_data_types.md)** - Explore all 100+ supported health data types
- **[Health Records](health_records.md)** - Understand instant, interval, and series records
- **[Measurement Units](measurement_units.md)** - Work with type-safe measurement units
- **[Exceptions](exceptions.md)** - Handle errors and exceptions gracefully

### Example App

- **[Health Connector Toolbox](../../../../examples/health_connector_toolbox)** - Interactive
  toolbox app showcasing all SDK features

## Common Issues

### iOS: "HealthKit is not available on this device"

**Cause**: HealthKit is not supported on iOS Simulator or iPad devices without health sensors.

**Solution**: Test on a physical iPhone or iPod Touch running iOS 15.0 or later.

---

### Android: "Health Connect app is not installed"

**Cause**: The Health Connect app is not installed on the device.

**Solution**:

- Guide users to install Health Connect from the Play Store
- Use `HealthConnector.getHealthPlatformStatus()` to detect this and show appropriate UI

---

### iOS: Read permissions always return `PermissionStatus.unknown`

**Cause**: This is intentional iOS behavior. Apple prevents apps from detecting whether users have
health data.

**Solution**:

- Always attempt read operations even when status is `unknown`
- Handle `NotAuthorizedException` if permission is actually denied
- See the [Permissions](permissions.md) guide for handling iOS read permissions

---

### Android: "Permission denied" even after granting permissions

**Cause**: You may not have declared the permission in `AndroidManifest.xml`.

**Solution**:

- Verify that you've added the permission declaration for the specific data type
- Check both read and write permissions if you need both
- Rebuild the app after adding manifest permissions

---

### "Historical data older than 30 days is not available" (Android only)

**Cause**: By default, Health Connect only provides access to the last 30 days of data.

**Solution**:

1. Check if the history feature is available:

   ```dart
   final status = await connector.getFeatureStatus(
     HealthPlatformFeature.readHealthDataHistory,
   );
   ```

2. Request the history permission if available:

   ```dart
   await connector.requestPermissions([
     HealthPlatformFeature.readHealthDataHistory.permission,
   ]);
   ```

---

### Platform-specific features throw `UnsupportedOperationException`

**Cause**: Some operations are only available on specific platforms (e.g., `getGrantedPermissions()` is Android-only).

**Solution**:

- Wrap platform-specific calls in try-catch blocks
- Check platform before calling:

  ```dart
  if (Platform.isAndroid) {
    final granted = await connector.getGrantedPermissions();
  }
  ```

## Troubleshooting

If you encounter issues not covered above:

1. **Enable SDK logging** to see detailed operation logs:

   ```dart
   HealthConnector.create(
     HealthConnectorConfig(isLoggerEnabled: true),
   );
   ```

2. **Check the SDK version** - ensure you're using the latest version:

   ```bash
   flutter pub outdated
   flutter pub upgrade health_connector
   ```

3. **Review platform setup** - verify your `AndroidManifest.xml` and `Info.plist` configurations

4. **Check GitHub Issues** - search for similar issues at [github.com/fam-tung-lam/health_connector/issues](https://github.com/fam-tung-lam/health_connector/issues)

5. **File a bug report** - if you find a bug, please report it with:
   - SDK version
   - Platform and OS version  
   - Minimal reproduction code
   - Error logs with logging enabled
