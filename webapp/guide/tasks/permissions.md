# Request permissions

How to request, check, enumerate, and revoke health permissions. For why the platforms behave differently here, read [Permissions](/guide/concepts/permissions) first.

## Request permissions

```dart
// 1. Ask for exactly what this feature needs.
final permissions = [
  HealthDataType.steps.readPermission,
  HealthDataType.steps.writePermission,
  HealthDataType.weight.readPermission,
  HealthPlatformFeature.readHealthDataInBackground.permission,
];

// 2. Request them together — one system prompt, not four.
final results = await connector.requestPermissions(permissions);

// 3. Handle each outcome.
for (final result in results) {
  switch (result.status) {
    case PermissionStatus.granted:
      print('Granted: ${result.permission}');
    case PermissionStatus.denied:
      print('Denied: ${result.permission}');
    case PermissionStatus.unknown:
      print('Unknown: ${result.permission} (iOS read permission)');
  }
}
```

::: tip Decide what "good enough" means
Rarely does a feature need every requested permission. Check the ones that block your UI and let the rest degrade:

```dart
final canShowSteps = results.any(
  (r) =>
      r.permission == HealthDataType.steps.readPermission &&
      r.status != PermissionStatus.denied,
);
```

Use `any`, not `where(...).every(...)`. `every` returns `true` on an empty iterable, so a permission missing from the results entirely would read as granted.
:::

## Check a single permission

```dart
final status = await connector.getPermissionStatus(
  HealthDataType.steps.readPermission,
);

switch (status) {
  case PermissionStatus.granted:
    print('Steps read permission granted');
  case PermissionStatus.denied:
    print('Steps read permission denied');
  case PermissionStatus.unknown:
    print('Steps read permission unknown (iOS read)');
}
```

::: info On iOS this only answers for writes
HealthKit restricts access to read-authorization status to protect user privacy, so the SDK reports `unknown` for every iOS read permission. That is native behavior, not an SDK limitation.
:::

## List every granted permission

<Badge type="warning" text="Android only" />

```dart
try {
  final grantedPermissions = await connector.getGrantedPermissions();
  for (final permission in grantedPermissions) {
    print('Granted: ${permission.dataType} (${permission.accessType})');
  }
} on UnsupportedOperationException {
  print('Listing granted permissions is not supported on iOS');
}
```

HealthKit does not allow apps to enumerate grants — that would let an app fingerprint what a user is hiding. This call throws `UnsupportedOperationException` on iOS.

## Revoke all permissions

<Badge type="warning" text="Android only" />

```dart
try {
  await connector.revokeAllPermissions();
  print('Permissions revoked');
} on UnsupportedOperationException {
  print('Programmatic revocation is not supported on iOS');
}
```

There is no programmatic revocation on iOS. If your app offers a "disconnect Apple Health" control, point the user to **Settings → Health → Data Access & Devices** rather than trying to revoke for them.

## Exercise routes need two permissions

Route access is layered on top of session access. Route permissions alone do nothing:

```dart
final permissions = [
  // Foundation — required.
  HealthDataType.exerciseSession.readPermission,
  HealthDataType.exerciseSession.writePermission,

  // Route access on top.
  HealthDataType.exerciseSession.readExerciseRoutePermission,
  HealthDataType.exerciseSession.writeExerciseRoutePermission,
];

final results = await connector.requestPermissions(permissions);
```

See [Read & write exercise routes](/guide/tasks/exercise-routes).

<NextSteps
  :links="[
    { text: 'Check platform features', link: '/guide/tasks/features', description: 'Background reads and historical access.' },
    { text: 'Read records', link: '/guide/tasks/read', description: 'The first thing to do once access is granted.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Telling denial apart from misconfiguration.' },
  ]"
/>
