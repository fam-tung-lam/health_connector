import 'package:health_connector_core/src/utils/datetime_utils.dart';
import 'package:test/test.dart';

void main() {
  group(
    'formatTimeRange',
    () {
      test(
        'GIVEN two basic DateTime instances → '
        'WHEN formatTimeRange is called → '
        'THEN returns ISO 8601 formatted string',
        () {
          // GIVEN
          final startTime = DateTime(2024, 1, 1, 10);
          final endTime = DateTime(2024, 1, 1, 11);

          // WHEN
          final result = formatTimeRange(
            startTime: startTime,
            endTime: endTime,
          );

          // THEN
          expect(
            result,
            equals('2024-01-01T10:00:00.000 to 2024-01-01T11:00:00.000'),
          );
        },
      );

      test(
        'GIVEN start and end times that are the same → '
        'WHEN formatTimeRange is called → '
        'THEN returns formatted string with identical times',
        () {
          // GIVEN
          final time = DateTime(2024, 6, 15, 14, 30);

          // WHEN
          final result = formatTimeRange(
            startTime: time,
            endTime: time,
          );

          // THEN
          expect(
            result,
            equals('2024-06-15T14:30:00.000 to 2024-06-15T14:30:00.000'),
          );
        },
      );

      test(
        'GIVEN UTC DateTime instances → '
        'WHEN formatTimeRange is called → '
        'THEN returns formatted string with Z suffix',
        () {
          // GIVEN
          final startTime = DateTime.utc(2024, 3, 20, 8);
          final endTime = DateTime.utc(2024, 3, 20, 9);

          // WHEN
          final result = formatTimeRange(
            startTime: startTime,
            endTime: endTime,
          );

          // THEN
          expect(
            result,
            equals('2024-03-20T08:00:00.000Z to 2024-03-20T09:00:00.000Z'),
          );
        },
      );

      test(
        'GIVEN DateTime instances with milliseconds → '
        'WHEN formatTimeRange is called → '
        'THEN returns formatted string with millisecond precision',
        () {
          // GIVEN
          final startTime = DateTime(2024, 7, 4, 12, 0, 0, 123);
          final endTime = DateTime(2024, 7, 4, 13, 0, 0, 456);

          // WHEN
          final result = formatTimeRange(
            startTime: startTime,
            endTime: endTime,
          );

          // THEN
          expect(
            result,
            equals('2024-07-04T12:00:00.123 to 2024-07-04T13:00:00.456'),
          );
        },
      );

      test(
        'GIVEN DateTime instances with microseconds → '
        'WHEN formatTimeRange is called → '
        'THEN returns formatted string with microsecond precision',
        () {
          // GIVEN
          final startTime = DateTime(2024, 7, 4, 12, 0, 0, 123, 789);
          final endTime = DateTime(2024, 7, 4, 13, 0, 0, 456, 321);

          // WHEN
          final result = formatTimeRange(
            startTime: startTime,
            endTime: endTime,
          );

          // THEN
          expect(
            result,
            contains('2024-07-04T12:00:00.123789 to'),
          );
          expect(
            result,
            contains('2024-07-04T13:00:00.456321'),
          );
        },
      );

      test(
        'GIVEN very old DateTime instances → '
        'WHEN formatTimeRange is called → '
        'THEN returns correctly formatted string',
        () {
          // GIVEN
          final startTime = DateTime(1900);
          final endTime = DateTime(1900, 1, 1, 1);

          // WHEN
          final result = formatTimeRange(
            startTime: startTime,
            endTime: endTime,
          );

          // THEN
          expect(
            result,
            equals('1900-01-01T00:00:00.000 to 1900-01-01T01:00:00.000'),
          );
        },
      );

      test(
        'GIVEN far future DateTime instances → '
        'WHEN formatTimeRange is called → '
        'THEN returns correctly formatted string',
        () {
          // GIVEN
          final startTime = DateTime(2099, 12, 31, 23);
          final endTime = DateTime(2100);

          // WHEN
          final result = formatTimeRange(
            startTime: startTime,
            endTime: endTime,
          );

          // THEN
          expect(
            result,
            equals('2099-12-31T23:00:00.000 to 2100-01-01T00:00:00.000'),
          );
        },
      );

      test(
        'GIVEN DateTime instances spanning multiple days → '
        'WHEN formatTimeRange is called → '
        'THEN returns correctly formatted string',
        () {
          // GIVEN
          final startTime = DateTime(2024, 5, 10, 18);
          final endTime = DateTime(2024, 5, 15, 9, 30);

          // WHEN
          final result = formatTimeRange(
            startTime: startTime,
            endTime: endTime,
          );

          // THEN
          expect(
            result,
            equals('2024-05-10T18:00:00.000 to 2024-05-15T09:30:00.000'),
          );
        },
      );
    },
  );
}
