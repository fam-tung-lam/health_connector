import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:health_connector_logger/src/health_connector_logger.dart';
import 'package:test/test.dart';

void main() {
  group(HealthConnectorLog, () {
    final testDateTime = DateTime(2024, 3, 15, 10, 30, 45, 123);
    const testStructuredMessage = '{\n  test: message\n}';

    test('creates instance with all required fields', () {
      final log = HealthConnectorLog(
        level: LogLevel.info,
        tag: 'TEST',
        operation: 'testOp',
        dateTime: testDateTime,
        structuredMessage: testStructuredMessage,
      );

      expect(log.level, equals(LogLevel.info));
      expect(log.tag, equals('TEST'));
      expect(log.operation, equals('testOp'));
      expect(log.dateTime, equals(testDateTime));
      expect(log.structuredMessage, equals(testStructuredMessage));

      expect(log.message, isNull);
      expect(log.context, isNull);
      expect(log.exception, isNull);
      expect(log.stackTrace, isNull);
    });

    test('creates instance with all optional fields', () {
      final exception = Exception('test');
      final stackTrace = StackTrace.current;
      final context = {'key': 'value'};

      final log = HealthConnectorLog(
        level: LogLevel.error,
        tag: 'ERROR',
        operation: 'failedOp',
        dateTime: testDateTime,
        structuredMessage: testStructuredMessage,
        message: 'Operation failed',
        context: context,
        exception: exception,
        stackTrace: stackTrace,
      );

      expect(log.message, equals('Operation failed'));
      expect(log.context, equals(context));
      expect(log.exception, equals(exception));
      expect(log.stackTrace, equals(stackTrace));
    });

    group('equality', () {
      test('two logs with identical values are equal', () {
        final log1 = HealthConnectorLog(
          level: LogLevel.info,
          tag: 'TEST',
          operation: 'testOp',
          dateTime: testDateTime,
          structuredMessage: testStructuredMessage,

          message: 'test message',
          context: const {'key': 'value'},
        );

        final log2 = HealthConnectorLog(
          level: LogLevel.info,
          tag: 'TEST',
          operation: 'testOp',
          dateTime: testDateTime,
          structuredMessage: testStructuredMessage,

          message: 'test message',
          context: const {'key': 'value'},
        );

        expect(log1, equals(log2));
        expect(log1.hashCode, equals(log2.hashCode));
      });

      test('two logs with different levels are not equal', () {
        final log1 = HealthConnectorLog(
          level: LogLevel.info,
          tag: 'TEST',
          operation: 'testOp',
          dateTime: testDateTime,
          structuredMessage: testStructuredMessage,
        );

        final log2 = HealthConnectorLog(
          level: LogLevel.debug,
          tag: 'TEST',
          operation: 'testOp',
          dateTime: testDateTime,
          structuredMessage: testStructuredMessage,
        );

        expect(log1, isNot(equals(log2)));
      });

      test('two logs with different context are not equal', () {
        final log1 = HealthConnectorLog(
          level: LogLevel.info,
          tag: 'TEST',
          operation: 'testOp',
          dateTime: testDateTime,
          structuredMessage: testStructuredMessage,
          context: const {'key': 'value1'},
        );

        final log2 = HealthConnectorLog(
          level: LogLevel.info,
          tag: 'TEST',
          operation: 'testOp',
          dateTime: testDateTime,
          structuredMessage: testStructuredMessage,
          context: const {'key': 'value2'},
        );

        expect(log1, isNot(equals(log2)));
      });

      test('handles null context in equality', () {
        final log1 = HealthConnectorLog(
          level: LogLevel.info,
          tag: 'TEST',
          operation: 'testOp',
          dateTime: testDateTime,
          structuredMessage: testStructuredMessage,
        );

        final log2 = HealthConnectorLog(
          level: LogLevel.info,
          tag: 'TEST',
          operation: 'testOp',
          dateTime: testDateTime,
          structuredMessage: testStructuredMessage,
        );

        expect(log1, equals(log2));
      });
    });

    test('toString includes all fields', () {
      final log = HealthConnectorLog(
        level: LogLevel.warning,
        tag: 'WARN',
        operation: 'warnOp',
        dateTime: testDateTime,
        structuredMessage: testStructuredMessage,
        message: 'Warning message',
        context: const {'count': 5},
      );

      final str = log.toString();
      expect(str, contains('WARNING'));
      expect(str, contains('WARN'));
      expect(str, contains('warnOp'));
      expect(str, contains('2024-03-15'));

      expect(str, contains('Warning message'));
      expect(str, contains('{count: 5}'));
    });
  });
}
