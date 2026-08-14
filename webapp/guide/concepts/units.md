# Measurement units

Health data is where unit bugs do real damage — a pound read as a kilogram is a 2.2× error in someone's medical history. The SDK makes the unit part of the type, so the mistake cannot compile.

## Values carry their dimension

```dart
final bodyMass = Mass.pounds(155.4);
print(bodyMass.inKilograms); // 70.49...

final distance = Length.miles(3.1);
print(distance.inKilometers); // 4.98...
```

You construct in whatever unit you have and read in whatever unit you need. There is no ambiguous `double` in between, and no convention to remember.

Because `WeightRecord.weight` is typed as `Mass`, passing a `Length` — or a bare number — is a compile error rather than a corrupted record.

## The unit families

| Family | Measures | Typical use |
|---|---|---|
| `Mass` | Weight, nutrient quantities | Body weight, protein, sodium |
| `Length` | Distance, height | Walking distance, altitude, height |
| `Energy` | Calories and joules | Active energy burned, dietary energy |
| `Volume` | Liquid quantity | Hydration |
| `Frequency` | Events per unit time | Heart rate, respiratory rate |
| `Temperature` | Degrees | Body and skin temperature |
| `Pressure` | Pressure | Blood pressure |
| `BloodGlucose` | Glucose concentration | Blood glucose readings |
| `Percentage` | Proportions | Body fat, oxygen saturation |
| `Power` | Rate of work | Cycling power |
| `Velocity` | Speed | Running and cycling speed |
| `TimeDuration` | Elapsed time | Session and segment durations |
| `Number` | Dimensionless counts | Steps, repetitions, floors |

`Number` exists so that counts stay explicit rather than being raw `int`s that could be confused with an ID or an index.

## Conversion happens before the platform channel

Units are converted in Dart during mapping, then handed to the native store in the unit it expects. Two consequences worth knowing:

- The same Dart code produces identical stored values on both platforms — HealthKit's `HKUnit` and Health Connect's primitives never leak into your code.
- Conversions are exact within floating-point limits; the SDK does not round on your behalf. Round for display, not for storage.

## Aggregates come back as units too

An aggregate over a dimensioned type returns that dimension, not a bare number:

```dart
final avgWeight = await connector.aggregate(
  HealthDataType.weight.aggregateAvg(startTime: from, endTime: to),
);

print(avgWeight.inKilograms);   // Mass
print(avgWeight.inPounds);      // same value, different unit
```

For a dimensionless type such as steps, the result is a count:

```dart
final totalSteps = await connector.aggregate(
  HealthDataType.steps.aggregateSum(startTime: from, endTime: to),
);

print(totalSteps.value);
```

<NextSteps
  :links="[
    { text: 'Health records', link: '/guide/concepts/records', description: 'The record shapes these units live inside.' },
    { text: 'Aggregate data', link: '/guide/tasks/aggregate', description: 'Sum, average, min, and max on the device.' },
    { text: 'Health data types', link: '/reference/health-data-types', description: 'Which unit each data type uses.' },
  ]"
/>
