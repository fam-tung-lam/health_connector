# Your first integration

A complete round trip — availability, permissions, write, read, aggregate, delete — using steps as the example data type. The same shape works for any of the [140 supported data types](/reference/health-data-types).

::: tip Before you start
Finish [Install & configure](/guide/installation) first. This example both reads and writes, so:

- **Android** — `READ_STEPS` and `WRITE_STEPS` must already be declared in `AndroidManifest.xml`, and `MainActivity` must extend `FlutterFragmentActivity`.
- **iOS** — both `NSHealthShareUsageDescription` and `NSHealthUpdateUsageDescription` must be in `Info.plist`, with the HealthKit capability enabled.

Missing any of these fails at step three with a `ConfigurationException`, which no runtime handling can fix.
:::

## The whole flow

```dart
import 'package:health_connector/health_connector.dart';

Future<void> quickStart() async {
  // 1. Check platform availability before doing anything else.
  final status = await HealthConnector.getHealthPlatformStatus();
  if (status != HealthPlatformStatus.available) {
    print('Health platform not available: $status');
    return;
  }

  // 2. Create the connector. Logging is off unless you add processors.
  final connector = await HealthConnector.create(
    const HealthConnectorConfig(
      loggerConfig: HealthConnectorLoggerConfig(
        logProcessors: [PrintLogProcessor()],
      ),
    ),
  );

  // 3. Request exactly the permissions this feature needs.
  final results = await connector.requestPermissions([
    HealthDataType.steps.readPermission,
    HealthDataType.steps.writePermission,
  ]);

  // 4. Treat `denied` as blocking; `unknown` is normal for iOS reads.
  final granted = results.every((r) => r.status != PermissionStatus.denied);
  if (!granted) {
    print('Permissions denied');
    return;
  }

  // 5. Write. New records always use HealthRecordId.none.
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
    StepsRecord(
      id: HealthRecordId.none,
      startTime: now.subtract(const Duration(hours: 2)),
      endTime: now.subtract(const Duration(hours: 1)),
      count: Number(2000),
      metadata: Metadata.automaticallyRecorded(
        device: Device.fromType(DeviceType.phone),
      ),
    ),
  ];

  final recordIds = await connector.writeRecords(records);
  print('Wrote ${recordIds.length} records');

  // 6. Read them back. `response.records` is already List<StepsRecord>.
  final response = await connector.readRecords(
    HealthDataType.steps.readInTimeRange(
      startTime: now.subtract(const Duration(days: 1)),
      endTime: now,
    ),
  );

  print('Found ${response.records.length} records:');
  for (final record in response.records) {
    print('  → ${record.count.value} steps (${record.startTime}-${record.endTime})');
  }

  // 7. Aggregate on-device instead of summing in Dart.
  final totalSteps = await connector.aggregate(
    HealthDataType.steps.aggregateSum(
      startTime: now.subtract(const Duration(days: 1)),
      endTime: now,
    ),
  );
  print('Total steps: ${totalSteps.value}');

  // 8. Clean up. You can only delete records your own app wrote.
  await connector.deleteRecords(HealthDataType.steps.deleteByIds(recordIds));
  print('Deleted ${recordIds.length} records');
}
```

## What each step is actually doing

### 1 · Availability is not the same as permission

`getHealthPlatformStatus()` answers "does this device have a health store at all?" On Android that store is a separate app that can be missing or outdated; on iPad, HealthKit does not exist. Check this before you show any health UI, and call `HealthConnector.launchHealthAppPageInAppStore()` when Android reports the store is missing.

### 2 · Creation picks the platform for you

`HealthConnector.create()` returns a HealthKit-backed client on iOS and a Health Connect-backed client on Android. Your code never names either one. See [Architecture](/guide/concepts/architecture).

### 3 · Permissions are typed values, not strings

`HealthDataType.steps.readPermission` is an object derived from the data type, so a typo cannot silently request nothing. Request only what the current screen needs — asking for everything at launch depresses grant rates.

### 4 · `unknown` is a valid outcome, not a failure

On iOS, read permission status is always `unknown` because HealthKit refuses to disclose it. That is why this check rejects only `denied`. Treating `unknown` as failure would break every iOS build. [More on this](/guide/concepts/permissions#the-ios-read-status-problem).

### 5 · New records use `HealthRecordId.none`

The platform assigns the real identifier and returns it. Records you read back carry their platform ID, which is what makes them deletable and (on Android) updatable. `writeRecords()` is atomic — all records land or none do.

### 6 · The response type follows the request

Because the request came from `HealthDataType.steps`, `response.records` is a `List<StepsRecord>` and `record.count` resolves without a cast. Large ranges paginate; see [Read records](/guide/tasks/read#paginate-through-large-ranges).

### 7 · Aggregate where the data lives

`aggregateSum` runs inside the platform store. For a month of step data that is dramatically cheaper than reading every record into Dart and folding it yourself. Which metrics exist depends on the data type — [aggregation support per type](/reference/health-data-types).

### 8 · Deletion is scoped to your app

Both platforms only let an app delete records it created. Attempting to delete another app's data throws `AuthorizationException`.

## Where this leaves you

You now have a working read/write loop. The next decisions are usually:

<NextSteps
  :links="[
    { text: 'Health records', link: '/guide/concepts/records', description: 'Instant, interval, and series shapes — and which one your data is.' },
    { text: 'Permissions', link: '/guide/tasks/permissions', description: 'Requesting, checking, and revoking across both platforms.' },
    { text: 'Synchronize incrementally', link: '/guide/tasks/synchronize', description: 'Fetch only what changed instead of re-reading ranges.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Which failures are retryable and which are your own config.' },
    { text: 'App recipes', link: '/recipes/', description: 'Nutrition, mindfulness, and fitness flows built from these pieces.' },
    { text: 'Toolbox demo app', link: '/resources/toolbox', description: 'Run every operation against a real device.' },
  ]"
/>
