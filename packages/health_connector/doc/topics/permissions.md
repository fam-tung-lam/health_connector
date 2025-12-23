# Permissions

Health data access requires explicit user permission on both platforms.

## Permission Types

- **Read**: Access to read health data
- **Write**: Access to write health data

## Usage

```dart
final permissions = [
  StepsHealthDataType().readPermission,
  WeightHealthDataType().writePermission,
];

await healthConnector.requestPermissions(permissions);
final statuses = await healthConnector.getPermissionStatuses(permissions);
```
