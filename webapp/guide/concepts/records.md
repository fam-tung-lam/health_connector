# Health records

Every piece of health data in the SDK is a record, and every record has one of three shapes. Knowing which shape your data is tells you which constructor fields exist and which time semantics apply.

## The three shapes

| Shape | Describes | Time fields | Examples |
|---|---|---|---|
| **Instant** | One measurement at one moment | `time` | Weight, blood glucose, body temperature |
| **Interval** | An event spanning a duration | `startTime`, `endTime` | Steps, hydration, exercise session |
| **Series** | Timestamped samples inside an interval | `startTime`, `endTime`, `samples` | Heart rate, speed, sleep session |

The shape is a property of the data, not a choice. Steps are always an interval because a step count without a window is meaningless; weight is always an instant because it is true at a point in time.

### Instant record

```dart
final weight = WeightRecord(
  id: HealthRecordId.none,
  time: DateTime.now(),
  zoneOffsetSeconds: 3600,
  weight: Mass.kilograms(72.5),
  metadata: Metadata.manualEntry(),
);
```

### Interval record

```dart
final steps = StepsRecord(
  id: HealthRecordId.none,
  startTime: start,
  endTime: end,
  startZoneOffsetSeconds: 3600,
  endZoneOffsetSeconds: 3600,
  count: Number(1500),
  metadata: Metadata.automaticallyRecorded(),
);
```

### Series record

```dart
final heartRate = HeartRateSeriesRecord(
  id: HealthRecordId.none,
  startTime: start,
  endTime: end,
  samples: [
    HeartRateSample(time: start, rate: Frequency.perMinute(65)),
    HeartRateSample(time: end, rate: Frequency.perMinute(80)),
  ],
  metadata: Metadata.automaticallyRecorded(),
);
```

A series is one record containing many samples — not many records. Writing 500 heart-rate samples as 500 individual records is the single most common performance mistake in a health integration.

::: warning Sleep is the one shape that splits by platform
`SleepSessionRecord` is a series of `SleepStageSample`s and exists on **Health Connect only**. HealthKit instead models each stage as its own `SleepStageRecord` interval, mapped from `HKCategoryTypeIdentifier.sleepAnalysis`.

```dart
// Android
HealthDataType.sleepSession      // series of stages, one record per night

// iOS
HealthDataType.sleepStageRecord  // one interval record per stage
```

So a cross-platform sleep feature needs two read paths and its own reconciliation into whatever "a night's sleep" means in your product. Both are searchable in the [data type explorer](/reference/health-data-types); note that `SleepSessionRecord` is also one of the few types whose constructor requires `id` explicitly.
:::

## Identity

`HealthRecordId` distinguishes a record you are creating from one the store already knows about.

```dart
// A record you are about to write.
id: HealthRecordId.none

// A record you read back — carries the platform-assigned identifier.
final id = record.id;
```

That identifier is what makes a record deletable, and on Android updatable. It is assigned by the platform, returned from `writeRecord()`/`writeRecords()`, and stable for the lifetime of the record.

::: warning IDs do not survive the iOS update workaround
HealthKit records are immutable, so "updating" on iOS means delete plus re-create — and the new record gets a new ID. If you store health record IDs in your own database, plan for that. See [Update records](/guide/tasks/update#ios-delete-and-recreate).
:::

## Time zones

Instant records take `zoneOffsetSeconds`; interval and series records take `startZoneOffsetSeconds` and `endZoneOffsetSeconds`. These preserve the offset that was in effect where the measurement happened, which is what lets "my Tuesday step count" stay correct after the user crosses a time zone. Store the offset from the moment of capture, not the offset at write time.

## Metadata

Metadata says how a record came to exist. Both platforms surface this to users, and Health Connect uses it in conflict resolution.

```dart
// A value the user typed in.
Metadata.manualEntry()

// A value produced by hardware or an algorithm.
Metadata.automaticallyRecorded(
  device: Device.fromType(DeviceType.phone),
)
```

Attach a `Device` whenever you know the source — a phone pedometer and a chest strap have very different trust characteristics, and users can see the difference in the native health apps.

## Reading records back

Because requests are built from a data type, responses arrive already typed:

```dart
final response = await connector.readRecords(
  HealthDataType.weight.readInTimeRange(startTime: from, endTime: to),
);

// List<WeightRecord> — record.weight is a Mass, no cast needed.
for (final record in response.records) {
  print(record.weight.inKilograms);
}
```

<NextSteps
  :links="[
    { text: 'Measurement units', link: '/guide/concepts/units', description: 'How Mass, Length, Energy and friends prevent unit bugs.' },
    { text: 'Data types & capabilities', link: '/guide/concepts/data-types', description: 'Why some types cannot be written or aggregated.' },
    { text: 'Write records', link: '/guide/tasks/write', description: 'Single writes, batch writes, and atomicity.' },
  ]"
/>
