# Exceptions

Structured error handling for health data operations across iOS HealthKit and Android Health Connect.

## Overview

### Exception Quick Reference

| Exception                                             | Platform     | Common Causes                  | Recovery Action         |
|-------------------------------------------------------|--------------|--------------------------------|-------------------------|
| `AuthorizationException`                              | Both         | Permission denied/revoked      | Guide user to settings  |
| `InvalidConfigurationException`                       | Both         | Missing manifest/plist entries | Fix app configuration   |
| `UnsupportedOperationException`                       | Both         | Platform-specific API called   | Check platform first    |
| `InvalidArgumentException`                            | Both         | Invalid input values           | Validate inputs         |
| `HealthPlatformUnavailableException`                  | Both         | Device/policy restrictions     | Disable health features |
| `HealthPlatformNotInstalledOrUpdateRequiredException` | Android only | Health Connect not installed   | Prompt installation     |
| `RemoteErrorException`                                | Both         | Transient I/O/IPC errors       | Retry with backoff      |
| `UnknownException`                                    | Both         | Unexpected platform errors     | Log and report          |

### Platform-Specific Behavior

#### iOS HealthKit

- **Read Permissions**: Always return `PermissionStatus.unknown` to protect user privacy
- **Update Records**: Not supported (immutable data model) - use delete + write instead
- **Revoke Permissions**: Must be done manually through iOS Settings app
- **Get Granted Permissions**: Not available for privacy reasons

#### Android Health Connect

- **Historical Data**: Limited to 30 days by default unless `readHealthDataHistory` permission is granted
- **Rate Limiting**: May throw `RemoteErrorException` if too many operations in a short time
- **Installation**: Requires Health Connect app installation (API 26+)

## Exception Types

### AuthorizationException

**Description**: Access to health data was denied or not yet authorized.

**Causes**:

- Permissions have not been requested yet
- User denied permissions in the system dialog
- Permissions were revoked via system settings

**Platform**: Both iOS and Android

**Recovery Actions**:

- If not yet requested: Trigger the permission request flow
- If denied: Explain why the feature needs access and guide user to settings
- Respect user choice; avoid repeated prompting

**Example**:

```dart
try {
  await connector.writeRecord(stepRecord);
} on AuthorizationException catch (e) {
  // Show dialog explaining why permission is needed
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Permission Required'),
      content: Text('This app needs permission to save health data. ${e.message}'),
      actions: [
        TextButton(
          onPressed: () => openAppSettings(),
          child: Text('Open Settings'),
        ),
      ],
    ),
  );
}
```

### InvalidConfigurationException

**Description**: The app configuration is missing or invalid.

**Causes**:

- **Android**: Missing permissions in `AndroidManifest.xml`
- **Android**: Missing Play Console health data declarations
- **iOS**: Missing HealthKit entitlement in Signing & Capabilities
- **iOS**: Missing usage description keys in `Info.plist`

**Platform**: Both iOS and Android

**Recovery Actions**:

- Check build logs and fix the app configuration
- This error should not occur in production if properly configured

**Example**:

```dart
try {
  final connector = await HealthConnector.create(config);
} on InvalidConfigurationException catch (e) {
  // Log error for developer attention
  developer.log(
    'Configuration error: ${e.message}',
    name: 'HealthConnector',
    error: e,
  );
  // Show user-friendly message
  showErrorDialog('Health features are not properly configured.');
}
```

### UnsupportedOperationException

**Description**: An API not supported by the current platform or version is used.

**Causes**:

- Calling an Android-specific API on iOS (or vice versa)
- Requesting a data type unsupported by the current SDK version

**Platform**: Both iOS and Android

**Recovery Actions**:

- Check platform/version before calling the API
- This error should not occur in production if properly guarded

**Example**:

```dart
try {
  // getGrantedPermissions() is Android-only
  final permissions = await connector.getGrantedPermissions();
} on UnsupportedOperationException catch (e) {
  if (Platform.isIOS) {
    // Expected on iOS - use alternative approach
    print('Feature not available on iOS');
  }
}
```

### InvalidArgumentException

**Description**: An invalid argument was provided to the API.

**Causes**:

- `startTime` is after `endTime`
- Value out of valid range (e.g., negative step count)
- Record ID does not exist (delete/update operations)

**Platform**: Both iOS and Android

**Recovery Actions**:

- Validate inputs before calling the plugin
- Refresh local record ID cache before delete/update operations

**Example**:

```dart
Future<void> readRecords(DateTime start, DateTime end) async {
  // Validate inputs first
  if (start.isAfter(end)) {
    throw ArgumentError('startTime must be before endTime');
  }
  
  try {
    final response = await connector.readRecords(
      HealthDataType.steps.readInTimeRange(
        startTime: start,
        endTime: end,
      ),
    );
  } on InvalidArgumentException catch (e) {
    print('Invalid argument: ${e.message}');
  }
}
```

### HealthPlatformUnavailableException

**Description**: The health platform is unavailable on this device.

**Causes**:

- Device does not support health API (Android <SDK 28, unsupported iPad)
- Enterprise policy (MDM) or parental controls block access
- Health service is explicitly disabled by the system
- Device is in a restricted profile (Android work profile)

**Platform**: Both iOS and Android

**Recovery Actions**:

- Inform the user that health features are not available on their device
- Gracefully disable health-related functionality

**Example**:

```dart
final status = await HealthConnector.getHealthPlatformStatus();

if (status == HealthPlatformStatus.unavailable) {
  // Disable health features in UI
  setState(() {
    healthFeaturesEnabled = false;
  });
  
  showNotification(
    'Health features are not available on this device',
    severity: NotificationSeverity.info,
  );
}
```

### HealthPlatformNotInstalledOrUpdateRequiredException

**Description**: The health platform needs to be installed or updated.

**Causes**:

- Health Connect app is not installed
- Health Connect app is outdated and requires an update

**Platform**: Android Health Connect only (iOS has Apple Health pre-installed)

**Recovery Actions**:

- Prompt the user to install or update Health Connect from the Play Store
- Provide a direct link to the Health Connect app

**Example**:

```dart
final status = await HealthConnector.getHealthPlatformStatus();

if (status == HealthPlatformStatus.installationOrUpdateRequired) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Health Connect Required'),
      content: Text('Please install or update Health Connect to use health features.'),
      actions: [
        TextButton(
          onPressed: () {
            launchUrl(Uri.parse(
              'https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata',
            ));
          },
          child: Text('Open Play Store'),
        ),
      ],
    ),
  );
}
```

### RemoteErrorException

**Description**: A transient I/O or communication error occurred.

**Causes**:

- Temporary disk I/O failure
- Inter-process communication (IPC) interrupted
- Background service temporarily unreachable
- Too many read/write operations in a short time window (Android Health Connect Only)

**Platform**: Both iOS and Android

**Recovery Actions**:

- Retry with exponential backoff (e.g., 1s → 2s → 4s, max 30s)
- These issues typically resolve quickly without user intervention

**Example**:

```dart
Future<void> writeRecordWithRetry(HealthRecord record) async {
  const maxRetries = 3;
  var retryDelay = Duration(seconds: 1);
  
  for (var attempt = 0; attempt < maxRetries; attempt++) {
    try {
      await connector.writeRecord(record);
      return; // Success
    } on RemoteErrorException catch (e) {
      if (attempt == maxRetries - 1) {
        rethrow; // Last attempt failed
      }
      
      print('Remote error, retrying in ${retryDelay.inSeconds}s: ${e.message}');
      await Future.delayed(retryDelay);
      retryDelay *= 2; // Exponential backoff
    }
  }
}
```

### UnknownException

**Description**: An unknown or unexpected error occurred.

**Causes**:

- Unmapped native error code
- Internal platform bug
- New error type from SDK update

**Platform**: Both iOS and Android

**Recovery Actions**:

- Log the full error details for investigation
- Show a generic "Something went wrong" message to the user
- Report to crash analytics

**Example**:

```dart
try {
  await connector.writeRecord(record);
} on UnknownException catch (e, stackTrace) {
  // Log to analytics
  crashlytics.recordError(
    e,
    stackTrace,
    reason: 'Unknown health connector error',
  );
  
  // Show generic error to user
  showErrorDialog('An unexpected error occurred. Please try again.');
}
```

## Error Handling Approaches

### Approach 1: Type-Based Exception Handling

Catch specific exception types using Dart's type-based exception handling:

```dart
try {
  await connector.requestPermissions([
    HealthDataType.steps.writePermission,
  ]);
  await connector.writeRecord(stepRecord);
} on AuthorizationException catch (e) {
  // User denied or revoked permissions
  print('Permission denied: ${e.message}');
  guideUserToSettings();
} on InvalidConfigurationException catch (e) {
  // Missing configuration
  developer.log('Configuration error: ${e.message}');
} on UnsupportedOperationException catch (e) {
  // Platform doesn't support this operation
  print('Not supported: ${e.message}');
  useAlternativeApproach();
} on InvalidArgumentException catch (e) {
  // Invalid input
  print('Invalid argument: ${e.message}');
  validateInputs();
} on HealthPlatformUnavailableException catch (e) {
  // Device doesn't support health API
  print('Health unavailable: ${e.message}');
  disableHealthFeatures();
} on HealthPlatformNotInstalledOrUpdateRequiredException catch (e) {
  // Health Connect needs installation/update
  print('Health Connect needs update: ${e.message}');
  promptHealthConnectInstall();
} on RemoteErrorException catch (e) {
  // Transient I/O or communication error
  print('Remote error: ${e.message}');
  retryWithBackoff();
} on UnknownException catch (e) {
  // Unexpected error
  reportToAnalytics(e);
  showGenericError();
} on HealthConnectorException catch (e) {
  // Generic fallback
  print('Error [${e.code}]: ${e.message}');
}
```

### Approach 2: Code-Based Exception Handling

Catch the base exception and switch on the error code:

```dart
try {
  await connector.requestPermissions([...]);
  await connector.writeRecord(record);
} on HealthConnectorException catch (e) {
  switch (e.code) {
    case HealthConnectorErrorCode.permissionNotGranted:
      print('Permission denied: ${e.message}');
      guideUserToSettings();
      
    case HealthConnectorErrorCode.invalidConfiguration:
      developer.log('Configuration error: ${e.message}');
      
    case HealthConnectorErrorCode.unsupportedOperation:
      print('Not supported: ${e.message}');
      useAlternativeApproach();
      
    case HealthConnectorErrorCode.invalidArgument:
      print('Invalid argument: ${e.message}');
      validateInputs();
      
    case HealthConnectorErrorCode.healthPlatformUnavailable:
      print('Health unavailable: ${e.message}');
      disableHealthFeatures();
      
    case HealthConnectorErrorCode.healthPlatformNotInstalledOrUpdateRequired:
      print('Health Connect needs update: ${e.message}');
      promptHealthConnectInstall();
      
    case HealthConnectorErrorCode.remoteError:
      print('Remote error: ${e.message}');
      retryWithBackoff();
      
    case HealthConnectorErrorCode.unknown:
      reportToAnalytics(e);
      showGenericError();
  }
}
```
