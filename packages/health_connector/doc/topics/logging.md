# Logging API

The Health Connector SDK provides a flexible, secure-by-default logging
system designed to protect sensitive health data while giving developers
full visibility during development.

## Zero-Logging Policy

Health data is highly sensitive. To ensure privacy and compliance (GDPR, HIPAA),
the SDK adopts a **strict zero-logging policy by default**.

- **No Internal Logging**: The SDK never writes to `print`, `stdout`, or
  platform logs (Logcat/Console) unless explicitly configured.
- **Full Control**: You define exactly where logs go.
- **Unified Control Plane**: Native logs from Android (Kotlin) and iOS (Swift)
  are forwarded to Dart, giving you a single place to manage all SDK activity.

## Configuration

Logging is configured via the `HealthConnectorLoggerConfig` object passed to
`HealthConnectorConfig` during initialization.

## Basic Setup

To enable logging, provide a list of `logProcessors`.

```dart
final connector = await HealthConnector.create(
  const HealthConnectorConfig(
    loggerConfig: HealthConnectorLoggerConfig(
      // Choose your log processors
      logProcessors: [
        PrintLogProcessor(levels: HealthConnectorLogLevel.values),
      ],
    ),
  ),
);
```

### Log Levels

The SDK uses `HealthConnectorLogLevel` to categorize events:

| Level     | Usage                                   |
|:----------|:----------------------------------------|
| `debug`   | Detailed diagnostic info (payloads,     |
|           | internal state changes)                 |
| `info`    | General operational events (setup       |
|           | success, sync started)                  |
| `warning` | Potential issues that don't stop        |
|           | execution (unsupported types, partial   |
|           | failures)                               |
| `error`   | Serious failures (auth denied, database |
|           | errors)                                 |

## Native Logging

By default, the SDK forwards logs from native platform code to your Dart
processors. This allows you to see what's happening deep inside the
Health Connect or HealthKit integrations.

To disable this (e.g., for performance in production), set `enableNativeLogging` to `false`:

```dart
const HealthConnectorLoggerConfig(
  enableNativeLogging: false, // Suppress native logs
  logProcessors: [...],
)
```

## Built-in Processors

The SDK comes with two standard processors:

### PrintLogProcessor

Writes logs to the console using `print()`. This is useful for simple debugging
and CI environments where you want visible output.

```dart
PrintLogProcessor(
  levels: [HealthConnectorLogLevel.error], // Only print errors
)
```

### DeveloperLogProcessor

Uses `Dart:developer.log()` to integrate with
[Flutter DevTools](https://docs.flutter.dev/tools/devtools/logging).

- **Structure**: Logs appear with proper severity colors, timestamps, and metadata.
- **Performance**: minimal overhead in release builds (calls are stripped).
- **Best for**: Active development and debugging.

```dart
DeveloperLogProcessor(
  levels: HealthConnectorLogLevel.values, // Log everything to DevTools
)
```

### Custom Processors

You can create custom processors to route logs to files, analytics services,
or crash reporting tools (like Sentry or Firebase Crashlytics).

Extend `HealthConnectorLogProcessor` and implement the `process` method.

#### Example: File Logger

```dart
class FileLogProcessor extends HealthConnectorLogProcessor {
  final File logFile;

  const FileLogProcessor({
    required this.logFile,
    // Default to handling all levels
    super.levels = HealthConnectorLogLevel.values, 
  });

  @override
  Future<void> process(HealthConnectorLog log) async {
    try {
      // access structured data: log.level, log.message, log.dateTime, etc.
      final line = '${log.dateTime} [${log.level.name}] ${log.tag}: ${log.message}\n';
      await logFile.writeAsString(line, mode: FileMode.append);
    } catch (e) {
      // Handle errors internally, don't throw!
      print('Failed to write log: $e');
    }
  }
}
```

#### Example: Filtering

Override `shouldProcess` for advanced filtering logic beyond just log levels.

```dart
@override
bool shouldProcess(HealthConnectorLog log) {
  // Only process errors that contain specific context
  return super.shouldProcess(log) && log.context?['critical'] == true;
}
```
