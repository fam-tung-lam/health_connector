# Dart Source Conventions

This reference owns Health Connector's recurring Dart annotation and logging
shapes beyond the loaded Dart foundation.

Use `@internalUse` for a declaration shared only by Health Connector packages.
Pair it with `@internal` when consumers outside the declaring package must also
receive an analyzer warning. Use `@visibleForTesting` only on an established
replacement seam. These annotations express three different audiences; one is
not a synonym for another.

Structured logs use `HealthConnectorLogger.debug`, `.info`, `.warning`, or
`.error`:

```dart
HealthConnectorLogger.info(
  tag,
  operation: 'readRecords',
  message: 'Records read successfully',
  context: {'record_count': records.length},
);
```

Pass the tag positionally. Instance code uses its established `tag` getter;
static code declares a private constant. Keep new context keys `snake_case` and
values small and non-identifying. A translated failure log includes `exception:`
and `stackTrace:` when available.

Follow the neighboring declaration's annotation order. Match the established
terms record, data type, platform client, DTO, and measurement unit exactly.
