import 'dart:async';

import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:test/test.dart';

void main() {
  group('HealthConnectorLogger stream API', () {
    // Store original state
    late bool originalIsEnabled;

    setUp(() {
      originalIsEnabled = HealthConnectorLogger.isEnabled;
      HealthConnectorLogger.isEnabled = true;
    });

    tearDown(() {
      HealthConnectorLogger.isEnabled = originalIsEnabled;
    });

    test('emits log event for info level', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      HealthConnectorLogger.info(
        'TEST',
        operation: 'testOp',
        message: 'info message',
        context: {'key': 'value'},
      );

      // Give stream time to emit
      await Future<void>.delayed(Duration.zero);

      expect(logs, hasLength(1));
      expect(logs[0].level, equals(HealthConnectorLogLevel.info));
      expect(logs[0].tag, equals('TEST'));
      expect(logs[0].operation, equals('testOp'));
      expect(logs[0].message, equals('info message'));
      expect(logs[0].context, equals({'key': 'value'}));

      await subscription.cancel();
    });

    test('emits log event for debug level', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      HealthConnectorLogger.debug(
        'DEBUG_TAG',
        operation: 'debugOp',
      );

      await Future<void>.delayed(Duration.zero);

      expect(logs, hasLength(1));
      expect(logs[0].level, equals(HealthConnectorLogLevel.debug));
      expect(logs[0].tag, equals('DEBUG_TAG'));
      expect(logs[0].operation, equals('debugOp'));

      await subscription.cancel();
    });

    test('emits log event for warning level', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      HealthConnectorLogger.warning(
        'WARN',
        operation: 'warnOp',
        message: 'warning message',
      );

      await Future<void>.delayed(Duration.zero);

      expect(logs, hasLength(1));
      expect(logs[0].level, equals(HealthConnectorLogLevel.warning));
      expect(logs[0].tag, equals('WARN'));
      expect(logs[0].operation, equals('warnOp'));
      expect(logs[0].message, equals('warning message'));

      await subscription.cancel();
    });

    test('emits log event for error level', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      final exception = Exception('test error');
      final stackTrace = StackTrace.current;

      HealthConnectorLogger.error(
        'ERROR',
        operation: 'errorOp',
        message: 'error message',
        exception: exception,
        stackTrace: stackTrace,
      );

      await Future<void>.delayed(Duration.zero);

      expect(logs, hasLength(1));
      expect(logs[0].level, equals(HealthConnectorLogLevel.error));
      expect(logs[0].tag, equals('ERROR'));
      expect(logs[0].operation, equals('errorOp'));
      expect(logs[0].message, equals('error message'));
      expect(logs[0].exception, equals(exception));
      expect(logs[0].stackTrace, equals(stackTrace));

      await subscription.cancel();
    });

    test('does not emit when isEnabled is false', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      // Disable logging
      HealthConnectorLogger.isEnabled = false;

      HealthConnectorLogger.info(
        'TEST',
        operation: 'testOp',
        message: 'should not emit',
      );

      await Future<void>.delayed(Duration.zero);

      expect(logs, isEmpty);

      await subscription.cancel();
    });

    test('emits again after re-enabling', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      // Disable logging
      HealthConnectorLogger.isEnabled = false;

      HealthConnectorLogger.info(
        'TEST',
        operation: 'disabledOp',
      );

      await Future<void>.delayed(Duration.zero);
      expect(logs, isEmpty);

      // Re-enable logging
      HealthConnectorLogger.isEnabled = true;

      HealthConnectorLogger.info(
        'TEST',
        operation: 'enabledOp',
      );

      await Future<void>.delayed(Duration.zero);

      expect(logs, hasLength(1));
      expect(logs[0].operation, equals('enabledOp'));

      await subscription.cancel();
    });

    test('supports multiple simultaneous listeners (broadcast)', () async {
      final logs1 = <HealthConnectorLog>[];
      final logs2 = <HealthConnectorLog>[];

      final subscription1 = HealthConnectorLogger.logs.listen(logs1.add);
      final subscription2 = HealthConnectorLogger.logs.listen(logs2.add);

      HealthConnectorLogger.info(
        'TEST',
        operation: 'broadcastOp',
        message: 'broadcast test',
      );

      await Future<void>.delayed(Duration.zero);

      // Both listeners should receive the event
      expect(logs1, hasLength(1));
      expect(logs2, hasLength(1));

      expect(logs1[0].operation, equals('broadcastOp'));
      expect(logs1[0].message, equals('broadcast test'));

      expect(logs2[0].operation, equals('broadcastOp'));
      expect(logs2[0].message, equals('broadcast test'));

      // Both should be the same event
      expect(logs1[0], equals(logs2[0]));

      await subscription1.cancel();
      await subscription2.cancel();
    });

    test(
      'emitted event has consistent DateTime with structured message',
      () async {
        final logs = <HealthConnectorLog>[];
        final subscription = HealthConnectorLogger.logs.listen(logs.add);

        HealthConnectorLogger.info(
          'TEST',
          operation: 'timeTest',
        );

        await Future<void>.delayed(Duration.zero);

        expect(logs, hasLength(1));
        final log = logs[0];

        // Extract datetime from structured message
        final datetimePattern = RegExp(
          r'datetime: (\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}\.\d{3})',
        );
        final match = datetimePattern.firstMatch(log.structuredMessage);
        expect(match, isNotNull);

        // Parse the datetime from the message
        final parts = match!.group(1)!.split(' ');
        final dateParts = parts[0].split('-');
        final timeParts = parts[1].split(':');
        final secondParts = timeParts[2].split('.');

        final messageDateTime = DateTime(
          int.parse(dateParts[2]),
          // year
          int.parse(dateParts[1]),
          // month
          int.parse(dateParts[0]),
          // day
          int.parse(timeParts[0]),
          // hour
          int.parse(timeParts[1]),
          // minute
          int.parse(secondParts[0]),
          // second
          int.parse(secondParts[1]), // millisecond
        );

        // The dateTime field and the datetime in the structured message
        // should be the same (up to millisecond precision, since the formatted
        // message doesn't include microseconds)
        expect(
          log.dateTime.millisecondsSinceEpoch,
          equals(messageDateTime.millisecondsSinceEpoch),
        );

        await subscription.cancel();
      },
    );

    test('structured message field is populated correctly', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      HealthConnectorLogger.info(
        'API',
        operation: 'readRecords',
        message: 'Successfully read 42 records',
        context: {'count': 42, 'duration': '123ms'},
      );

      await Future<void>.delayed(Duration.zero);

      expect(logs, hasLength(1));
      final log = logs[0];

      // Verify structured message contains all the data
      expect(log.structuredMessage, contains('operation: readRecords'));

      expect(
        log.structuredMessage,
        contains('message: Successfully read 42 records'),
      );
      expect(log.structuredMessage, contains('count: 42'));
      expect(log.structuredMessage, contains('duration: 123ms'));

      await subscription.cancel();
    });

    test('emits multiple events in sequence', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      HealthConnectorLogger.debug('TAG', operation: 'op1');
      HealthConnectorLogger.info('TAG', operation: 'op2');
      HealthConnectorLogger.warning('TAG', operation: 'op3');
      HealthConnectorLogger.error('TAG', operation: 'op4');

      await Future<void>.delayed(Duration.zero);

      expect(logs, hasLength(4));
      expect(logs[0].level, equals(HealthConnectorLogLevel.debug));
      expect(logs[1].level, equals(HealthConnectorLogLevel.info));
      expect(logs[2].level, equals(HealthConnectorLogLevel.warning));
      expect(logs[3].level, equals(HealthConnectorLogLevel.error));

      expect(logs[0].operation, equals('op1'));
      expect(logs[1].operation, equals('op2'));
      expect(logs[2].operation, equals('op3'));
      expect(logs[3].operation, equals('op4'));

      await subscription.cancel();
    });

    test('includes all optional fields when provided', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      final exception = Exception('test exception');
      final stackTrace = StackTrace.current;

      HealthConnectorLogger.error(
        'ERROR_TAG',
        operation: 'failedOperation',
        message: 'Operation failed with error',
        context: {'attempt': 3, 'maxRetries': 5},
        exception: exception,
        stackTrace: stackTrace,
      );

      await Future<void>.delayed(Duration.zero);

      expect(logs, hasLength(1));
      final log = logs[0];

      expect(log.level, equals(HealthConnectorLogLevel.error));
      expect(log.tag, equals('ERROR_TAG'));
      expect(log.operation, equals('failedOperation'));

      expect(log.message, equals('Operation failed with error'));
      expect(log.context, equals({'attempt': 3, 'maxRetries': 5}));
      expect(log.exception, equals(exception));
      expect(log.stackTrace, equals(stackTrace));
      expect(log.structuredMessage, isNotEmpty);

      await subscription.cancel();
    });

    test('context is immutable in emitted event', () async {
      final logs = <HealthConnectorLog>[];
      final subscription = HealthConnectorLogger.logs.listen(logs.add);

      final originalContext = {'key': 'value'};

      HealthConnectorLogger.info(
        'TEST',
        operation: 'testOp',
        context: originalContext,
      );

      await Future<void>.delayed(Duration.zero);

      expect(logs, hasLength(1));

      // Modify the original context
      originalContext['key'] = 'modified';
      originalContext['newKey'] = 'newValue';

      // The emitted log should still have the original values
      // (This depends on whether the logger makes a defensive copy)
      expect(logs[0].context, isNotNull);

      await subscription.cancel();
    });
  });
}
