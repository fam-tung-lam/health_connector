# Read records

Reading is the same on both platforms. The response type is inferred from the data type you build the request with, so no casting is involved.

::: info Historical access differs
Health Connect exposes the last **30 days** by default — older data needs the `HealthPlatformFeature.readHealthDataHistory` permission. HealthKit has no such restriction.
:::

## Read a single record by ID

```dart
// 1. Build the request.
final readRequest = HealthDataType.steps.readById(
  HealthRecordId('record-id'),
);

// 2. Execute it.
final record = await connector.readRecord(readRequest);

// 3. Handle the miss — a deleted or unknown ID returns null.
if (record != null) {
  print('Found: ${record.count.value} steps');
} else {
  print('No record found.');
}
```

## Read a time range

```dart
final readRequest = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(const Duration(days: 7)),
  endTime: DateTime.now(),
);

final response = await connector.readRecords(readRequest);

// response.records is List<StepsRecord>.
print('Found ${response.records.length} records');
for (final record in response.records) {
  print('${record.count.value} steps on ${record.startTime}');
}
```

The range is matched against the record's own timestamps, not against when it was written. A backdated record appears in the range it describes.

## Show the source name

Each record's `metadata.dataOrigin` retains the source identifier and adds a nullable display name:

```dart
for (final record in response.records) {
  final origin = record.metadata.dataOrigin;
  final label = origin?.displayName ?? origin?.packageName ?? 'Unknown source';
  // Show label in your application.
}
```

The same information is available on single-record reads and synchronization upserts. A missing name does not prevent reading a record. Continue to use `packageName` for identity and filtering; see [source metadata](/guide/concepts/records#metadata) for platform differences and Android package visibility.

## Sort by time

```dart
// Oldest first.
final oldestFirst = await connector.readRecords(
  HealthDataType.steps.readInTimeRange(
    startTime: from,
    endTime: to,
    sortDescriptor: SortDescriptor.timeAscending,
  ),
);

// Newest first — the default.
final newestFirst = await connector.readRecords(
  HealthDataType.steps.readInTimeRange(
    startTime: from,
    endTime: to,
    sortDescriptor: SortDescriptor.timeDescending,
  ),
);
```

## Paginate through large ranges

`readRecords()` returns one page. A month of heart-rate data will not arrive in a single call, so follow `nextPageRequest` until it is `null`:

```dart
// 1. Set a page size that suits your memory budget.
var request = HealthDataType.steps.readInTimeRange(
  startTime: DateTime.now().subtract(const Duration(days: 30)),
  endTime: DateTime.now(),
  pageSize: 100,
);

// 2. Walk every page.
final allRecords = <StepsRecord>[];
while (true) {
  final response = await connector.readRecords(request);
  allRecords.addAll(response.records.cast<StepsRecord>());

  if (response.nextPageRequest == null) break;

  request = response.nextPageRequest!;
}

print('Total: ${allRecords.length} records');
```

::: warning Do not accumulate unbounded history in memory
For a first sync over months of data, process each page as it arrives — write it to your database, then discard it — instead of building one giant list. If you need to stay current afterwards, [`synchronize()`](/guide/tasks/synchronize) fetches only what changed and is far cheaper than re-reading ranges.
:::

## Choosing between read and sync

| You want | Use |
|---|---|
| A specific range, once | `readRecords()` |
| History the user asked to see | `readRecords()` |
| To stay up to date with changes | `synchronize()` |
| Periodic background refresh | `synchronize()` |

<NextSteps
  :links="[
    { text: 'Write records', link: '/guide/tasks/write', description: 'Single writes, batch writes, and atomicity.' },
    { text: 'Aggregate data', link: '/guide/tasks/aggregate', description: 'Totals and averages without reading every record.' },
    { text: 'Synchronize incrementally', link: '/guide/tasks/synchronize', description: 'Fetch only what changed since last time.' },
  ]"
/>

## Read an iOS user characteristic

Available in Health Connector 3.14.0. Characteristics are profile values without
record IDs or time ranges. Request their read permissions on the permissions
screen before reading them:

```dart
await connector.requestPermissions([
  UserCharacteristicType.birthDate.readPermission,
  UserCharacteristicType.biologicalSex.readPermission,
]);

final BirtDate? birthDate = await connector.readUserCharacteristic(
  UserCharacteristicType.birthDate,
);
final BiologicalSex? sex = await connector.readUserCharacteristic(
  UserCharacteristicType.biologicalSex,
);
```

`BirtDate` contains Gregorian `year`, `month`, and `day` components, without a
time or timezone. `BiologicalSex` has `female`, `male`, and `other` values.

A nullable result means the characteristic is unset or HealthKit is hiding read
access. HealthKit does not disclose read authorization, so do not use null to
infer that permission was denied. Explicit native authorization errors still
throw `AuthorizationException`. Other failures remain mapped SDK exceptions.
Android throws `UnsupportedOperationException`.

The operation is declared directly on `HealthConnector`. Custom implementations
of this interface must implement `readUserCharacteristic`. The SDK facade
delegates to its iOS HealthKit client and rejects other clients.

In Toolbox, select the characteristic permissions on Request Permissions, then
open Read user characteristic, choose a dropdown entry, and tap Read. The screen
keeps results only in memory and never reads automatically on entry.
