# Setup troubleshooting

The failures that show up on a first integration, and what each one actually means. For a failure that reached your `catch` block with a code attached, use the [error code lookup](/reference/error-codes) instead.

## `getHealthPlatformStatus()` never returns `available`

<PlatformTabs>
<template #android>

Health Connect is a separate app, not part of the OS on every device. The status tells you which situation you are in:

| Cause | What to do |
|---|---|
| The Health Connect app is missing or outdated | Call `HealthConnector.launchHealthAppPageInAppStore()` and let the user install or update it |
| The device runs below API 26 | Health Connect is unavailable; hide health features |
| A device policy or parental control blocks health data | Nothing to fix in code — explain the restriction to the user |

```dart
final status = await HealthConnector.getHealthPlatformStatus();
if (status != HealthPlatformStatus.available) {
  await HealthConnector.launchHealthAppPageInAppStore();
  return;
}
```

</template>
<template #ios>

HealthKit ships with iOS, so unavailability almost always means the device itself has no health store:

| Cause | What to do |
|---|---|
| Running on iPad | HealthKit is not available; hide health features |
| Running on a simulator without Health configured | Test on a physical device |
| A restrictions profile blocks health data | Explain the restriction to the user |

</template>
</PlatformTabs>

## Permission prompt never appears

<PlatformTabs>
<template #android>

**Most likely: the type is not declared in your manifest.** Health Connect refuses to prompt for a permission the app never declared, and the SDK reports this as `ConfigurationException` with `permissionNotDeclared`. Every type needs its own `<uses-permission>` entry:

```xml
<uses-permission android:name="android.permission.health.READ_STEPS" />
<uses-permission android:name="android.permission.health.WRITE_STEPS" />
```

**Second most likely: `MainActivity` still extends `FlutterActivity`.** Permission requests use `registerForActivityResult`, which needs a `FragmentActivity` host. Switch to `FlutterFragmentActivity` — see [step two of the Android setup](/guide/installation#android-health-connect).

**Also check:** the user may have already answered. Health Connect limits how often an app can re-prompt for the same permissions; send them to Health Connect's settings instead of prompting again.

</template>
<template #ios>

**Most likely: a usage description is missing from `Info.plist`.** iOS silently refuses to show the authorization sheet if `NSHealthShareUsageDescription` (for reads) or `NSHealthUpdateUsageDescription` (for writes) is absent. The SDK surfaces this as `ConfigurationException` with `permissionNotDeclared`.

**Also check: the HealthKit capability.** If it is not enabled on the target in **Signing & Capabilities**, entitlement checks fail before any sheet is shown.

**iOS only asks once per type.** Once the user has answered for a data type, iOS will not present that type again — subsequent `requestPermissions()` calls return without a prompt. To re-decide, the user must go to **Settings → Health → Data Access & Devices**.

</template>
</PlatformTabs>

## Permission status is `unknown` on iOS

This is correct behavior, not a bug. HealthKit deliberately refuses to disclose read-authorization status so an app cannot infer what the user is hiding. Every iOS read permission reports `unknown`.

Design around it: run the query and treat an empty result as valid. Do not gate your UI on read status. If you genuinely need a signal, [the probe workaround](/guide/concepts/permissions#the-ios-read-status-problem) explains the tradeoff.

## `UnsupportedOperationException` on a call that works on the other platform

The API you called exists on one platform only. The common cases:

| Call | Available on | Why |
|---|---|---|
| `updateRecord()`, `updateRecords()` | Android only | HealthKit records are immutable |
| `getGrantedPermissions()` | Android only | HealthKit will not let apps enumerate grants |
| `revokeAllPermissions()` | Android only | iOS users revoke in Settings |
| A data type marked `@supportedOnAppleHealth…` | iOS, sometimes iOS 16/17/18+ | No Health Connect equivalent |

Check the [annotation reference](/reference/annotations), and branch on `HealthConnector.healthPlatform` when a feature is genuinely platform-specific. The [iOS update workaround](/guide/tasks/update#ios-delete-and-recreate) covers the most common of these.

## Writes succeed but the data does not appear

- **You are looking at the wrong app.** Health Connect and Apple Health both scope views by source. Filter by your app.
- **The time range excludes the record.** Both stores index by the record's own timestamps, not by when you wrote it. A record backdated outside your query range will not appear in it.
- **Android history limits.** Health Connect only exposes the last 30 days by default. Reading older data requires `HealthPlatformFeature.readHealthDataHistory`. iOS has no such limit.

## Reads return fewer records than expected

- **Pagination.** `readRecords()` returns one page. Follow `response.nextPageRequest` until it is `null` — see [paginating](/guide/tasks/read#paginate-through-large-ranges).
- **The 30-day Android window** again, if you are reading history.
- **Another app owns the data and the user did not grant that type.** Permissions are per data type, not per app.

## Build fails after upgrading to v3.9.0+

Health Connector v3.9.0 builds against Health Connect 1.2.0-alpha03, which requires SDK Extension 19 at compile time:

```groovy
android {
    compileSdkExtension 19
}
```

If the build now passes but a write throws at runtime with `UnsupportedOperationException`, you have hit the separate **SDK Extension 21** device check on `ExerciseSessionSegmentEvent.weight`. That one cannot be fixed in configuration — guard the write or omit the field. [Details](/reference/annotations#exercise-segment-weight-and-sdk-extension-21).

## Still stuck

The [Toolbox demo app](/resources/toolbox) runs every SDK operation against a real device. If a flow works there and not in your app, the difference is in configuration. If it fails there too, [open an issue](https://github.com/fam-tung-lam/health_connector/issues) with your device, OS version, Flutter version, and the logs from a `PrintLogProcessor`.

<NextSteps
  :links="[
    { text: 'Error code lookup', link: '/reference/error-codes', description: 'Every code, its cause, and its recovery strategy.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Structuring catch blocks around the exception hierarchy.' },
    { text: 'Configure logging', link: '/guide/tasks/logging', description: 'Turn on diagnostics, including native Kotlin and Swift output.' },
  ]"
/>
