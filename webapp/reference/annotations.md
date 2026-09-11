# Annotations

The SDK uses annotations to state platform support, OS-version floors, and usage constraints directly on the API. Reading them correctly is how you avoid shipping a call that throws on half your users' devices.

## The vocabulary

| Annotation | Means | What to do |
|---|---|---|
| `@supportedOnHealthConnect` | Android Health Connect only | Pass the corresponding `healthPlatformRequirements` to `getSupportStatusFor()` |
| `@supportedOnAppleHealth` | iOS HealthKit only | Same |
| `@supportedOnAppleHealthIOS16Plus` | iOS 16.0+ only | Check the corresponding capability; throws below iOS 16 |
| `@supportedOnAppleHealthIOS17Plus` | iOS 17.0+ only | Check the corresponding capability; throws below iOS 17 |
| `@supportedOnAppleHealthIOS18Plus` | iOS 18.0+ only | Check the corresponding capability; throws below iOS 18 |
| `@supportedOnHealthConnectSdkExtension21` | Health Connect SDK Extension 21+ | Call `getSupportStatusFor(ExerciseSessionSegmentEvent.extendedFieldsRequirements)` |
| `@readOnly` | System-calculated metric | Use `readRecords()` or `aggregate()` only; writing throws |
| `@internalUse` | Not part of the public API | Do not call from application code |

::: info Annotations combine
When several appear on one declaration, every constraint applies at once.
:::

Platform annotations are the documentation counterpart of
`healthPlatformRequirements`. Check a data type before using it:

```dart
final status = connector.getSupportStatusFor(
  HealthDataType.steps.healthPlatformRequirements,
);
if (!status.isSupported) return;
```

## Worked example

```dart
@supportedOnAppleHealthIOS16Plus
@readOnly
final class InfrequentMenstrualCycleEventRecord extends IntervalHealthRecord {
  @internalUse
  factory InfrequentMenstrualCycleEventRecord.internal({...}) {...}
}
```

Read that as three separate facts:

- **`@supportedOnAppleHealthIOS16Plus`** — iOS 16 or later only. Android and iOS 15 throw `UnsupportedOperationException`.
- **`@readOnly`** — HealthKit calculates this; you can read it, never write or delete it.
- **`@internalUse`** on the factory — that constructor exists for the SDK's own mappers.

Correct usage:

```dart
final connector = await HealthConnector.create();

try {
  // Recommended: Read-only types support reads and aggregates.
  final now = DateTime.now();
  final response = await connector.readRecords(
    HealthDataType.infrequentMenstrualCycleEvent.readInTimeRange(
      startTime: now.subtract(const Duration(days: 1)),
      endTime: now,
    ),
  );

  // Avoid: Never call an @internalUse factory.
  // final record = InfrequentMenstrualCycleEventRecord.internal(...);

  // Avoid: Never write a @readOnly type — throws UnsupportedOperationException.
  // await connector.writeRecord(record);
} on UnsupportedOperationException catch (e) {
  print('This type requires iOS 16 or later: $e');
}
```

::: tip Lint rules are planned
A future `health_connector_lint` release will surface these annotations through the Dart analyzer, so the constraints become analyzer warnings instead of documentation you have to remember.
:::

## Exercise segment weight and SDK Extension 21 {#exercise-segment-weight-and-sdk-extension-21}

`ExerciseSessionSegmentEvent.weight` is annotated `@supportedOnHealthConnectSdkExtension21`. It maps to [`ExerciseSegment.weight`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSegment#weight), which only exists on devices whose Health Connect Mainline module is at **SDK Extension 21 or higher**.

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
    { text: 'Platform differences', link: '/guide/concepts/platform-differences', description: 'Every divergence these annotations describe.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Catching UnsupportedOperationException as a branch.' },
    { text: 'Health data types', link: '/reference/health-data-types', description: 'Per-type platform availability.' },
  ]"
/>
