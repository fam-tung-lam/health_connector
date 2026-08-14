# Platform differences

The SDK makes the common path uniform. This page lists everywhere it deliberately does not — read it once before designing a cross-platform health feature, because each item here has changed someone's product decision.

## At a glance

| Operation | Android | iOS | What differs |
|---|:---:|:---:|---|
| Read | Yes | Yes | Android limits history to 30 days by default |
| Write | Yes | Yes | Both require per-type authorization |
| Update | Yes | — | HealthKit records are immutable |
| Delete | Yes | Yes | Both restrict deletion to your own records |
| Aggregate | Yes | Yes | Available metrics vary by data type |
| Incremental sync | Yes | Yes | Change tokens vs. anchored queries, unified |
| List granted permissions | Yes | — | HealthKit prevents enumeration |
| Revoke permissions | Yes | — | iOS users revoke in Settings |
| Read permission status | Yes | — | iOS always reports `unknown` |

## Records are immutable on iOS

HealthKit has no update operation. `updateRecord()` and `updateRecords()` are annotated `@supportedOnHealthConnect` and throw `UnsupportedOperationException` on iOS.

The workaround is delete plus re-create, which **changes the record's ID**. If your backend stores health record IDs as foreign keys, that reassignment has to be handled. See [Update records](/guide/tasks/update).

## iOS will not tell you about read access

Read-permission status is `unknown` on iOS by design, and there is no API that changes that. Build empty states that work without knowing why the result was empty. Full reasoning in [Permissions](/guide/concepts/permissions#the-ios-read-status-problem).

## iOS asks once, permanently

The HealthKit authorization sheet appears once per data type per install. A user who declines cannot be re-prompted from your app — they have to change it in **Settings → Health → Data Access & Devices**. Time your request to a moment where the benefit is visible.

## Android needs a manifest entry per type

Health Connect refuses to prompt for a type the app did not declare. This surfaces as `ConfigurationException` / `permissionNotDeclared` and is a build-time fix, never a runtime one:

```xml
<uses-permission android:name="android.permission.health.READ_STEPS" />
```

## Android limits history to 30 days

By default Health Connect only exposes the last 30 days of data. Older records require the `HealthPlatformFeature.readHealthDataHistory` permission. HealthKit has no equivalent restriction — a "show me last year" feature works on iOS out of the box and needs an extra grant on Android.

## Feature availability is dynamic on Android

Health Connect is an updatable app whose capabilities depend on its version and on the device's Mainline module level. iOS features are part of the OS, so `getFeatureStatus()` returns `available` and feature permissions return `granted` on iOS by default.

Always check before relying on an optional capability:

```dart
final status = await connector.getFeatureStatus(
  HealthPlatformFeature.readHealthDataInBackground,
);
```

The sharpest version of this is `ExerciseSessionSegmentEvent.weight`, which requires the device's Health Connect Mainline module to be at SDK Extension 21. The same app binary succeeds on one Android 14 device and throws on another. [Details](/reference/annotations#exercise-segment-weight-and-sdk-extension-21).

## Data types do not map one to one

Some measurements exist on only one store. Nutrition is the clearest case: HealthKit exposes each nutrient as its own identifier, while Health Connect models them as fields on a single `NutritionRecord`. The SDK follows the native modelling rather than inventing a synthetic middle ground, so a per-nutrient `HealthDataType` may be marked iOS-only even though the underlying value is writable on Android through `NutritionRecord`.

**Sleep splits the same way, and catches people out.** `HealthDataType.sleepSession` is Health Connect-only and returns one series record per night, holding the stages as samples. `HealthDataType.sleepStageRecord` is HealthKit-only and returns one interval record per stage. A cross-platform sleep feature needs both paths — see [Health records](/guide/concepts/records#the-three-shapes).

**Some iOS types have their own version floor.** Nineteen data types require iOS 16, 17, or 18 rather than the SDK's iOS 15 baseline — running speed and power metrics, several cycle-tracking events, and cycling cadence among them. The [data type explorer](/reference/health-data-types) shows the floor on the platform badge.

Check availability per type in the [data type explorer](/reference/health-data-types) before promising a feature on both platforms.

## Designing around all of this

- Treat "no data" and "no permission" as the same UI state.
- Never store a health record ID as a durable key without an iOS re-creation strategy.
- Check `getFeatureStatus()` for anything optional, and keep a fallback path.
- Branch on `HealthConnector.healthPlatform` only for genuinely platform-specific features; everything else should be shared code.

<NextSteps
  :links="[
    { text: 'Platform support reference', link: '/reference/platform-support', description: 'The same matrix, with version floors.' },
    { text: 'Annotations', link: '/reference/annotations', description: 'How constraints are marked in the API itself.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Catching UnsupportedOperationException cleanly.' },
  ]"
/>
