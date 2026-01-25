# Example

Example app demonstrating the iOS-specific `HealthConnectorHKClient` API for HealthKit.

## What It Demonstrates

This example showcases all public API methods of the `HealthConnectorHKClient` class:

- **Platform Status** - Check HealthKit availability
- **Permissions** - Request health data permissions
- **Feature Status** - Check HealthKit feature availability
- **Read Operations** - Read single records and paginated record lists
- **Write Operations** - Write single and multiple records
- **Update Operations** - Update existing health records
- **Aggregation** - Aggregate health data over time ranges
- **Delete Operations** - Delete records by time range or IDs

### Health Platform Features

On iOS HealthKit, all health platform features are available and granted by default. Unlike Android
Health Connect, HealthKit does not require separate feature permissions for capabilities like
background data reading or historical data access.

When using the plugin:

- `getFeatureStatus()` always returns `HealthPlatformFeatureStatus.available` for all features
- Requesting feature permissions always returns `PermissionStatus.granted`

```dart
// Feature status check - always returns available on iOS
final status = await client.getFeatureStatus(
  HealthPlatformFeature.readHealthDataInBackground,
);
// status == HealthPlatformFeatureStatus.available

// Feature permission request - always returns granted on iOS
final results = await client.requestPermissions([
  HealthPlatformFeature.readHealthDataInBackground,
  HealthPlatformFeature.readHealthDataHistory,
]);
// All results have PermissionStatus.granted
```

> **Note:** This behavior differs from Android Health Connect, where these features require
> explicit user consent and may not be available on all devices.

## Running the Example

```bash
cd packages/health_connector_hk_ios/example
flutter run
```

## Learn More

For detailed documentation, see the [package README](../../README.md).
