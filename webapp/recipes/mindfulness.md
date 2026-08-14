# Mindfulness & behavioral health

Recording meditation and breathing sessions, then summarising them.

Mindfulness sessions are interval records with a type, an optional title, and optional notes. They surface in both native health apps as user-visible sessions, so the title and notes you write are read by real people.

## Record a meditation session

```dart
Future<void> recordMeditation() async {
  // 1. Request write access, and stop if it was refused.
  final results = await connector.requestPermissions([
    HealthDataType.mindfulnessSession.writePermission,
  ]);
  if (results.any((r) => r.status == PermissionStatus.denied)) return;

  // 2. Build the session.
  final startTime = DateTime.now();
  final endTime = startTime.add(const Duration(minutes: 30));
  final meditationSession = MindfulnessSessionRecord(
    startTime: startTime,
    endTime: endTime,
    sessionType: MindfulnessSessionType.meditation,
    title: 'Morning Meditation',
    notes: 'Focused on breath awareness. Felt calm and centered.',
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.phone),
    ),
  );

  // 3. Write it.
  await connector.writeRecord(meditationSession);
}
```

::: warning Notes are health data
Free-text notes about mental state are among the most sensitive things an app can write. Write them only when the user explicitly authored them, and never synthesise notes from inferred mood. The same applies to your own logging — see the [redaction note](/guide/tasks/logging).
:::

## Record a breathing exercise

Same record type, different session type:

```dart
Future<void> recordBreathingExercise() async {
  final results = await connector.requestPermissions([
    HealthDataType.mindfulnessSession.writePermission,
  ]);
  if (results.any((r) => r.status == PermissionStatus.denied)) return;

  final startTime = DateTime.now();
  final endTime = startTime.add(const Duration(minutes: 5));
  final breathingSession = MindfulnessSessionRecord(
    startTime: startTime,
    endTime: endTime,
    sessionType: MindfulnessSessionType.breathing,
    title: '4-7-8 Breathing',
    notes: '5 cycles of box breathing before bed',
    metadata: Metadata.manualEntry(),
  );

  await connector.writeRecord(breathingSession);
}
```

The metadata differs deliberately: a guided session your app timed is `automaticallyRecorded`; one the user logged after the fact is `manualEntry`.

## Summarise the week

```dart
Future<void> getWeeklyMindfulnessStats() async {
  // 1. Request read access.
  await connector.requestPermissions([
    HealthDataType.mindfulnessSession.readPermission,
  ]);

  final now = DateTime.now();
  final weekAgo = now.subtract(const Duration(days: 7));

  // 2. Read the sessions — the breakdown by type needs each one.
  final response = await connector.readRecords(
    HealthDataType.mindfulnessSession.readInTimeRange(
      startTime: weekAgo,
      endTime: now,
    ),
  );

  // 3. Total the time and count sessions per type.
  var totalMinutes = Duration.zero;
  final sessionsByType = <MindfulnessSessionType, int>{};
  for (final session in response.records) {
    totalMinutes += session.endTime.difference(session.startTime);

    sessionsByType[session.sessionType] =
        (sessionsByType[session.sessionType] ?? 0) + 1;
  }

  // 4. Report.
  print('Weekly Mindfulness Summary:');
  print('  Total sessions: ${response.records.length}');
  print('  Total minutes: ${totalMinutes.inMinutes}');
  print('  Sessions by type:');
  for (final entry in sessionsByType.entries) {
    print('    → ${entry.key.name}: ${entry.value} sessions');
  }
}
```

Here folding in Dart is the right call: the summary needs a per-type breakdown, which no single aggregate provides. When you need only the total, `aggregateSum` is cheaper — on a session type it returns a `TimeDuration`:

```dart
final totalTime = await connector.aggregate(
  HealthDataType.mindfulnessSession.aggregateSum(
    startTime: weekAgo,
    endTime: now,
  ),
);

print('${totalTime.inMinutes} mindful minutes this week');
```

::: tip Paginate if you widen the window
A week of sessions fits in one page. A year probably does not — follow `response.nextPageRequest` as shown in [Read records](/guide/tasks/read#paginate-through-large-ranges).
:::

<NextSteps
  :links="[
    { text: 'Fitness recipes', link: '/recipes/fitness', description: 'Sessions with laps, segments, and routes.' },
    { text: 'Read records', link: '/guide/tasks/read', description: 'Sorting and paginating session history.' },
    { text: 'Configure logging', link: '/guide/tasks/logging', description: 'Keeping sensitive text out of your logs.' },
  ]"
/>
