# Read & write exercise routes

An exercise route is the GPS track recorded during a workout. Routes attach to an exercise session, and they are permissioned and loaded separately from it.

## Routes need two permissions

::: danger Route permissions alone are not enough
Route access is layered on top of session access. Without the underlying exercise-session permission, route operations fail **even when the route permission is granted**.
:::

| Operation | Required permissions |
|---|---|
| Write route data | `exerciseSession.writePermission` **and** `exerciseSession.writeExerciseRoutePermission` |
| Read route data | `exerciseSession.readPermission` **and** `exerciseSession.readExerciseRoutePermission` |

```dart
final permissions = [
  // Foundation.
  HealthDataType.exerciseSession.readPermission,
  HealthDataType.exerciseSession.writePermission,

  // Route access.
  HealthDataType.exerciseSession.readExerciseRoutePermission,
  HealthDataType.exerciseSession.writeExerciseRoutePermission,
];

final results = await connector.requestPermissions(permissions);

// Route operations fail without the underlying session grant, so check both.
final ready = !results.any((r) => r.status == PermissionStatus.denied);
```

## Write a session with a route

The route is attached to the session record and written in the same call:

```dart
final start = DateTime.now();
final end = start.add(const Duration(hours: 1));

// 1. Build the track.
final route = ExerciseRoute([
  ExerciseRouteLocation(
    time: start,
    latitude: 37.7749,
    longitude: -122.4194,
    altitude: Length.meters(10),
  ),
  ExerciseRouteLocation(
    time: start.add(const Duration(minutes: 15)),
    latitude: 37.7751,
    longitude: -122.4180,
    altitude: Length.meters(12),
  ),
  ExerciseRouteLocation(
    time: start.add(const Duration(minutes: 30)),
    latitude: 37.7755,
    longitude: -122.4165,
    altitude: Length.meters(8),
  ),
]);

// 2. Attach it to the session.
final session = ExerciseSessionRecord(
  id: HealthRecordId.none,
  startTime: start,
  endTime: end,
  exerciseType: ExerciseType.running,
  exerciseRoute: route,
  metadata: Metadata.automaticallyRecorded(),
);

// 3. One write covers session and route.
await connector.writeRecord(session);
```

Each location can also carry `horizontalAccuracy`, which is worth recording — it lets you filter noisy points later instead of drawing a track that jumps through buildings.

## Read a route

Routes are **not** included when you read exercise sessions. They load separately through `readExerciseRoute()`, which keeps session queries cheap when you only need summaries:

```dart
// 1. Read the sessions.
final response = await connector.readRecords(
  HealthDataType.exerciseSession.readInTimeRange(
    startTime: DateTime.now().subtract(const Duration(days: 7)),
    endTime: DateTime.now(),
  ),
);

// 2. Load the route for the one session the user opened.
final session = response.records.firstWhere((r) => r.id == selectedId);
final route = await connector.readExerciseRoute(session.id);

if (route != null) {
  drawOnMap(route.locations);
} else {
  // No route was recorded, or the route permission was not granted.
  showNoRouteState();
}
```

`null` means the session has no route — either it was never recorded, or the route permission was not granted. There is no way to tell those apart, so show one "no map available" state for both.

::: warning Never loop `readExerciseRoute()` over a list of sessions
Each call is a separate platform round trip carrying a full GPS track. A month of workouts becomes dozens of calls and a large amount of location data you will not draw, and on Android it pushes you toward `rateLimitExceeded`.

Render your workout list from the session records alone — type, duration, title, lap count are all on the record — and fetch the route only when the user opens a specific workout.
:::

## Exercise types

`ExerciseType` covers 96 activities, and availability differs between the platforms — `ExerciseType.runningTreadmill` exists on Health Connect but not HealthKit, for instance. Search them all in the [exercise type reference](/reference/exercise-types).

<NextSteps
  :links="[
    { text: 'Fitness recipes', link: '/recipes/fitness', description: 'A complete run with laps, segments, and a route.' },
    { text: 'Exercise types', link: '/reference/exercise-types', description: 'All 96 types and where each is supported.' },
    { text: 'Annotations', link: '/reference/annotations', description: 'Segment weight and the SDK Extension 21 check.' },
  ]"
/>
