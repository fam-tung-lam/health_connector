# health_connector_logger

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector_logger"><img src="https://img.shields.io/pub/v/health_connector_logger.svg?style=popout"/></a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector_logger/score"><img src="https://img.shields.io/pub/points/health_connector_logger?color=2E8B57&label=pub%20points"/></a>
</p>

Structured logging utility for Health Connector packages.

---

## 📖 Overview

`health_connector_logger` provides a consistent, structured logging interface with formatted
messages across the Health Connector plugin ecosystem. It wraps the `log` function from
`dart:developer` and provides structured logging with operation, phase, message, context, and
exception tracking.

### 🔧 Features

- **Structured Logging**: Consistent format with operation, message, and context
- **Log Levels**: Support for debug, info, warning, and error levels
- **Exception Tracking**: Built-in support for exceptions and stack traces
- **Context Data**: Flexible context map for additional metadata
- **Enable/Disable**: Global toggle to enable or disable logging
- **DateTime Formatting**: Automatic timestamp formatting in logs

---

## 🎯 Requirements

- Dart >=3.9.2

---

## 🚀 Getting Started

Add to your `pubspec.yaml`:

```yaml
dependencies:
  health_connector_logger: [latest_version]
```

---

## 📖 Usage

### Basic Usage

```dart
import 'package:health_connector_logger/health_connector_logger.dart';

// Enable/disable logging
HealthConnectorLogger.isEnabled = true;

// Log levels: debug, info, warning, error
HealthConnectorLogger.debug(
  'API',
  operation: 'readRecords',
  message: 'Starting to read records',
  context: {'dataType': 'StepsRecord', 'pageSize': 100},
);

HealthConnectorLogger.info(
  'API',
  operation: 'readRecords',
  message: 'Successfully read records',
  context: {'recordCount': 42, 'duration': '123ms'},
);

HealthConnectorLogger.warning(
  'API',
  operation: 'readRecords',
  message: 'Operation exceeded threshold',
  context: {'duration': '6234ms', 'threshold': '5000ms'},
);

HealthConnectorLogger.error(
  'API',
  operation: 'readRecords',
  message: 'Failed to read records',
  context: {'dataType': 'StepsRecord', 'duration': '123ms'},
  exception: e,
  stackTrace: st,
);
```

### Log Format

The logger produces structured messages in JSON-like format:

```
[22-09-2025 15:35:55.678][INFO]:
{
   operation: readRecords,
   phase: succeeded,
   message: Successfully read records,
   context: {
     recordCount: 42,
     duration: 123ms,
   },
}
```

---

## 🤝 Contributing

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
