# Sleep tracking

Sleep is the one common health feature where the two platforms model the data differently, so it needs two read paths. This recipe covers both and reconciles them into a single shape your app can render.

::: danger Sleep does not have one cross-platform data type
`HealthDataType.sleepSession` is **Health Connect only**. It returns one series record per night, with the stages as samples inside it.

`HealthDataType.sleepStageRecord` is **HealthKit only**. It returns one interval record per stage, mapped from `HKCategoryTypeIdentifier.sleepAnalysis`.

There is no unified sleep type. Branch on the platform, then normalise.
:::

## The shared vocabulary

Both platforms use the same `SleepStage` enum, which is what makes reconciliation possible:

| Stage | Meaning |
|---|---|
| `SleepStage.inBed` | In bed, not necessarily asleep |
| `SleepStage.awake` | Awake during the sleep period |
| `SleepStage.sleeping` | Asleep, stage unspecified |
| `SleepStage.light` | Light sleep — called "core" sleep on HealthKit |
| `SleepStage.deep` | Deep sleep |
| `SleepStage.rem` | REM sleep |
| `SleepStage.outOfBed` | Out of bed during the sleep period |
| `SleepStage.unknown` | Fallback when the source did not say |

Not every source reports every stage. A phone-only sleep tracker often reports nothing finer than `sleeping`, while a watch reports `light`, `deep`, and `rem`. Design your UI to degrade to a single bar rather than assuming a full hypnogram.

## Read sleep on Android

One record per night; the stages are `samples` inside it.

```dart
Future<void> readSleepAndroid() async {
  await connector.requestPermissions([
    HealthDataType.sleepSession.readPermission,
  ]);

  final now = DateTime.now();
  final response = await connector.readRecords(
    HealthDataType.sleepSession.readInTimeRange(
      startTime: now.subtract(const Duration(days: 7)),
      endTime: now,
    ),
  );

  for (final session in response.records) {
    final total = session.endTime.difference(session.startTime);
    print('Night of ${session.startTime}: ${total.inHours}h in bed');

    // The stages live inside the one record.
    for (final stage in session.samples) {
      final length = stage.endTime.difference(stage.startTime);
      print('  ${stage.stageType.name}: ${length.inMinutes} min');
    }
  }
}
```

## Read sleep on iOS

One record per stage, so a single night arrives as many records that you group yourself.

```dart
Future<void> readSleepIos() async {
  await connector.requestPermissions([
    HealthDataType.sleepStageRecord.readPermission,
  ]);

  final now = DateTime.now();
  final response = await connector.readRecords(
    HealthDataType.sleepStageRecord.readInTimeRange(
      startTime: now.subtract(const Duration(days: 7)),
      endTime: now,
      sortDescriptor: SortDescriptor.timeAscending,
    ),
  );

  // Each record is one stage. Group them into nights yourself — a gap of
  // a few hours is the usual boundary.
  for (final stage in response.records) {
    final length = stage.endTime.difference(stage.startTime);
    print('${stage.startTime} ${stage.stageType.name}: ${length.inMinutes} min');
  }
}
```

::: warning There is no "sleep session" on iOS
HealthKit does not tell you where one night ends and the next begins. You have to infer it — typically by starting a new night whenever the gap between consecutive stages exceeds a threshold you choose. Pick that threshold deliberately; naps make it a product decision, not a technical one.
:::

## Normalising both into one shape

Define your own model, then fill it from whichever path applies:

```dart
class SleepNight {
  SleepNight({required this.start, required this.end, required this.stages});

  final DateTime start;
  final DateTime end;
  final Map<SleepStage, Duration> stages;

  Duration get asleep => stages.entries
      .where((e) => const {
            SleepStage.light,
            SleepStage.deep,
            SleepStage.rem,
            SleepStage.sleeping,
          }.contains(e.key))
      .fold(Duration.zero, (total, e) => total + e.value);
}

Future<List<SleepNight>> readSleep(DateTime from, DateTime to) async {
  try {
    // Android: each record is already a night.
    final response = await connector.readRecords(
      HealthDataType.sleepSession.readInTimeRange(startTime: from, endTime: to),
    );

    return response.records.map((session) {
      final stages = <SleepStage, Duration>{};
      for (final sample in session.samples) {
        stages[sample.stageType] = (stages[sample.stageType] ?? Duration.zero) +
            sample.endTime.difference(sample.startTime);
      }

      return SleepNight(
        start: session.startTime,
        end: session.endTime,
        stages: stages,
      );
    }).toList();
  } on UnsupportedOperationException {
    // iOS: stitch consecutive stage records into nights.
    final response = await connector.readRecords(
      HealthDataType.sleepStageRecord.readInTimeRange(
        startTime: from,
        endTime: to,
        sortDescriptor: SortDescriptor.timeAscending,
      ),
    );

    return _groupIntoNights(response.records, gap: const Duration(hours: 3));
  }
}
```

Catching `UnsupportedOperationException` rather than checking `HealthConnector.healthPlatform` keeps the branch in one place and stays correct if platform support changes.

## Writing sleep

```dart
// Android — one session carrying its stages.
final session = SleepSessionRecord(
  id: HealthRecordId.none,
  startTime: bedtime,
  endTime: wakeTime,
  samples: [
    SleepStageSample(
      startTime: bedtime,
      endTime: bedtime.add(const Duration(minutes: 20)),
      stageType: SleepStage.awake,
    ),
    SleepStageSample(
      startTime: bedtime.add(const Duration(minutes: 20)),
      endTime: wakeTime,
      stageType: SleepStage.light,
    ),
  ],
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.watch),
  ),
);

await connector.writeRecord(session);
```

::: warning `SleepSessionRecord` requires `id` and validates its duration
Unlike most record types, its constructor requires `id` explicitly — pass `HealthRecordId.none` for a new record. It also rejects sessions shorter than **1 minute** or longer than **24 hours** with an `InvalidArgumentException`, so validate user-entered times before constructing one.
:::

On iOS, write one `SleepStageRecord` per stage instead, each with its own `startTime`, `endTime`, and `stageType`.

## Aggregation is not available

Neither sleep type supports `aggregateSum` or any other metric — check the [data type explorer](/reference/health-data-types) and you will see no aggregation chips on either. Totals have to be computed in Dart from the records, as `SleepNight.asleep` does above. For a week of nights that is cheap; for a year, cache the computed totals and refresh only the nights that [`synchronize()`](/guide/tasks/synchronize) reports as changed.

<NextSteps
  :links="[
    { text: 'Health records', link: '/guide/concepts/records', description: 'Why sleep is a series on Android and an interval on iOS.' },
    { text: 'Platform differences', link: '/guide/concepts/platform-differences', description: 'The other places the stores diverge.' },
    { text: 'Synchronize incrementally', link: '/guide/tasks/synchronize', description: 'Refresh only the nights that changed.' },
  ]"
/>
