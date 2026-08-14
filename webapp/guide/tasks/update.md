# Update records

<Badge type="warning" text="Android only" />

Health Connect supports in-place updates. HealthKit does not — its data model is immutable — so iOS needs a different pattern with a consequence worth planning for.

## Update a single record

```dart
// 1. Read the record you intend to change.
final record = await connector.readRecord(
  HealthDataType.steps.readById(HealthRecordId('record-id')),
);

// 2. Write back a modified copy. The ID is preserved.
await connector.updateRecord(
  record.copyWith(count: Number(record.count.value + 500)),
);
print('Record updated');
```

## Update a batch

```dart
// 1. Read the records in range.
final response = await connector.readRecords(
  HealthDataType.steps.readInTimeRange(
    startTime: DateTime.now().subtract(const Duration(days: 7)),
    endTime: DateTime.now(),
  ),
);

// 2. Apply the change.
final updated = response.records
    .map((r) => r.copyWith(count: Number(r.count.value + 100)))
    .toList();

// 3. Atomic — all succeed or all fail.
await connector.updateRecords(updated);
print('Updated ${updated.length} records');
```

## iOS: delete and recreate {#ios-delete-and-recreate}

There is no update on HealthKit. Replace the record instead:

```dart
// 1. Remove the old record.
await connector.deleteRecords(
  HealthDataType.steps.deleteByIds([existingRecord.id]),
);

// 2. Build a replacement — note HealthRecordId.none.
final newRecord = existingRecord.copyWith(
  id: HealthRecordId.none,
  count: Number(newValue),
);

// 3. Write it. The platform assigns a new identifier.
final newId = await connector.writeRecord(newRecord);
```

::: danger The record ID changes
The replacement is a different record as far as the platform is concerned. If your backend stores health record IDs as keys, you must update your own mapping after every iOS "update", or you will orphan rows and issue deletes against IDs that no longer exist.

This is also not atomic: the delete can succeed and the write can fail, leaving the user's health history missing an entry. Guard it accordingly.
:::

## Writing platform-agnostic update code

Branch once, at the edge:

```dart
Future<void> changeStepCount(StepsRecord record, int newCount) async {
  try {
    await connector.updateRecord(record.copyWith(count: Number(newCount)));
  } on UnsupportedOperationException {
    // iOS: replace instead of update, then persist the new ID.
    await connector.deleteRecords(
      HealthDataType.steps.deleteByIds([record.id]),
    );
    final newId = await connector.writeRecord(
      record.copyWith(id: HealthRecordId.none, count: Number(newCount)),
    );
    await localStore.remapRecordId(oldId: record.id, newId: newId);
  }
}
```

Catching `UnsupportedOperationException` is more robust than checking the platform, because it also covers types that do not support updates on Android.

<NextSteps
  :links="[
    { text: 'Delete records', link: '/guide/tasks/delete', description: 'The other half of the iOS replacement pattern.' },
    { text: 'Platform differences', link: '/guide/concepts/platform-differences', description: 'Everything else that diverges.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Structuring catch blocks around platform limits.' },
  ]"
/>
