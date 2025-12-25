# Permissions

Health data access requires explicit user permission on both platforms. The `health_connector` SDK
provides a unified API for managing permissions across iOS HealthKit and Android Health Connect,
while handling platform-specific differences transparently.

## Permission Types

The SDK supports two categories of permissions:

### Data Permissions

Permissions to access specific health data types:

- **Read Permission**: Access to read health data for a specific data type
- **Write Permission**: Access to write health data for a specific data type

Each `HealthDataType` provides both read and write permission objects:

```dart
// Access permissions via HealthDataType
final stepsReadPermission = HealthDataType.steps.readPermission;
final stepsWritePermission = HealthDataType.steps.writePermission;
final weightReadPermission = HealthDataType.weight.readPermission;
final weightWritePermission = HealthDataType.weight.writePermission;
```

### Feature Permissions

Permissions to access platform features that enhance health data functionality:

- **Background Health Data Reading**: Access to read health data in the background
- **Historical Health Data Reading**: Access to read health data older than 30 days

```dart
// Access feature permissions via HealthPlatformFeature
final backgroundPermission = HealthPlatformFeature.readHealthDataInBackground.permission;
final historyPermission = HealthPlatformFeature.readHealthDataHistory.permission;
```

> **Note**: Feature availability varies by Android and Health Connect version. 
> Always check feature status before requesting permissions.

## Platform Differences

### iOS HealthKit

#### Read Permissions

- Always return `PermissionStatus.unknown` when checked via `getPermissionStatus()`
- This is intentional—Apple prevents apps from detecting whether users have health data by checking permission status
- Apps should always assume read permission may be granted and handle authorization errors gracefully

#### Write Permissions

- Return actual status (`granted` or `denied`) when checked via `getPermissionStatus()`

#### Feature Permissions

- All features are available and granted by default
- Always return `PermissionStatus.granted` when requested or checked

#### Permission Enumeration

- `getGrantedPermissions()` is **not available** on iOS
- Apps cannot enumerate what health data access they have been granted
- This protects user privacy by preventing apps from inferring what health data exists

#### Permission Revocation

- `revokeAllPermissions()` is **not available** on iOS
- Users must manually revoke permissions through the iOS Settings app
- This ensures users have full control and visibility over their health data permissions

### Android Health Connect

#### All Permissions

- Return actual status (`granted` or `denied`) when checked via `getPermissionStatus()`

#### Feature Permissions

- Feature availability depends on Android version and Health Connect SDK version
- Some features require specific minimum versions
- Must check feature status before requesting permissions

#### Permission Enumeration

- `getGrantedPermissions()` is available
- Apps can query all currently granted permissions

#### Permission Revocation

- `revokeAllPermissions()` is available
- Apps can programmatically revoke all permissions

## Requesting Permissions

Request one or more permissions from the user:

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

### Checking Request Results

Each permission request returns a `PermissionRequestResult` with:

- `permission`: The permission that was requested
- `status`: The resulting permission status

```dart
final results = await connector.requestPermissions([
  HealthDataType.steps.writePermission,
]);

// Check if write permission was granted
final writeGranted = results.any((r) =>
    r.permission == HealthDataType.steps.writePermission &&
    r.status == PermissionStatus.granted);

if (writeGranted) {
  // Safe to write step records
} else {
  print('Write permission not granted');
}
```

## Checking Permission Status

### Individual Permission Status

Check the status of a specific permission:

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

### Permission Status Values

- **`PermissionStatus.granted`**: Permission has been explicitly granted
- **`PermissionStatus.denied`**: Permission has been explicitly denied
- **`PermissionStatus.unknown`**: Status cannot be determined (iOS read permissions only)

## Getting Granted Permissions (Android Only)

> **iOS Limitation**: This API is not available on iOS. HealthKit does not provide a way to query all granted permissions to protect user privacy. Apps cannot enumerate what health data access they have been granted.

Retrieve all permissions currently granted to your app:

```dart
try {
  final grantedPermissions = await connector.getGrantedPermissions();
  
  for (final permission in grantedPermissions) {
    if (permission is HealthDataPermission) {
      print('${permission.dataType} (${permission.accessType})');
    } else if (permission is HealthPlatformFeaturePermission) {
      print('Feature: ${permission.feature}');
    }
  }
} on UnsupportedOperationException {
  print('Only available on Android');
}
```

## Revoking All Permissions (Android Only)

> **iOS Limitation**: This API is not available on iOS. HealthKit requires users to manually revoke permissions through the iOS Settings app. This ensures users have full control and visibility over their health data permissions.

Programmatically revoke all permissions granted to your app:

```dart
try {
  await connector.revokeAllPermissions();
  print('All permissions revoked');
} on UnsupportedOperationException {
  print('Only available on Android');
}
```
