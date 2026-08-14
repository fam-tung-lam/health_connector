# Data types & capabilities

`HealthDataType` is the entry point for almost everything you do. It is not just an enum of names — it is where permissions, requests, and capabilities come from.

## One constant, four jobs

```dart
// 1. Permissions derive from the type.
HealthDataType.steps.readPermission
HealthDataType.steps.writePermission

// 2. Read requests derive from the type — and carry it into the response.
HealthDataType.steps.readInTimeRange(startTime: from, endTime: to)
HealthDataType.steps.readById(HealthRecordId('...'))

// 3. Delete requests too.
HealthDataType.steps.deleteByIds([id])
HealthDataType.steps.deleteInTimeRange(startTime: from, endTime: to)

// 4. And aggregates — only the ones this type supports.
HealthDataType.steps.aggregateSum(startTime: from, endTime: to)
```

Because permissions and requests both come from the same constant, they cannot drift apart. There is no way to request `READ_STEPS` and then accidentally query weight.

## Capabilities are encoded in the type

Each data type implements only the interfaces matching what it can actually do. That has a concrete effect: **`HealthDataType.weight.aggregateSum(...)` does not exist**, because summing body weight is meaningless. Average, minimum, and maximum do exist. The compiler stops the nonsensical call rather than the platform rejecting it at runtime.

The same mechanism covers writes. A type marked `@readOnly` — typically a metric the OS computes for you — offers no write path, and attempting one throws `UnsupportedOperationException`.

| Capability | Where it comes from | Failure mode if unsupported |
|---|---|---|
| Read | Every data type | — |
| Write | Type is not `@readOnly` | Compile error, or `UnsupportedOperationException` |
| Aggregate (Sum/Avg/Min/Max/Duration) | Per-type aggregation interfaces | The method is not offered |
| Update | Android only | `UnsupportedOperationException` on iOS |
| Delete | Records your app wrote | `AuthorizationException` for other apps' records |

Which aggregations each type supports is searchable in the [health data type explorer](/reference/health-data-types) — filter by **Aggregatable only** to see the 104 types that support at least one metric.

## Platform availability is per type

Not every conceptual measurement exists on both stores. Of the 140 typed data types, some are Health Connect-only, many nutrient types are exposed as discrete HealthKit identifiers while Health Connect models them as fields on a single `NutritionRecord`, and a few require a specific iOS version.

Types that are not universal carry an annotation:

```dart
@supportedOnAppleHealthIOS16Plus
@readOnly
final class InfrequentMenstrualCycleEventRecord extends IntervalHealthRecord { … }
```

Read that as: iOS 16 or later only, and read-only even there. Calling it on Android, or on iOS 15, throws `UnsupportedOperationException`. The full annotation vocabulary is in the [annotation reference](/reference/annotations).

## Reads stay typed all the way through

This is what makes the type parameter worth the ceremony:

```dart
final response = await connector.readRecords(
  HealthDataType.weight.readInTimeRange(startTime: from, endTime: to),
);

// List<WeightRecord> — `weight` is a Mass, no cast needed.
for (final record in response.records) {
  print(record.weight.inKilograms);
}
```

No `as`, no `is` check, no null-guarded cast. If you change the data type on the first line, every downstream line that no longer type-checks becomes a compile error — which is exactly when you want to find out.

The record shape follows the type too. `HealthDataType.heartRate` yields `HeartRateRecord`, an instant record with a single `rate`; `HealthDataType.heartRateSeries` yields `HeartRateSeriesRecord`, which carries `samples`. You get the right shape without asking for it:

```dart
// Instant record — one reading.
final single = await connector.readRecords(
  HealthDataType.heartRate.readInTimeRange(startTime: from, endTime: to),
);
for (final record in single.records) {
  print(record.rate.inPerMinute);
}

// Series record — many samples inside one record.
final series = await connector.readRecords(
  HealthDataType.heartRateSeries.readInTimeRange(startTime: from, endTime: to),
);
for (final record in series.records) {
  for (final sample in record.samples) {
    print(sample.rate.inPerMinute);
  }
}
```

::: warning Static typing does not cover platform availability
Those two heart-rate types are also a platform split — `heartRate` is HealthKit-only and `heartRateSeries` is Health Connect-only. That constraint is **not** enforced by the compiler: passing an unsupported type compiles fine and throws `UnsupportedOperationException` at runtime. Check availability in the [explorer](/reference/health-data-types) and branch on `HealthConnector.healthPlatform`.
:::

## Finding the type you need

<NextSteps
  :links="[
    { text: 'Health data type explorer', link: '/reference/health-data-types', description: 'Search 140 types by platform, category, and aggregation.' },
    { text: 'Exercise types', link: '/reference/exercise-types', description: 'The 96 workout types and where each is available.' },
    { text: 'Annotations', link: '/reference/annotations', description: 'How to read the platform and version constraints.' },
  ]"
/>
