# Annotations

The SDK uses annotations for API lifecycle and usage constraints. Platform and
OS-version support is represented at runtime by `healthPlatformRequirements`.

## The vocabulary

| Annotation | Means | What to do |
|---|---|---|
| `@readOnly` | System-calculated metric | Use `readRecords()` or `aggregate()` only; writing throws |
| `@internalUse` | Not part of the public API | Do not call from application code |
| `@experimentalApi` | API may change before stabilization | Review release notes before upgrading |
| `@sinceV…` | Release that introduced the API | Use it to confirm the minimum SDK version |

## Deprecated platform annotations

The legacy `supportedOn…` annotations remain in the internal core library for
compatibility and are deprecated for removal in 4.0.0. Do not add new usages.

| Deprecated annotation | Runtime replacement |
|---|---|
| `supportedOnHealthConnect` | `HealthConnectRequirement.none` |
| `supportedOnHealthConnectSdkExtension21` | `HealthConnectRequirement.android14OrLaterWithSDKExtension21` |
| `supportedOnAppleHealth` | `AppleHealthRequirement.none` |
| `supportedOnAppleHealthIOS16Plus` | `AppleHealthRequirement.ios16OrLater` |
| `supportedOnAppleHealthIOS17Plus` | `AppleHealthRequirement.ios17OrLater` |
| `supportedOnAppleHealthIOS18Plus` | `AppleHealthRequirement.ios18OrLater` |

Platform availability is queryable before an operation:

```dart
final status = connector.getSupportStatusFor(
  HealthDataType.infrequentMenstrualCycleEvent.healthPlatformRequirements,
);
if (!status.isSupported) return;
```

The requirement list is the single source of truth. It identifies supported
platforms and any minimum iOS, Android API, or Health Connect SDK Extension
version. See [Runtime requirements](/reference/requirements#runtime-availability).

## Exercise segment weight, set index, and RPE (SDK Extension 21) {#exercise-segment-weight-and-sdk-extension-21}

`ExerciseSessionSegmentEvent.weight`, `.setIndex`, and
`.rateOfPerceivedExertion` map to
[`ExerciseSegment.weight`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSegment#weight),
[`ExerciseSegment.setIndex`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSegment#setIndex),
and
[`ExerciseSegment.rateOfPerceivedExertion`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSegment#rateOfPerceivedExertion),
respectively. All three require a device whose Health Connect Mainline module is
at **SDK Extension 21 or higher**.

| Scenario | Writing a non-null value | Value when read |
|---|---|---|
| Android 14+ with Mainline Extension 21+ | Persisted normally | Non-null |
| Android 14+ without the Extension 21 update | Throws `UnsupportedOperationException` | `null` |
| Android below 14 | Throws `UnsupportedOperationException` | `null` |
| iOS HealthKit | Throws `UnsupportedOperationException` | `null` |

Check the extended-fields requirements before adding any of these fields:

```dart
final status = connector.getSupportStatusFor(
  ExerciseSessionSegmentEvent.extendedFieldsRequirements,
);
final supportsExtendedFields = status.isSupported;

final segment = ExerciseSessionSegmentEvent(
  startTime: startTime,
  endTime: endTime,
  segmentType: ExerciseSegmentType.benchPress,
  repetitions: 10,
  weight: supportsExtendedFields ? Mass.kilograms(80) : null,
  setIndex: supportsExtendedFields ? 0 : null,
  rateOfPerceivedExertion: supportsExtendedFields ? 7.5 : null,
);

try {
  await connector.writeRecord(exerciseSession);
} on UnsupportedOperationException catch (e) {
  // Omit the fields, or tell the user their device cannot store them.
  print('Segment weight, set index, or RPE not supported on this device: $e');
}
```

::: danger This is a runtime check, not a compile-time one
`compileSdkExtension 19` in your Gradle config satisfies the **build**. The
Extension 21 requirement is checked on the **device**. The same app binary
succeeds on one Android 14 phone and throws on another, depending on whether
that phone received the Mainline update. Use `getSupportStatusFor()` to check
the immutable operating-system snapshot captured when the connector is created,
and retain an unsupported-operation fallback.
:::

<NextSteps
  :links="[
    { text: 'Platform differences', link: '/guide/concepts/platform-differences', description: 'Behavior that differs between health stores.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Catching UnsupportedOperationException as a branch.' },
    { text: 'Health data types', link: '/reference/health-data-types', description: 'Per-type platform availability.' },
  ]"
/>
