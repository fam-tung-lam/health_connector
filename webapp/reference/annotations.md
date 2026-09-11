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

## Exercise segment weight and SDK Extension 21 {#exercise-segment-weight-and-sdk-extension-21}

`ExerciseSessionSegmentEvent.weight` maps to [`ExerciseSegment.weight`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSegment#weight), which only exists on devices whose Health Connect Mainline module is at **SDK Extension 21 or higher**.

| Scenario | Writing a non-null weight | Value when read |
|---|---|---|
| Android 14+ with Mainline Extension 21+ | Persisted normally | Non-null |
| Android 14+ without the Extension 21 update | Throws `UnsupportedOperationException` | `null` |
| Android below 14 | Throws `UnsupportedOperationException` | `null` |
| iOS HealthKit | Throws `UnsupportedOperationException` | `null` |

Check the extended-fields capability before adding a weight:

```dart
final status = connector.getSupportStatusFor(
  ExerciseSessionSegmentEvent.extendedFieldsRequirements,
);
if (!status.isSupported) return;

final segment = ExerciseSessionSegmentEvent(
  startTime: startTime,
  endTime: endTime,
  segmentType: ExerciseSegmentType.benchPress,
  repetitions: 10,
  weight: Mass.kilograms(80), // needs SDK Extension 21+ on Android
);

await connector.writeRecord(exerciseSession);
```

::: danger This is a runtime check, not a compile-time one
`compileSdkExtension 19` in your Gradle config satisfies the **build**. The Extension 21 requirement is checked on the **device**. The same app binary succeeds on one Android 14 phone and throws on another, depending on whether that phone received the Mainline update — so you cannot test this away on a single device.
:::

<NextSteps
  :links="[
    { text: 'Platform differences', link: '/guide/concepts/platform-differences', description: 'Behavior that differs between health stores.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Catching UnsupportedOperationException as a branch.' },
    { text: 'Health data types', link: '/reference/health-data-types', description: 'Per-type platform availability.' },
  ]"
/>
