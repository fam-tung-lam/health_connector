import 'package:health_connector_logger/src/health_connector_logger.dart';
import 'package:health_connector_logger/src/models/health_connector_log_level.dart';
import 'package:test/test.dart';

import '../../utils/date_time_parser.dart' show parseDateTime;

void main() {
  group('HealthConnectorLogger.formatStructuredMessage', () {
    // Use fixed DateTime for predictable output
    final testDateTime = DateTime(2024, 3, 15, 10, 30, 45, 123);

    group('basic formatting', () {
      test('formats message with only required parameters', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'readRecords',
          dateTime: testDateTime,
        );

        expect(result, contains('datetime: 15-03-2024 10:30:45.123'));
        expect(result, contains('operation: readRecords'));
        expect(result, startsWith('{'));
        expect(result, endsWith('\n}'));
        expect(result, isNot(contains('message:')));
        expect(result, isNot(contains('exception:')));
        expect(result, isNot(contains('context:')));
      });

      test('includes datetime and operation in correct format', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.debug,
          operation: 'testOperation',
          dateTime: testDateTime,
        );

        final lines = result.split('\n');
        expect(lines[0], equals('{'));
        expect(lines[1], equals('    datetime: 15-03-2024 10:30:45.123,'));
        expect(lines[2], equals('    operation: testOperation,'));
      });
    });

    group('DateTime formatting', () {
      test('formats datetime with zero-padding for single-digit values', () {
        final singleDigitDateTime = DateTime(2024, 1, 5, 9, 3, 7, 42);
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          dateTime: singleDigitDateTime,
        );

        expect(result, contains('datetime: 05-01-2024 09:03:07.042'));
      });

      test('formats datetime correctly for edge case dates', () {
        final edgeCaseDateTime = DateTime(2024, 12, 31, 23, 59, 59, 999);
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          dateTime: edgeCaseDateTime,
        );

        expect(result, contains('datetime: 31-12-2024 23:59:59.999'));
      });

      test('uses current datetime when dateTime parameter is not provided', () {
        final before = DateTime.now();
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
        );
        final after = DateTime.now();

        // Extract datetime from result
        final datetimeMatch = RegExp(
          r'datetime: (\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}\.\d{3})',
        ).firstMatch(result);
        expect(datetimeMatch, isNotNull);

        final loggedDateTime = parseDateTime(datetimeMatch!.group(1)!);
        expect(
          loggedDateTime.isAfter(before.subtract(const Duration(seconds: 1))),
          isTrue,
        );
        expect(
          loggedDateTime.isBefore(after.add(const Duration(seconds: 1))),
          isTrue,
        );
      });
    });

    group('optional message parameter', () {
      test('includes message field when provided', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'readRecords',
          message: 'Successfully read records',
          dateTime: testDateTime,
        );

        expect(result, contains('message: Successfully read records'));
        expect(result, contains('operation: readRecords'));
      });

      test('omits message field when null', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'readRecords',
          dateTime: testDateTime,
        );

        expect(result, isNot(contains('message:')));
        expect(result, contains('operation: readRecords'));
      });

      test('handles message with newlines and special characters', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          message: 'Message with\nnewline and "quotes"',
          dateTime: testDateTime,
        );

        expect(result, contains('message: Message with\nnewline and "quotes"'));
      });
    });

    group('exception handling', () {
      test('includes exception block with only exception', () {
        final exception = Exception('Test exception');
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.error,
          operation: 'test',
          exception: exception,
          dateTime: testDateTime,
        );

        expect(result, contains('exception: {'));
        expect(result, contains('cause: $exception'));
        expect(result, isNot(contains('stack_trace:')));
        expect(result, contains('    },'));
      });

      test('includes exception block with only stackTrace', () {
        final stackTrace = StackTrace.current;
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.error,
          operation: 'test',
          stackTrace: stackTrace,
          dateTime: testDateTime,
        );

        expect(result, contains('exception: {'));
        expect(result, contains('stack_trace: $stackTrace'));
        expect(result, isNot(contains('cause:')));
        expect(result, contains('    },'));
      });

      test('includes exception block with both exception and stackTrace', () {
        final exception = Exception('Test exception');
        final stackTrace = StackTrace.current;
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.error,
          operation: 'test',
          exception: exception,
          stackTrace: stackTrace,
          dateTime: testDateTime,
        );

        expect(result, contains('exception: {'));
        expect(result, contains('cause: $exception'));
        expect(result, contains('stack_trace: $stackTrace'));
        expect(result, contains('    },'));
      });

      test('omits exception block when both are null', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          dateTime: testDateTime,
        );

        expect(result, isNot(contains('exception:')));
      });

      test('handles different exception types', () {
        final argumentError = ArgumentError('Invalid argument');
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.error,
          operation: 'test',
          exception: argumentError,
          dateTime: testDateTime,
        );

        expect(result, contains('cause: $argumentError'));
      });
    });

    group('context formatting', () {
      test('includes simple key-value context', () {
        final context = {
          'recordCount': 42,
          'duration': '123ms',
        };
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'readRecords',
          context: context,
          dateTime: testDateTime,
        );

        expect(result, contains('context: {'));
        expect(result, contains('recordCount: 42'));
        expect(result, contains('duration: 123ms'));
        expect(result, contains('    },'));
      });

      test('includes context with nested maps', () {
        final context = {
          'metadata': {
            'version': '1.0',
            'source': 'health_kit',
          },
        };
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          context: context,
          dateTime: testDateTime,
        );

        expect(result, contains('context: {'));
        expect(result, contains('metadata: {'));
        expect(result, contains('version: 1.0'));
        expect(result, contains('source: health_kit'));
        expect(result, contains('        },'));
      });

      test('includes context with deeply nested maps', () {
        final context = {
          'level1': {
            'level2': {
              'level3': 'deep value',
            },
          },
        };
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          context: context,
          dateTime: testDateTime,
        );

        expect(result, contains('level1: {'));
        expect(result, contains('level2: {'));
        expect(result, contains('level3: deep value'));
      });

      test('includes context with lists', () {
        final context = {
          'recordIds': [1, 2, 3],
          'tags': ['tag1', 'tag2'],
        };
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          context: context,
          dateTime: testDateTime,
        );

        expect(result, contains('context: {'));
        expect(result, contains('recordIds: ['));
        expect(result, contains('tags: ['));
        expect(result, contains('1,'));
        expect(result, contains('2,'));
        expect(result, contains('3,'));
        expect(result, contains('tag1,'));
        expect(result, contains('tag2,'));
      });

      test('includes context with nested lists', () {
        final context = {
          'matrix': [
            [1, 2],
            [3, 4],
          ],
        };
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          context: context,
          dateTime: testDateTime,
        );

        expect(result, contains('matrix: ['));
        expect(result, contains('['));
        expect(result, contains('1,'));
        expect(result, contains('2,'));
      });

      test('excludes empty context', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          context: {},
          dateTime: testDateTime,
        );

        expect(result, isNot(contains('context:')));
      });

      test('excludes null context', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          dateTime: testDateTime,
        );

        expect(result, isNot(contains('context:')));
      });

      test('handles context with mixed types', () {
        final context = {
          'stringValue': 'text',
          'intValue': 42,
          'doubleValue': 3.14,
          'boolValue': true,
          'nullValue': null,
        };
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          context: context,
          dateTime: testDateTime,
        );

        expect(result, contains('stringValue: text'));
        expect(result, contains('intValue: 42'));
        expect(result, contains('doubleValue: 3.14'));
        expect(result, contains('boolValue: true'));
        expect(result, contains('nullValue: null'));
      });

      test('handles context with empty lists and maps', () {
        final context = {
          'emptyList': <int>[],
          'emptyMap': <String, dynamic>{},
        };
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          context: context,
          dateTime: testDateTime,
        );

        expect(result, contains('emptyList: []'));
        expect(result, contains('emptyMap: {}'));
      });
    });

    group('log levels', () {
      test('works with LogLevel.debug', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.debug,
          operation: 'test',
          dateTime: testDateTime,
        );

        expect(result, contains('operation: test'));
        expect(result, isA<String>());
      });

      test('works with LogLevel.info', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          dateTime: testDateTime,
        );

        expect(result, contains('operation: test'));
        expect(result, isA<String>());
      });

      test('works with LogLevel.warning', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.warning,
          operation: 'test',
          dateTime: testDateTime,
        );

        expect(result, contains('operation: test'));
        expect(result, isA<String>());
      });

      test('works with LogLevel.error', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.error,
          operation: 'test',
          dateTime: testDateTime,
        );

        expect(result, contains('operation: test'));
        expect(result, isA<String>());
      });
    });

    group('complete message', () {
      test('formats message with all parameters provided', () {
        final exception = Exception('Test exception');
        final stackTrace = StackTrace.current;
        final context = {
          'recordCount': 42,
          'duration': '123ms',
          'metadata': {
            'version': '1.0',
          },
        };

        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'readRecords',
          dateTime: testDateTime,
          message: 'Successfully read records',
          context: context,
          exception: exception,
          stackTrace: stackTrace,
        );

        // Verify all fields are present
        expect(result, contains('datetime: 15-03-2024 10:30:45.123'));
        expect(result, contains('operation: readRecords'));
        expect(result, contains('message: Successfully read records'));
        expect(result, contains('exception: {'));
        expect(result, contains('cause: $exception'));
        expect(result, contains('stack_trace: $stackTrace'));
        expect(result, contains('context: {'));
        expect(result, contains('recordCount: 42'));
        expect(result, contains('duration: 123ms'));
        expect(result, contains('metadata: {'));
        expect(result, contains('version: 1.0'));

        // Verify structure
        expect(result, startsWith('{'));
        expect(result, endsWith('\n}'));
      });

      test('maintains correct indentation throughout', () {
        final context = {
          'nested': {
            'deep': {
              'value': 'test',
            },
          },
        };

        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          dateTime: testDateTime,
          context: context,
        );

        // Check indentation levels
        expect(result, contains('    datetime:'));
        expect(result, contains('    operation:'));
        expect(result, contains('    context: {'));
        expect(result, contains('        nested: {'));
        expect(result, contains('            deep: {'));
        expect(result, contains('                value: test'));
      });
    });

    group('edge cases', () {
      test('handles empty operation string', () {
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: '',
          dateTime: testDateTime,
        );

        expect(result, contains('operation: ,'));
      });

      test('handles very long operation name', () {
        final longOperation = 'a' * 1000;
        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: longOperation,
          dateTime: testDateTime,
        );

        expect(result, contains('operation: $longOperation'));
      });

      test('handles context with complex nested structures', () {
        final context = {
          'listOfMaps': [
            {'key1': 'value1'},
            {'key2': 'value2'},
          ],
          'mapOfLists': {
            'list1': [1, 2, 3],
            'list2': ['a', 'b', 'c'],
          },
        };

        final result = HealthConnectorLogger.formatStructuredMessage(
          level: HealthConnectorLogLevel.info,
          operation: 'test',
          context: context,
          dateTime: testDateTime,
        );

        expect(result, contains('listOfMaps: ['));
        expect(result, contains('mapOfLists: {'));
        expect(result, contains('list1: ['));
        expect(result, contains('list2: ['));
      });
    });
  });
}
