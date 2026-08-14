# Nutrition & hydration

Logging meals, macros, and water intake — and reading a day back out.

::: info Nutrition is modelled differently by each store
HealthKit exposes each nutrient as its own identifier (`HealthDataType.dietaryProtein`, `HealthDataType.dietaryCaffeine`, …). Health Connect models the same values as fields on a single `NutritionRecord`. Writing a `NutritionRecord` works on both platforms; querying an individual nutrient type is where the difference shows. Check per-type availability in the [data type explorer](/reference/health-data-types).
:::

## Log a meal with macros

```dart
Future<void> logMeal() async {
  // 1. Request write access, and stop if it was refused.
  final results = await connector.requestPermissions([
    HealthDataType.nutrition.writePermission,
  ]);
  if (results.any((r) => r.status == PermissionStatus.denied)) return;

  // 2. Build the meal. Every nutrient is a typed Mass or Energy.
  final startTime = DateTime.now();
  final endTime = startTime.add(const Duration(minutes: 30));
  final lunchRecord = NutritionRecord(
    startTime: startTime,
    endTime: endTime,
    foodName: 'Grilled Chicken Salad',
    mealType: MealType.lunch,
    energy: Energy.kilocalories(450),
    protein: Mass.grams(35),
    totalCarbohydrate: Mass.grams(25),
    totalFat: Mass.grams(18),
    dietaryFiber: Mass.grams(8),
    sodium: Mass.milligrams(520),
    metadata: Metadata.manualEntry(),
  );

  // 3. Write it.
  await connector.writeRecord(lunchRecord);
}
```

`Metadata.manualEntry()` is correct here — the user typed these numbers, or picked them from your food database. Reserve `automaticallyRecorded()` for values a device produced.

## Log water intake

```dart
Future<void> logWaterIntake() async {
  await connector.requestPermissions([
    HealthDataType.hydration.writePermission,
  ]);

  final startTime = DateTime.now();
  final endTime = startTime.add(const Duration(minutes: 30));
  final waterRecord = HydrationRecord(
    startTime: startTime,
    endTime: endTime,
    volume: Volume.milliliters(500),
    metadata: Metadata.manualEntry(),
  );

  await connector.writeRecord(waterRecord);
}
```

Hydration is an interval record because a drink is consumed over a window, not at an instant. If your UI captures a single tap, a short interval ending at "now" is the honest representation.

## Read today's meals and totals

```dart
Future<void> analyzeDailyNutrition() async {
  // 1. Read access for both types.
  await connector.requestPermissions([
    HealthDataType.nutrition.readPermission,
    HealthDataType.hydration.readPermission,
  ]);

  final now = DateTime.now();
  final startOfDay = DateTime(now.year, now.month, now.day);

  // 2. Read the individual meals — you need these to list them.
  final response = await connector.readRecords(
    HealthDataType.nutrition.readInTimeRange(
      startTime: startOfDay,
      endTime: now,
    ),
  );

  print('Today\'s meals:');
  for (final record in response.records) {
    print('  → ${record.mealType.name}: ${record.foodName}');
  }

  // 3. Ask the platform for the totals rather than folding in Dart.
  final totalEnergy = await connector.aggregate(
    HealthDataType.dietaryEnergyConsumed.aggregateSum(
      startTime: startOfDay,
      endTime: now,
    ),
  );
  print('Total calories today: '
      '${totalEnergy.inKilocalories.toStringAsFixed(0)} kcal');

  final totalWater = await connector.aggregate(
    HealthDataType.hydration.aggregateSum(
      startTime: startOfDay,
      endTime: now,
    ),
  );
  print('Total water today: '
      '${totalWater.inMilliliters.toStringAsFixed(0)} ml');
}
```

Note the split: records are read because the UI lists them individually, while totals are aggregated because nothing needs the per-record breakdown. Reading everything and summing it in Dart would work and would be slower for no benefit.

::: tip Day boundaries are a product decision
`DateTime(now.year, now.month, now.day)` is local midnight. If your users log late-night meals, consider whether "today" should roll over at 4am instead — health apps that use strict midnight tend to split a single evening across two days.
:::

<NextSteps
  :links="[
    { text: 'Mindfulness recipes', link: '/recipes/mindfulness', description: 'Session records and weekly summaries.' },
    { text: 'Aggregate data', link: '/guide/tasks/aggregate', description: 'Building daily and weekly buckets.' },
    { text: 'Measurement units', link: '/guide/concepts/units', description: 'Mass, Energy, and Volume in detail.' },
  ]"
/>
