import 'dart:async';

import 'package:async/async.dart';
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
      final future = expectLater(
        HealthConnectorLogger.logs,
        emits(
          isA<HealthConnectorLog>()
              .having(
                (log) => log.level,
                'level',
                equals(HealthConnectorLogLevel.info),
              )
              .having((log) => log.tag, 'tag', equals('TEST'))
              .having((log) => log.operation, 'operation', equals('testOp'))
              .having((log) => log.message, 'message', equals('info message'))
              .having(
                (log) => log.context,
                'context',
                equals({'key': 'value'}),
              ),
        ),
      );

      HealthConnectorLogger.info(
        'TEST',
        operation: 'testOp',
        message: 'info message',
        context: {'key': 'value'},
      );

      await future;
    });

    test('emits log event for debug level', () async {
      final future = expectLater(
        HealthConnectorLogger.logs,
        emits(
          isA<HealthConnectorLog>()
              .having(
                (log) => log.level,
                'level',
                equals(HealthConnectorLogLevel.debug),
              )
              .having((log) => log.tag, 'tag', equals('DEBUG_TAG'))
              .having((log) => log.operation, 'operation', equals('debugOp')),
        ),
      );

      HealthConnectorLogger.debug(
        'DEBUG_TAG',
        operation: 'debugOp',
        message: 'Debug message',
      );

      await future;
    });

    test('emits log event for warning level', () async {
      final future = expectLater(
        HealthConnectorLogger.logs,
        emits(
          isA<HealthConnectorLog>()
              .having(
                (log) => log.level,
                'level',
                equals(HealthConnectorLogLevel.warning),
              )
              .having((log) => log.tag, 'tag', equals('WARN'))
              .having((log) => log.operation, 'operation', equals('warnOp'))
              .having(
                (log) => log.message,
                'message',
                equals('warning message'),
              ),
        ),
      );

      HealthConnectorLogger.warning(
        'WARN',
        operation: 'warnOp',
        message: 'warning message',
      );

      await future;
    });

    test('emits log event for error level', () async {
      final exception = Exception('test error');
      final stackTrace = StackTrace.current;

      final future = expectLater(
        HealthConnectorLogger.logs,
        emits(
          isA<HealthConnectorLog>()
              .having(
                (log) => log.level,
                'level',
                equals(HealthConnectorLogLevel.error),
              )
              .having((log) => log.tag, 'tag', equals('ERROR'))
              .having((log) => log.operation, 'operation', equals('errorOp'))
              .having((log) => log.message, 'message', equals('error message'))
              .having((log) => log.exception, 'exception', equals(exception))
              .having(
                (log) => log.stackTrace,
                'stackTrace',
                equals(stackTrace),
              ),
        ),
      );

      HealthConnectorLogger.error(
        'ERROR',
        operation: 'errorOp',
        message: 'error message',
        exception: exception,
        stackTrace: stackTrace,
      );

      await future;
    });

    test('does not emit when isEnabled is false', () async {
      // Disable logging
      HealthConnectorLogger.isEnabled = false;

      // Ensure no events are emitted
      final stream = HealthConnectorLogger.logs;
      // We start listening
      final subscription = stream.listen(
        (event) => fail('Should not emit event'),
      );

      HealthConnectorLogger.info(
        'TEST',
        operation: 'testOp',
        message: 'should not emit',
      );

      // Wait a bit to ensure nothing is emitted
      await Future<void>.delayed(Duration.zero);
      await subscription.cancel();
    });

    test('emits again after re-enabling', () async {
      // Disable logging
      HealthConnectorLogger.isEnabled = false;
      final queue = StreamQueue(HealthConnectorLogger.logs);

      HealthConnectorLogger.info(
        'TEST',
        operation: 'disabledOp',
        message: 'Disabled message',
      );
      // We expect nothing here.

      // Re-enable logging
      HealthConnectorLogger.isEnabled = true;

      HealthConnectorLogger.info(
        'TEST',
        operation: 'enabledOp',
        message: 'Enabled message',
      );

      await expectLater(
        queue.next,
        completion(
          isA<HealthConnectorLog>().having(
            (log) => log.operation,
            'operation',
            equals('enabledOp'),
          ),
        ),
      );
      await queue.cancel();
    });

    test('supports multiple simultaneous listeners (broadcast)', () async {
      final logMatcher = isA<HealthConnectorLog>()
          .having((log) => log.operation, 'operation', 'broadcastOp')
          .having((log) => log.message, 'message', 'broadcast test');

      final future1 = expectLater(
        HealthConnectorLogger.logs,
        emits(logMatcher),
      );
      final future2 = expectLater(
        HealthConnectorLogger.logs,
        emits(logMatcher),
      );

      HealthConnectorLogger.info(
        'TEST',
        operation: 'broadcastOp',
        message: 'broadcast test',
      );

      await Future.wait([future1, future2]);
    });

    test(
      'emitted event has consistent DateTime with structured message',
      () async {
        final future = expectLater(
          HealthConnectorLogger.logs,
          emits(
            isA<HealthConnectorLog>().having(
              (log) {
                // Extract datetime from structured message
                final datetimePattern = RegExp(
                  r'datetime: (\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}\.\d{3})',
                );
                if (log.structuredMessage == null) {
                  return false;
                }
                final match = datetimePattern.firstMatch(
                  log.structuredMessage!,
                );
                if (match == null) {
                  return false;
                }

                // Parse the datetime from the message
                final parts = match.group(1)!.split(' ');
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
                // should be the same (up to millisecond precision)
                return log.dateTime.millisecondsSinceEpoch ==
                    messageDateTime.millisecondsSinceEpoch;
              },
              'has consistent DateTime with structured message',
              true,
            ),
          ),
        );

        HealthConnectorLogger.info(
          'TEST',
          operation: 'timeTest',
          message: 'Time test message',
        );

        await future;
      },
    );

    test('structured message field is populated correctly', () async {
      final future = expectLater(
        HealthConnectorLogger.logs,
        emits(
          isA<HealthConnectorLog>().having(
            (log) {
              final sm = log.structuredMessage;
              if (sm == null) {
                return false;
              }
              return sm.contains('operation: readRecords') &&
                  sm.contains('message: Successfully read 42 records') &&
                  sm.contains('count: 42') &&
                  sm.contains('duration: 123ms');
            },
            'structuredMessage',
            isTrue,
          ),
        ),
      );

      HealthConnectorLogger.info(
        'API',
        operation: 'readRecords',
        message: 'Successfully read 42 records',
        context: {'count': 42, 'duration': '123ms'},
      );

      await future;
    });

    test('emits multiple events in sequence', () async {
      final future = expectLater(
        HealthConnectorLogger.logs,
        emitsInOrder([
          isA<HealthConnectorLog>()
              .having(
                (log) => log.level,
                'level',
                equals(HealthConnectorLogLevel.debug),
              )
              .having((log) => log.operation, 'operation', 'op1'),
          isA<HealthConnectorLog>()
              .having(
                (log) => log.level,
                'level',
                equals(HealthConnectorLogLevel.info),
              )
              .having((log) => log.operation, 'operation', 'op2'),
          isA<HealthConnectorLog>()
              .having(
                (log) => log.level,
                'level',
                equals(HealthConnectorLogLevel.warning),
              )
              .having((log) => log.operation, 'operation', 'op3'),
          isA<HealthConnectorLog>()
              .having(
                (log) => log.level,
                'level',
                equals(HealthConnectorLogLevel.error),
              )
              .having((log) => log.operation, 'operation', 'op4'),
        ]),
      );

      HealthConnectorLogger.debug('TAG', operation: 'op1', message: 'message1');
      HealthConnectorLogger.info('TAG', operation: 'op2', message: 'message2');
      HealthConnectorLogger.warning(
        'TAG',
        operation: 'op3',
        message: 'message3',
      );
      HealthConnectorLogger.error('TAG', operation: 'op4', message: 'message4');

      await future;
    });

    test('includes all optional fields when provided', () async {
      final exception = Exception('test exception');
      final stackTrace = StackTrace.current;

      final future = expectLater(
        HealthConnectorLogger.logs,
        emits(
          isA<HealthConnectorLog>()
              .having(
                (log) => log.level,
                'level',
                equals(HealthConnectorLogLevel.error),
              )
              .having((log) => log.tag, 'tag', 'ERROR_TAG')
              .having((log) => log.operation, 'operation', 'failedOperation')
              .having(
                (log) => log.message,
                'message',
                'Operation failed with error',
              )
              .having(
                (log) => log.context,
                'context',
                {'attempt': 3, 'maxRetries': 5},
              )
              .having((log) => log.exception, 'exception', exception)
              .having((log) => log.stackTrace, 'stackTrace', stackTrace)
              .having(
                (log) => log.structuredMessage,
                'structuredMessage',
                isNotEmpty,
              ),
        ),
      );

      HealthConnectorLogger.error(
        'ERROR_TAG',
        operation: 'failedOperation',
        message: 'Operation failed with error',
        context: {'attempt': 3, 'maxRetries': 5},
        exception: exception,
        stackTrace: stackTrace,
      );

      await future;
    });

    test('context is immutable in emitted event', () async {
      final originalContext = {'key': 'value'};

      final future = expectLater(
        HealthConnectorLogger.logs,
        emits(
          isA<HealthConnectorLog>().having(
            (log) => log.context,
            'context',
            equals({'key': 'value'}), // Matches original state
          ),
        ),
      );

      HealthConnectorLogger.info(
        'TEST',
        operation: 'testOp',
        message: 'Test message',
        context: originalContext,
      );

      await future;

      // Modify the original context
      originalContext['key'] = 'modified';
      originalContext['newKey'] = 'newValue';
    });
  });
}
