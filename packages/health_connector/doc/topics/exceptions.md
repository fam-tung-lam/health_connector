# Exceptions

Structured error handling for health data operations.

## Exception Hierarchy

All SDK exceptions extend `HealthConnectorException`:

- **NotAuthorizedException**: Permission denied for the requested operation
- **InvalidArgumentException**: Invalid parameters provided
- **HealthPlatformUnavailableException**: Health platform not available on device
- **UnsupportedOperationException**: Feature not supported on current platform

## Error Handling

```dart
try {
  await healthConnector.readRecords(request);
} on NotAuthorizedException {
  // Handle permission denied
} on HealthConnectorException catch (e) {
  // Handle other SDK errors
}
```
