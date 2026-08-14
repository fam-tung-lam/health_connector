# Synchronize incrementally

`synchronize()` returns only the health data that changed since your last sync — new records, modified records, and the IDs of deleted ones. For an app that needs to stay current, it replaces re-reading the same ranges over and over.

## When to sync, when to read

| Use case | Approach |
|---|---|
| Periodic background refresh (daily health updates) | `synchronize()` |
| Staying current with ongoing activity | `synchronize()` |
| A one-off fetch for a specific range | `readRecords()` |
| History the user explicitly asked for ("show me last month") | `readRecords()` |

The distinguishing question is whether you are answering "what is there?" or "what changed?".

## How it works

Synchronization is a two-phase flow built around a token.

**Phase 1 — set a checkpoint.** Call `synchronize()` with `syncToken: null`. This establishes a point-in-time marker and returns a `nextSyncToken`. No records come back; you are marking "from here on, tell me what changes."

**Phase 2 — fetch changes.** Call `synchronize()` with the saved token. You receive `upsertedRecords` (new or modified), `deletedRecordIds`, and a fresh `nextSyncToken`. Save the new token every time — that is what advances the cursor.

Under the hood this maps to Health Connect change tokens on Android and anchored queries on iOS, unified behind one API.

::: warning Three things about the token, before you write any code
1. **`nextSyncToken` is nullable.** Every example below null-checks it. Dereferencing it directly will not compile.
2. **A token is scoped to the exact data types it was created with.** `HealthDataSyncToken` stores its `dataTypes`. If you later add a type to your sync, the saved token no longer matches and the call throws `InvalidArgumentException` — establish a fresh checkpoint whenever the set changes.
3. **Tokens expire — around 30 days on Android.** The token carries `createdAt`, which is what you use to size a backfill after expiry.
:::

::: danger Not every data type exists on both platforms
`synchronize()` throws `UnsupportedOperationException` for a type the current platform does not support, and it throws for the whole call — one wrong type breaks the entire sync.

Heart rate is the trap: Android exposes `HealthDataType.heartRateSeries`, iOS exposes `HealthDataType.heartRate`, and neither exists on the other. Build the list per platform:

```dart
final heartRateType = HealthConnector.healthPlatform == HealthPlatform.healthConnect
    ? HealthDataType.heartRateSeries
    : HealthDataType.heartRate;
```

Check any type you sync in the [data type explorer](/reference/health-data-types) first. The examples below use `steps` and `weight`, which are available on both.
:::

## Establishing the checkpoint

```dart
import 'package:health_connector/health_connector.dart';

// SharedPreferences, secure storage, or whatever you already use.
final storage = LocalTokenStorage();

const syncedTypes = [HealthDataType.steps, HealthDataType.weight];

Future<void> setupSyncCheckpoint() async {
  final connector = await HealthConnector.create();

  // Passing null establishes "now" as the starting point.
  final result = await connector.synchronize(
    dataTypes: syncedTypes,
    syncToken: null,
  );

  // nextSyncToken is nullable — no token means no checkpoint was set.
  final token = result.nextSyncToken;
  if (token == null) {
    print('Could not establish a sync checkpoint');
    return;
  }

  await storage.saveToken(token.toJson());
  print('Sync checkpoint established');
}
```

## Fetching changes

```dart
Future<void> syncHealthData() async {
  final connector = await HealthConnector.create();

  // 1. Load the saved token.
  final tokenJson = await storage.loadToken();
  if (tokenJson == null) {
    print('No checkpoint found. Run setupSyncCheckpoint() first.');
    return;
  }

  final token = HealthDataSyncToken.fromJson(tokenJson);

  // 2. Ask for everything that changed since it was issued.
  final result = await connector.synchronize(
    dataTypes: syncedTypes,
    syncToken: token,
  );

  print('  • New/updated records: ${result.upsertedRecords.length}');
  print('  • Deleted record IDs: ${result.deletedRecordIds.length}');

  // 3. Apply upserts to your local store.
  for (final record in result.upsertedRecords) {
    await localStore.upsert(record);
  }

  // 4. Apply deletions.
  for (final id in result.deletedRecordIds) {
    await localStore.delete(id);
  }

  // 5. Persist the new token, or you will replay the same changes.
  final nextToken = result.nextSyncToken;
  if (nextToken != null) {
    await storage.saveToken(nextToken.toJson());
  }
}
```

::: info `upsertedRecords` is `List<HealthRecord>`
Unlike `readRecords()`, a sync covers several data types at once, so the result is the heterogeneous base type. Dispatch on the concrete type before mapping to your backend payload:

```dart
for (final record in result.upsertedRecords) {
  switch (record) {
    case StepsRecord():
      await api.postSteps(record.count.value, record.startTime, record.endTime);
    case WeightRecord():
      await api.postWeight(record.weight.inKilograms, record.time);
    default:
      // A type you sync but do not map yet.
  }
}
```
:::

## Handling pagination

A large batch of changes is paginated. Loop while `hasMore` is true, advancing the token each round:

```dart
Future<void> syncAllPages() async {
  final connector = await HealthConnector.create();

  final tokenJson = await storage.loadToken();
  if (tokenJson == null) return;

  var token = HealthDataSyncToken.fromJson(tokenJson);
  bool hasMore;

  do {
    final result = await connector.synchronize(
      dataTypes: syncedTypes,
      syncToken: token,
    );

    // Apply and persist each page as it arrives, together with the token that
    // produced it. Buffering every page first would both blow up memory on a
    // large backlog and replay everything if the run dies midway.
    await localStore.applyInTransaction(
      upserted: result.upsertedRecords,
      deleted: result.deletedRecordIds,
      token: result.nextSyncToken?.toJson(),
    );

    final nextToken = result.nextSyncToken;
    if (nextToken == null) break;

    token = nextToken;
    hasMore = result.hasMore;
  } while (hasMore);
}
```

::: tip Commit records and token together
If you save records and the token in separate steps and the process dies in between, you either replay changes or lose them. Write both in one transaction, per page. That is what makes an interrupted sync safe to simply re-run.
:::

## Recovering from an expired token

An expired or mismatched token throws `InvalidArgumentException`. Recovery has two parts — backfill the gap, then re-checkpoint:

```dart
try {
  final result = await connector.synchronize(
    dataTypes: syncedTypes,
    syncToken: savedToken,
  );
  // …
} on InvalidArgumentException {
  // 1. Backfill what changed while the token was dead. `createdAt` bounds it.
  final backfill = await connector.readRecords(
    HealthDataType.steps.readInTimeRange(
      startTime: savedToken.createdAt,
      endTime: DateTime.now(),
    ),
  );
  for (final record in backfill.records) {
    await localStore.upsert(record);
  }

  // 2. Re-establish the checkpoint.
  final reset = await connector.synchronize(
    dataTypes: syncedTypes,
    syncToken: null,
  );
  final token = reset.nextSyncToken;
  if (token != null) await storage.saveToken(token.toJson());
}
```

::: danger Backfill cannot recover deletions
`readRecords()` returns what exists now. Records deleted while your token was expired simply are not there, and nothing tells you they were removed. If your backend must stay exactly in step, treat an expired token as a trigger to reconcile the affected range against your own copy — not just to append what you read.

On Android, note that the backfill read itself caps at **30 days** unless you hold the `readHealthDataHistory` feature permission. A token that expired at ~30 days plus a 30-day read window leaves very little margin, so sync more often than monthly.
:::

## Background syncing

Reading health data while your app is backgrounded requires the `readHealthDataInBackground` feature permission, plus cooperation from OS scheduling — Android will not guarantee your worker runs on time, and iOS decides for itself. Treat every background sync as best-effort and reconcile on next launch. See [Check platform features](/guide/tasks/features).

Exercise routes are not part of a sync result: routes load through `readExerciseRoute()` per session, so fetch them separately for any exercise sessions the sync reports as changed.

<NextSteps
  :links="[
    { text: 'Check platform features', link: '/guide/tasks/features', description: 'Background reads and historical access.' },
    { text: 'Read records', link: '/guide/tasks/read', description: 'Backfilling gaps after a token reset.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Recovering from expired tokens and rate limits.' },
  ]"
/>
