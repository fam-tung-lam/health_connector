# Permissions

The Health Connector SDK provides a unified, secure-by-default API for
managing user permissions across iOS HealthKit and Android Health Connect.

Accessing health data requires two types of permissions:

1. **Data Permissions**: Access to read or write specific types of health records (e.g., Steps, Weight).
2. **Feature Permissions**: Access to special platform capabilities (e.g., Background Updates, History).

## Permission Types

| Type                   | Description                                  | Usage Example                                                 |
|:-----------------------|:---------------------------------------------|:--------------------------------------------------------------|
| **Read Permission**    | Grants access to read existing data from the | `HealthDataType.steps.readPermission`                         |
|                        | health store.                                |                                                               |
| **Write Permission**   | Grants access to save new data to the health | `HealthDataType.steps.writePermission`                        |
|                        | store.                                       |                                                               |
| **Feature Permission** | Grants access to specific platform           | `HealthPlatformFeature.readHealthDataInBackground.permission` |
|                        | capabilities like background processing.     |                                                               |

## Platform Behaviors

iOS and Android have fundamental differences in how they handle health
permissions, particularly regarding privacy.

| Feature              | iOS HealthKit                                         | Android Health Connect                               |
|:---------------------|:------------------------------------------------------|:-----------------------------------------------------|
| **Read Permission**  | **Hidden**. Always returns `PermissionStatus.unknown` | **Visible**. Returns `granted` or `denied`.          |
| Status               | to prevent unrelated apps from inferring health       |                                                      |
|                      | conditions based on permission grants.                |                                                      |
| **Write Permission** | **Visible**. Returns `granted` or `denied`.           | **Visible**. Returns `granted` or `denied`.          |
| Status               |                                                       |                                                      |
| **Revocation**       | **User Only**. Users must manually revoke             | **App & User**. Apps can revoke their own            |
|                      | permissions in iOS Settings. Apps cannot              | permissions via `revokeAllPermissions()`, or         |
|                      | programmatically revoke permissions.                  | users can do it in settings.                         |
| **Enumeration**      | **Restricted**. You cannot get a list of all          | **Available**. You can use `getGrantedPermissions()` |
|                      | granted permissions.                                  | to see everything your app has access to.            |

## The Permission Workflow

A robust health app follows this pattern:

1. **Check Status**: See if you already have the permissions you need.
2. **Educate**: Show a custom UI explaining *why* you need these permissions before triggering the system dialog.
3. **Request**: Launch the system permission sheet.
4. **Handle**: Process the results and update your UI.

### 1. Check Status

```dart
// Check if we can write steps
final status = await connector.getPermissionStatus(
  HealthDataType.steps.writePermission,
);

if (status == PermissionStatus.denied) {
  // Permission are not granted.
}
```

### 2. Request Permissions

The `requestPermissions` method returns a list of results, one for each requested permission.

```dart
final permissions = [
  // 1. Data Permissions
  HealthDataType.steps.readPermission,
  HealthDataType.steps.writePermission,
  HealthDataType.heartRate.readPermission,
  
  // 2. Feature Permissions
  HealthPlatformFeature.readHealthDataInBackground.permission,
];

// Triggers the system dialog
final results = await connector.requestPermissions(permissions);
```

### 3. Handle Results

Process the results to determine if your app can proceed.

```dart
bool allEssentialPermissionsGranted = true;

for (final result in results) {
  print('${result.permission}: ${result.status}');
  
  if (result.status != PermissionStatus.granted) {
      if (Platform.isIOS && result.permission.accessType == AccessType.read) {
          // On iOS, read permissions always return 'unknown' even if granted.
          // We assume success here, but real verification happens when reading data.
          continue;
      }
      allEssentialPermissionsGranted = false;
  }
}

if (allEssentialPermissionsGranted) {
  _startHealthSync();
} else {
  _showPermissionDeniedError();
}
```
