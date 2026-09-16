import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector_internal.dart'
    show
        HealthConnectorDartLog,
        HealthConnectorLogLevel,
        HealthConnectorNativeLog;
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';

void main() {
  final dateTime = DateTime(2026, 9, 16, 10, 30, 15, 250);

  group('ConsoleLogEntry.fromHealthConnectorLog', () {
    test('maps a Dart log with the dart origin and the capturing isolate', () {
      // Given a Dart SDK log with context and an exception.
      final log = HealthConnectorDartLog(
        level: HealthConnectorLogLevel.warning,
        tag: 'HealthConnector',
        dateTime: dateTime,
        message: 'Sync token expired',
        operation: 'synchronize',
        context: const {'data_type_count': 2},
        exception: const FormatException('bad token'),
      );

      // When it is converted in the background isolate.
      final entry = ConsoleLogEntry.fromHealthConnectorLog(
        log,
        isolate: ConsoleLogIsolate.background,
      );

      // Then every field is flattened into plain values.
      expect(entry.origin, ConsoleLogEntry.dartOrigin);
      expect(entry.isNative, isFalse);
      expect(entry.isolate, ConsoleLogIsolate.background);
      expect(entry.level, HealthConnectorLogLevel.warning);
      expect(entry.tag, 'HealthConnector');
      expect(entry.message, 'Sync token expired');
      expect(entry.operation, 'synchronize');
      expect(entry.context, {'data_type_count': '2'});
      expect(entry.exception, contains('bad token'));
      expect(entry.timestamp, dateTime);
      expect(entry.id, startsWith('${dateTime.microsecondsSinceEpoch}:'));
    });

    test('maps a native log with its platform as origin', () {
      // Given a native log relayed by the Android plugin.
      final log = HealthConnectorNativeLog(
        platform: 'android_healthConnect',
        level: HealthConnectorLogLevel.debug,
        tag: 'ReadRecordsHandler',
        dateTime: dateTime,
        message: 'Read 3 records',
      );

      // When it is converted.
      final entry = ConsoleLogEntry.fromHealthConnectorLog(
        log,
        isolate: ConsoleLogIsolate.main,
      );

      // Then the origin reflects the native platform.
      expect(entry.origin, 'android_healthConnect');
      expect(entry.isNative, isTrue);
      expect(entry.context, isNull);
      expect(entry.exception, isNull);
    });
  });

  group('ConsoleLogEntry JSON', () {
    test('round-trips every field', () {
      // Given a fully populated entry.
      final entry = ConsoleLogEntry(
        id: 'id-1',
        timestamp: dateTime,
        level: HealthConnectorLogLevel.error,
        tag: 'Tag',
        message: 'Boom',
        origin: 'ios_appleHealth',
        isolate: ConsoleLogIsolate.background,
        operation: 'write',
        exception: 'StateError: Boom',
        context: const {'key': 'value'},
      );

      // When it is serialized and restored.
      final restored = ConsoleLogEntry.fromJson(entry.toJson());

      // Then the restored entry equals the original.
      expect(restored, entry);
      expect(restored.hashCode, entry.hashCode);
    });

    test('falls back to info level and main isolate for unknown values', () {
      // Given JSON with unknown level and isolate identifiers.
      final json = {
        'id': 'id-2',
        'timestamp': dateTime.microsecondsSinceEpoch,
        'level': 'VERBOSE',
        'tag': 'Tag',
        'message': 'Hello',
        'origin': 'dart',
        'isolate': 'worker',
      };

      // When it is restored.
      final entry = ConsoleLogEntry.fromJson(json);

      // Then safe defaults are applied.
      expect(entry.level, HealthConnectorLogLevel.info);
      expect(entry.isolate, ConsoleLogIsolate.main);
      expect(entry.operation, isNull);
    });
  });

  test('formattedLine contains time, level, tag, operation and message', () {
    // Given an entry with an operation.
    final entry = ConsoleLogEntry(
      id: 'id-3',
      timestamp: dateTime,
      level: HealthConnectorLogLevel.info,
      tag: 'HealthConnector',
      message: 'created',
      origin: ConsoleLogEntry.dartOrigin,
      isolate: ConsoleLogIsolate.main,
      operation: 'create',
    );

    // When it is formatted.
    final line = entry.formattedLine;

    // Then the line follows the console layout.
    expect(line, '[10:30:15.250] [INFO] [HealthConnector] create: created');
    expect(entry.toString(), line);
  });
}
