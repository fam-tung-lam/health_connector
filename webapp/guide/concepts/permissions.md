# Permissions

Permissions are the part of a health integration most likely to behave differently than you expect, because the two platforms disagree about how much they will tell you.

## The model

A permission is a typed object derived from what it grants access to:

```dart
// Data access, per type and per direction.
HealthDataType.steps.readPermission
HealthDataType.steps.writePermission

// Platform features, which are separate from data.
HealthPlatformFeature.readHealthDataInBackground.permission
HealthPlatformFeature.readHealthDataHistory.permission

// Exercise routes need both the route and the session permission.
HealthDataType.exerciseSession.readExerciseRoutePermission
```

Read and write are independent. Granting write access to steps does not imply read access, and users routinely grant one without the other.

## Three statuses, and what each means

```dart
switch (status) {
  case PermissionStatus.granted:
    // Access confirmed.
  case PermissionStatus.denied:
    // Explicitly refused, or revoked later.
  case PermissionStatus.unknown:
    // The platform will not say. Normal for every iOS read permission.
}
```

`unknown` is not an error state. Code that treats it as failure works on Android and breaks on iOS.

## The iOS read-status problem

HealthKit deliberately refuses to disclose read-authorization status. If it did, an app could enumerate what a user is choosing to hide — which is itself sensitive information. So on iOS, **every read permission reports `unknown`, always.**

The correct design is to stop asking and just query:

```dart
// Run the read; an empty result is a valid answer.
final response = await connector.readRecords(
  HealthDataType.steps.readInTimeRange(startTime: from, endTime: to),
);

if (response.records.isEmpty) {
  // Could be no data, could be no permission. Show the same empty state.
}
```

::: warning A workaround exists, with a real cost
You can infer denial by attempting a minimal read and catching `AuthorizationException`. This deliberately works around a privacy design, so use it only if your product genuinely cannot function without the signal.

```dart
Future<bool> hasReadPermission(HealthDataType dataType) async {
  try {
    await connector.readRecords(
      dataType.readInTimeRange(
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        endTime: DateTime.now(),
        pageSize: 1, // Keep the probe cheap.
      ),
    );
    return true;
  } on AuthorizationException {
    return false;
  }
}
```

Note that a successful read proves access; it does not distinguish "granted with no data" from "granted with data".
:::

## Android declares, iOS does not

On Android, every type you request must already exist as a `<uses-permission>` entry in `AndroidManifest.xml`. A missing declaration is not a denial — it is a `ConfigurationException` with `permissionNotDeclared`, and no amount of user consent will fix it. Only your build can.

On iOS there is no per-type manifest. You request types at runtime, and the only build-time requirement is the usage-description strings in `Info.plist`.

## What each platform allows you to do

| Operation | Android | iOS | Notes |
|---|:---:|:---:|---|
| Request permissions | ✓ | ✓ | Uniform API |
| Check a single permission | ✓ | Writes only | Reads always report `unknown` |
| List all granted permissions | ✓ | — | `UnsupportedOperationException` on iOS |
| Revoke all permissions | ✓ | — | iOS users revoke in Settings |
| Re-prompt after a decision | Limited | Never | iOS asks once per data type, ever |

That last row matters for onboarding design. **iOS presents the authorization sheet once per data type for the lifetime of the install.** If the user declines, calling `requestPermissions()` again does nothing visible. Ask at a moment when the value is obvious, not on first launch.

## Request narrowly, and late

Both platforms let you request several permissions at once, and it is tempting to ask for everything up front. Grant rates are consistently better when the request is tied to a visible feature — request step access when the user opens the steps screen, not during onboarding.

<NextSteps
  :links="[
    { text: 'Request permissions', link: '/guide/tasks/permissions', description: 'The concrete request, check, and revoke calls.' },
    { text: 'Check platform features', link: '/guide/tasks/features', description: 'Background reads and history access.' },
    { text: 'Platform differences', link: '/guide/concepts/platform-differences', description: 'Everything else that diverges between the stores.' },
  ]"
/>
