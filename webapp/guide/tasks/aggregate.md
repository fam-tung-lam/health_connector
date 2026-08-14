# Aggregate data

Aggregation runs inside the platform store. For anything longer than a few days, it is dramatically cheaper than reading every record into Dart and folding it yourself.

## The four metrics

```dart
final now = DateTime.now();
final thirtyDaysAgo = now.subtract(const Duration(days: 30));

// Sum — for quantities that accumulate.
final sumResult = await connector.aggregate(
  HealthDataType.steps.aggregateSum(
    startTime: thirtyDaysAgo,
    endTime: now,
  ),
);
print('Total steps: ${sumResult.value}');

// Average — for measurements that fluctuate.
final avgResult = await connector.aggregate(
  HealthDataType.weight.aggregateAvg(
    startTime: thirtyDaysAgo,
    endTime: now,
  ),
);
print('Average weight: ${avgResult.inKilograms} kg');

// Minimum.
final minResult = await connector.aggregate(
  HealthDataType.weight.aggregateMin(
    startTime: thirtyDaysAgo,
    endTime: now,
  ),
);
print('Minimum weight: ${minResult.inKilograms} kg');

// Maximum.
final maxResult = await connector.aggregate(
  HealthDataType.weight.aggregateMax(
    startTime: thirtyDaysAgo,
    endTime: now,
  ),
);
print('Maximum weight: ${maxResult.inKilograms} kg');
```

Those four — `aggregateSum`, `aggregateAvg`, `aggregateMin`, `aggregateMax` — are the complete set. There is no separate duration method.

## Only meaningful metrics exist

The available methods are part of each data type's interface, so nonsensical aggregations are not offered at all:

| Data type | Sum | Avg / Min / Max |
|---|:---:|:---:|
| Steps | Yes | — |
| Active energy burned | Yes | — |
| Weight | — | Yes |
| Heart rate | — | Yes |
| Exercise session | Yes (a `TimeDuration`) | — |

`HealthDataType.weight.aggregateSum(...)` is a compile error, not a runtime failure — summing body weight has no meaning. 104 of the 140 data types support at least one metric; filter by **Aggregatable only** in the [data type explorer](/reference/health-data-types) to see which, and which metrics each one offers.

::: info "Duration" is a return type, not a method
Session types such as `exerciseSession` and `mindfulnessSession` are listed as supporting **Duration**. That means their `aggregateSum` returns a `TimeDuration` — the total time spent across the range — rather than a count or a mass:

```dart
// AggregateRequest<TimeDuration> — still aggregateSum.
final totalWorkoutTime = await connector.aggregate(
  HealthDataType.exerciseSession.aggregateSum(
    startTime: from,
    endTime: to,
  ),
);

print('${totalWorkoutTime.inMinutes} minutes trained');
```
:::

## Results keep their units

An aggregate over a dimensioned type returns that dimension:

```dart
final avgWeight = await connector.aggregate(
  HealthDataType.weight.aggregateAvg(startTime: from, endTime: to),
);

print(avgWeight.inKilograms);
print(avgWeight.inPounds); // same measurement, different unit
```

Dimensionless types such as steps return a count through `.value`.

## Aggregate rather than read-and-fold

```dart
// Prefer this: one call, computed on device.
final total = await connector.aggregate(
  HealthDataType.steps.aggregateSum(startTime: monthAgo, endTime: now),
);

// Avoid this for long ranges: pages of records over the channel,
// plus the memory to hold them.
var request = HealthDataType.steps.readInTimeRange(
  startTime: monthAgo,
  endTime: now,
);
var total2 = 0;
while (true) {
  final page = await connector.readRecords(request);
  total2 += page.records.fold(0, (sum, r) => sum + r.count.value);
  if (page.nextPageRequest == null) break;
  request = page.nextPageRequest!;
}
```

Read the individual records only when you need to display or process them one by one.

## Building daily or weekly buckets

There is no bucketed aggregate API. For a chart, issue one aggregate per bucket:

```dart
Future<List<int>> dailySteps(int days) async {
  final results = <int>[];
  final midnight = DateTime.now().copyWith(
    hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0,
  );

  for (var day = days - 1; day >= 0; day--) {
    final start = midnight.subtract(Duration(days: day));
    final aggregate = await connector.aggregate(
      HealthDataType.steps.aggregateSum(
        startTime: start,
        endTime: start.add(const Duration(days: 1)),
      ),
    );
    results.add(aggregate.value);
  }

  return results;
}
```

::: warning Watch the Android rate limit
A year of daily buckets is 365 calls in a tight loop. Health Connect enforces a per-app request quota and throws `rateLimitExceeded` when you exhaust it; Google does not publish the exact figure, and it varies by device and Health Connect version, so treat any burst of hundreds of calls as unsafe rather than aiming at a number.

Two things make this a non-issue in practice:

- **Compute buckets once and cache them.** Historical days never change unless the underlying records do.
- **Recompute only what moved.** [`synchronize()`](/guide/tasks/synchronize) tells you which records changed, which tells you which buckets are stale.

If you do hit the limit, back off exponentially with jitter — see [the retry helper](/guide/tasks/errors#retryable-versus-terminal).
:::

<NextSteps
  :links="[
    { text: 'Measurement units', link: '/guide/concepts/units', description: 'What aggregate results are typed as.' },
    { text: 'Synchronize incrementally', link: '/guide/tasks/synchronize', description: 'Know which buckets need recomputing.' },
    { text: 'Health data types', link: '/reference/health-data-types', description: 'Aggregation support per type.' },
  ]"
/>
