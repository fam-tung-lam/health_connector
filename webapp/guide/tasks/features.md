# Check platform features

Platform features are capabilities that sit alongside data access — reading in the background, reaching further back in history. On Android their availability depends on the installed Health Connect version and the OS; on iOS they are part of the system.

::: info Platform behavior
**iOS** — HealthKit is built into the OS, so features report `HealthPlatformFeatureStatus.available` and their permissions are granted by default.

**Android** — availability depends on the Health Connect app version and the Android version. Always check before requesting.
:::

## Check availability first

```dart
final status = await connector.getFeatureStatus(
  HealthPlatformFeature.readHealthDataInBackground,
);

if (status == HealthPlatformFeatureStatus.available) {
  print('Feature is available on this device');
} else {
  print('Feature not available on this device');
}
```

Requesting a permission for a feature the device does not have wastes a prompt and confuses the user. Check, then request.

## Request the feature permission

Feature permissions go through the same `requestPermissions()` call as data permissions, and return the same `List<PermissionRequestResult>`:

```dart
final results = await connector.requestPermissions([
  HealthPlatformFeature.readHealthDataInBackground.permission,
]);

final granted = results.any(
  (result) => result.status == PermissionStatus.granted,
);

if (granted) {
  print('Feature permission granted');
} else {
  print('Feature permission denied');
}
```

On Android the permission must also be declared in your manifest, exactly like a data permission:

```xml
<uses-permission android:name="android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND" />
<uses-permission android:name="android.permission.health.READ_HEALTH_DATA_HISTORY" />
```

## The two features you will actually reach for

### Background reads

`HealthPlatformFeature.readHealthDataInBackground` lets your app read health data while it is not in the foreground. Availability is only half the story — the OS still decides when your background work runs, so treat any background sync as best-effort and reconcile on next launch.

### Historical access

`HealthPlatformFeature.readHealthDataHistory` lifts Health Connect's default 30-day window. Without it, a "your last year in review" feature silently returns only the last month on Android. iOS has no equivalent limit, which makes this an easy difference to miss until an Android user reports missing data.

## Always keep a fallback

Feature availability is a device-level fact you cannot control. Design the degraded path deliberately — and note that **available is not the same as granted**. A feature can exist on the device and still be denied by the user, so check both:

```dart
Future<DateTime> earliestReadableDate() async {
  final available = await connector.getFeatureStatus(
        HealthPlatformFeature.readHealthDataHistory,
      ) ==
      HealthPlatformFeatureStatus.available;

  if (!available) return DateTime.now().subtract(const Duration(days: 30));

  final granted = await connector.getPermissionStatus(
        HealthPlatformFeature.readHealthDataHistory.permission,
      ) ==
      PermissionStatus.granted;

  // Without the grant, Health Connect silently returns only 30 days.
  return DateTime.now().subtract(Duration(days: granted ? 365 : 30));
}
```

Checking availability alone is the subtle version of this bug: you would request 365 days, get 30, and show the user an incomplete year with no error to explain it.

<NextSteps
  :links="[
    { text: 'Request permissions', link: '/guide/tasks/permissions', description: 'Data permissions alongside feature permissions.' },
    { text: 'Synchronize incrementally', link: '/guide/tasks/synchronize', description: 'The main consumer of background reads.' },
    { text: 'Platform differences', link: '/guide/concepts/platform-differences', description: 'Why Android capability is dynamic.' },
  ]"
/>
