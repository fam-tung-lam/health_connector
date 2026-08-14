# Delete records

Deletion works the same on both platforms, with one hard rule: an app can only delete records it wrote itself.

::: warning You cannot delete another app's data
Both stores enforce ownership. Attempting to delete a record created by a different app throws `AuthorizationException`. There is no permission that grants this.
:::

## Delete by ID

```dart
// 1. Build the request from the IDs you got back when writing.
final request = HealthDataType.steps.deleteByIds([
  HealthRecordId('id-1'),
  HealthRecordId('id-2'),
]);

// 2. Atomic — all succeed or all fail.
await connector.deleteRecords(request);
print('Deleted');
```

## Delete by time range

```dart
final request = HealthDataType.steps.deleteInTimeRange(
  startTime: DateTime.now().subtract(const Duration(days: 7)),
  endTime: DateTime.now(),
);

await connector.deleteRecords(request);
```

This removes every record of that type, in that range, **that your app owns**. Records from other sources in the same window are left untouched.

::: danger Range deletes are broad and irreversible
There is no undo and no confirmation. A range delete driven by user input should be scoped tightly and confirmed in your UI first — an off-by-one on the start time silently removes real health history.
:::

## Implementing "disconnect and clean up"

When a user disconnects your app, delete only what you contributed:

```dart
Future<void> removeOurData(List<HealthDataType> types, DateTime since) async {
  for (final type in types) {
    await connector.deleteRecords(
      type.deleteInTimeRange(startTime: since, endTime: DateTime.now()),
    );
  }
}
```

On Android you can follow this with `revokeAllPermissions()`. On iOS, direct the user to **Settings → Health → Data Access & Devices** — revocation is not available programmatically.

<NextSteps
  :links="[
    { text: 'Update records', link: '/guide/tasks/update', description: 'Where delete is half of the iOS replacement pattern.' },
    { text: 'Request permissions', link: '/guide/tasks/permissions', description: 'Revoking access after cleanup.' },
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Catching AuthorizationException on foreign records.' },
  ]"
/>
