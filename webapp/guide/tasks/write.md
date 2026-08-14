# Write records

Writing is uniform across platforms. Two rules matter: a new record carries no platform ID yet, and batch writes are atomic.

## Write a single record

```dart
// 1. Build the record. `id` defaults to HealthRecordId.none, which marks the
//    record as new — the platform assigns the real identifier on write.
final record = StepsRecord(
  id: HealthRecordId.none,
  startTime: DateTime.now().subtract(const Duration(hours: 1)),
  endTime: DateTime.now(),
  count: Number(5000),
  metadata: Metadata.automaticallyRecorded(
    device: Device.fromType(DeviceType.phone),
  ),
);

// 2. Write it and keep the returned ID if you need to delete or update later.
final recordId = await connector.writeRecord(record);
print('Saved: $recordId');
```

::: tip Passing `id` explicitly is optional
Most record constructors default `id` to `HealthRecordId.none`, so you can simply omit it — the [recipes](/recipes/) do. Examples here pass it to make the new-versus-existing distinction visible. A few types, such as `SleepSessionRecord`, do require `id`, in which case pass `HealthRecordId.none` for a new record.
:::

## Write a batch

A batch can mix record types freely:

```dart
final now = DateTime.now();

final records = [
  StepsRecord(
    id: HealthRecordId.none,
    startTime: now.subtract(const Duration(hours: 3)),
    endTime: now.subtract(const Duration(hours: 2)),
    count: Number(1500),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  ),
  WeightRecord(
    id: HealthRecordId.none,
    time: now.subtract(const Duration(hours: 1)),
    weight: Mass.kilograms(70.5),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  ),
  HeightRecord(
    id: HealthRecordId.none,
    time: now,
    height: Length.meters(1.75),
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  ),
];

// Atomic: every record lands, or none does.
final ids = await connector.writeRecords(records);
print('Wrote ${ids.length} records');
```

::: tip Batch instead of looping
`writeRecords()` crosses the platform channel once. Calling `writeRecord()` in a loop crosses it once per record and gives up atomicity — on Android it can also push you toward `rateLimitExceeded`.
:::

## Series data is one record, not many

A common and expensive mistake is writing each sample as its own record. Series types exist precisely to avoid that:

```dart
// Correct: one record carrying many samples.
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

await connector.writeRecord(heartRate);
```

## Set metadata honestly

Both platforms surface provenance to users, and Health Connect uses it when resolving conflicts between sources.

```dart
// The user typed this value in.
Metadata.manualEntry()

// Hardware or an algorithm produced it.
Metadata.automaticallyRecorded(device: Device.fromType(DeviceType.watch))
```

## Read-only types cannot be written

Types annotated `@readOnly` represent metrics the platform computes. Writing one throws `UnsupportedOperationException`:

```dart
try {
  await connector.writeRecord(someReadOnlyRecord);
} on UnsupportedOperationException catch (e) {
  print('This data type is read-only: $e');
}
```

Check the [annotation reference](/reference/annotations) before designing a write path for an unfamiliar type.

<NextSteps
  :links="[
    { text: 'Update records', link: '/guide/tasks/update', description: 'Android updates, and the iOS delete-and-recreate pattern.' },
    { text: 'Delete records', link: '/guide/tasks/delete', description: 'By ID or by time range.' },
    { text: 'Health records', link: '/guide/concepts/records', description: 'Which shape each data type uses.' },
  ]"
/>
