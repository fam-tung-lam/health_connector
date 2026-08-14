# Fitness & activity tracking

Recording a workout with laps and a GPS route, then reading the history back.

An exercise session is the richest record type in the SDK: it carries a type, a title, notes, lap and segment events, and an optional route.

## Record a run with laps and a route

```dart
Future<void> recordRunWithRoute() async {
  // 1. Route access requires the session permission as well.
  final results = await connector.requestPermissions([
    HealthDataType.exerciseSession.writePermission,
    HealthDataType.exerciseSession.writeExerciseRoutePermission,
  ]);
  if (results.any((r) => r.status == PermissionStatus.denied)) return;

  final startTime = DateTime.now();
  final endTime = startTime.add(const Duration(minutes: 35));

  // 2. Laps — 400m track intervals.
  final laps = [
    ExerciseSessionLapEvent(
      startTime: startTime,
      endTime: startTime.add(const Duration(minutes: 2, seconds: 5)),
      distance: Length.meters(400),
    ),
    ExerciseSessionLapEvent(
      startTime: startTime.add(const Duration(minutes: 2, seconds: 5)),
      endTime: startTime.add(const Duration(minutes: 4, seconds: 8)),
      distance: Length.meters(400),
    ),
    ExerciseSessionLapEvent(
      startTime: startTime.add(const Duration(minutes: 4, seconds: 8)),
      endTime: startTime.add(const Duration(minutes: 6, seconds: 15)),
      distance: Length.meters(400),
    ),
    // ... more laps
  ];

  // 3. The GPS track. Recording horizontalAccuracy lets you filter
  //    noisy points later instead of drawing a track through buildings.
  final route = ExerciseRoute([
    ExerciseRouteLocation(
      time: startTime,
      latitude: 37.7749,
      longitude: -122.4194,
      altitude: Length.meters(15),
      horizontalAccuracy: Length.meters(5),
    ),
    ExerciseRouteLocation(
      time: startTime.add(const Duration(seconds: 30)),
      latitude: 37.7752,
      longitude: -122.4190,
      altitude: Length.meters(16),
      horizontalAccuracy: Length.meters(4),
    ),
    ExerciseRouteLocation(
      time: startTime.add(const Duration(minutes: 1)),
      latitude: 37.7755,
      longitude: -122.4185,
      altitude: Length.meters(17),
      horizontalAccuracy: Length.meters(3),
    ),
    // ... more GPS points recorded during the run
  ]);

  // 4. One record carries the session, its events, and its route.
  final runSession = ExerciseSessionRecord(
    startTime: startTime,
    endTime: endTime,
    exerciseType: ExerciseType.running,
    title: 'Morning Run',
    notes: 'Easy pace around the park. Good weather.',
    events: laps,
    exerciseRoute: route,
    metadata: Metadata.automaticallyRecorded(
      device: Device.fromType(DeviceType.watch),
    ),
  );

  // 5. A single write.
  await connector.writeRecord(runSession);
}
```

::: warning Check exercise type availability
`ExerciseType` covers 96 activities, and they do not all exist on both stores — `ExerciseType.runningTreadmill` is Health Connect-only, for example. Search the [exercise type reference](/reference/exercise-types) before hard-coding one.
:::

## Read exercise history

Routes do not come back with the session query. Load them separately, and only for the sessions you will actually draw:

```dart
Future<void> getExerciseHistory() async {
  // 1. Read access, including routes.
  await connector.requestPermissions([
    HealthDataType.exerciseSession.readPermission,
    HealthDataType.exerciseSession.readExerciseRoutePermission,
  ]);

  // 2. Read the sessions.
  final now = DateTime.now();
  final monthAgo = now.subtract(const Duration(days: 30));
  final response = await connector.readRecords(
    HealthDataType.exerciseSession.readInTimeRange(
      startTime: monthAgo,
      endTime: now,
    ),
  );

  print('Exercise History (Past 30 Days):');
  print('  Total workouts: ${response.records.length}');

  for (final session in response.records) {
    final duration = session.endTime.difference(session.startTime);
    print('\n  ${session.exerciseType.name.toUpperCase()}');
    print('    Title: ${session.title ?? "Untitled"}');
    print('    Duration: ${duration.inMinutes} min');
    print('    Laps: ${session.lapEvents.length}');
    print('    Segments: ${session.segmentEvents.length}');
  }
}
```

Everything in that list comes from the session records themselves — no route call needed. Load a route only when the user opens one workout:

```dart
Future<void> showWorkoutMap(HealthRecordId sessionId) async {
  final route = await connector.readExerciseRoute(sessionId);
  if (route == null || route.isEmpty) return showNoRouteState();

  drawOnMap(route.locations);
}
```

::: warning Never loop `readExerciseRoute()` over a list
Each call is a separate round trip carrying a full GPS track. Fetching a route per session to render a list turns one query into dozens, moves a lot of location data you will not draw, and on Android pushes you toward `rateLimitExceeded`.
:::

## Strength training and segment weight

Segments describe what happened inside a session — sets, reps, and load:

```dart
final segment = ExerciseSessionSegmentEvent(
  startTime: startTime,
  endTime: endTime,
  segmentType: ExerciseSegmentType.benchPress,
  repetitions: 10,
  weight: Mass.kilograms(80), // Android SDK Extension 21+ only
);

try {
  await connector.writeRecord(exerciseSession);
} on UnsupportedOperationException catch (e) {
  // The device's Health Connect module predates Extension 21,
  // or this is iOS. Omit the weight or tell the user.
  print('Segment weight not supported on this device: $e');
}
```

::: danger `weight` is a runtime device check, not a build-time one
The same binary succeeds on one Android 14 device and throws on another, depending on whether that device received the relevant Health Connect Mainline update. Always guard non-null weight writes. [Full behavior table](/reference/annotations#exercise-segment-weight-and-sdk-extension-21).
:::

<NextSteps
  :links="[
    { text: 'Exercise routes', link: '/guide/tasks/exercise-routes', description: 'Route permissions and lazy loading in depth.' },
    { text: 'Exercise types', link: '/reference/exercise-types', description: 'All 96 types and their platform support.' },
    { text: 'Annotations', link: '/reference/annotations', description: 'Reading version and platform constraints.' },
  ]"
/>
