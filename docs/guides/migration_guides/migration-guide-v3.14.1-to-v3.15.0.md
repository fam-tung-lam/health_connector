# Migrate from Health Connector 3.14.1 to 3.15.0

On Android and iOS, `HealthConnector.aggregate()` throws `NoDataException` when
no data contributes to the requested metric. A measured zero still returns a
value of zero in the requested unit. This also applies when a saved workout has
no active energy data.

Catch `NoDataException` where the app needs to handle a missing measurement.
For example, return `null` so the UI can display a missing value.

```dart
Future<U?> aggregateOrNull<U extends MeasurementUnit>(
  HealthConnector connector,
  AggregateRequest<U> request,
) async {
  try {
    return await connector.aggregate(request);
  } on NoDataException {
    return null;
  }
}
```

Add a `NoDataException` branch to exhaustive switches on
`HealthConnectorException` and a `HealthConnectorErrorCode.noData` branch to
exhaustive switches on `HealthConnectorErrorCode`.

If you implement `HealthConnector` in a test double or custom adapter, add
`aggregateByDay()` to that implementation. The new method and its
`DailyAggregateResult` type are experimental.
