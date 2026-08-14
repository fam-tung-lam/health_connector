# Configure logging

The SDK has a **strict zero-logging default**. Nothing is written to `print`, `stdout`, or platform logs unless you supply a processor.

That default is deliberate. Health data leaking into Logcat, Console, or a crash-reporting service is one of the easier ways to fail a security review, and it is not a decision an SDK should make for you.

## What you get by opting in

- **Full control** over destination, format, and level.
- **Native logs included** — diagnostics from the Kotlin and Swift layers are forwarded through to Dart, so there is a single control plane rather than three.
- **A clean compliance story** — you can state exactly where SDK output goes, which matters under GDPR and HIPAA.

## Built-in processors

Processors are configured through `HealthConnectorLoggerConfig`, and each one handles logs independently and asynchronously.

```dart
final connector = await HealthConnector.create(
  const HealthConnectorConfig(
    loggerConfig: HealthConnectorLoggerConfig(
      // Opt in to forwarding native Kotlin/Swift logs.
      enableNativeLogging: false,
      logProcessors: [
        // Console output, warnings and errors only.
        PrintLogProcessor(
          levels: [
            HealthConnectorLogLevel.warning,
            HealthConnectorLogLevel.error,
          ],
        ),

        // Everything into dart:developer, which DevTools picks up.
        DeveloperLogProcessor(
          levels: HealthConnectorLogLevel.values,
        ),
      ],
    ),
  ),
);
```

| Processor | Destination | Good for |
|---|---|---|
| `PrintLogProcessor` | Console via `print` | Quick local debugging |
| `DeveloperLogProcessor` | `dart:developer` | DevTools inspection |
| Your own | Anywhere | Crash reporting, files, backends |

## Write a custom processor

Extend `HealthConnectorLogProcessor` and implement two methods:

- **`process(HealthConnectorLog log)`** — handle the entry.
- **`shouldProcess(HealthConnectorLog log)`** — decide whether to handle it at all.

```dart
import 'dart:io';
import 'package:health_connector/health_connector.dart';

/// Writes error-level logs to a file on disk.
class FileLogProcessor extends HealthConnectorLogProcessor {
  final File logFile;

  const FileLogProcessor({
    required this.logFile,
    super.levels = HealthConnectorLogLevel.values,
  });

  @override
  Future<void> process(HealthConnectorLog log) async {
    try {
      final formatted = '${log.dateTime} [${log.level.name.toUpperCase()}] '
          '${log.message}\n';
      await logFile.writeAsString(formatted, mode: FileMode.append);
    } catch (e) {
      // Never let a processor throw — it would surface inside SDK calls.
      debugPrint('Failed to write log: $e');
    }
  }

  @override
  bool shouldProcess(HealthConnectorLog log) {
    return super.shouldProcess(log) &&
        log.level == HealthConnectorLogLevel.error;
  }
}
```

::: warning Swallow errors inside processors
A processor that throws turns a logging problem into an SDK failure. Wrap the body in `try`/`catch` and fail quietly.
:::

## Register it

Custom and built-in processors compose freely:

```dart
final connector = await HealthConnector.create(
  HealthConnectorConfig(
    loggerConfig: HealthConnectorLoggerConfig(
      logProcessors: [
        PrintLogProcessor(levels: [HealthConnectorLogLevel.error]),
        FileLogProcessor(logFile: File('/path/to/app.log')),
      ],
    ),
  ),
);
```

## Common destinations

| Goal | Approach |
|---|---|
| Crash reporting | Forward error-level logs to Crashlytics or Sentry in `process()` |
| Remote logging | POST batches to your backend; buffer, do not send per entry |
| Structured logs | Emit JSON for a log aggregator |
| Environment gating | Override `shouldProcess()` to stay silent in release builds |

::: danger Redact before you forward
Log messages can reference health data. Anything leaving the device — crash reporter, analytics, backend — should be filtered or redacted first. The zero-logging default protects you until you add a processor; after that, it is your policy.
:::

<NextSteps
  :links="[
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'What the SDK reports, and how to react.' },
    { text: 'Setup troubleshooting', link: '/guide/troubleshooting', description: 'Turn on logging to diagnose a first run.' },
    { text: 'Architecture', link: '/guide/concepts/architecture', description: 'How native logs reach Dart.' },
  ]"
/>
