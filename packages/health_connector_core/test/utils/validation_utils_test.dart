import 'package:health_connector_core/src/utils/validation_utils.dart';
import 'package:test/test.dart';

void main() {
  group(
    'require',
    () {
      test(
        'GIVEN a true condition → '
        'WHEN require is called → '
        'THEN does not throw',
        () {
          // GIVEN & WHEN & THEN
          expect(
            () => require(
              condition: true,
              value: true,
              name: 'condition',
              message: 'This should not throw',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'GIVEN a false condition → '
        'WHEN require is called → '
        'THEN throws ArgumentError',
        () {
          // GIVEN & WHEN & THEN
          expect(
            () => require(
              condition: false,
              value: false,
              name: 'condition',
              message: 'This should throw',
            ),
            throwsArgumentError,
          );
        },
      );

      test(
        'GIVEN a false condition with custom message → '
        'WHEN require is called → '
        'THEN throws ArgumentError with the custom message',
        () {
          // GIVEN
          const customMessage = 'Custom error message';

          // WHEN & THEN
          expect(
            () => require(
              condition: false,
              value: customMessage,
              name: 'message',
              message: customMessage,
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                equals(customMessage),
              ),
            ),
          );
        },
      );

      test(
        'GIVEN a complex boolean expression that is true → '
        'WHEN require is called → '
        'THEN does not throw',
        () {
          // GIVEN
          const value = 10;

          // WHEN & THEN
          expect(
            () => require(
              condition: value > 5 && value < 15,
              value: value,
              name: 'value',
              message: 'Value out of range',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'GIVEN a complex boolean expression that is false → '
        'WHEN require is called → '
        'THEN throws ArgumentError',
        () {
          // GIVEN
          const value = 20;

          // WHEN & THEN
          expect(
            () => require(
              condition: value > 5 && value < 15,
              value: value,
              name: 'value',
              message: 'Value out of range',
            ),
            throwsArgumentError,
          );
        },
      );
    },
  );

  group(
    'requireEndTimeAfterStartTime',
    () {
      test(
        'GIVEN end time is after start time → '
        'WHEN requireEndTimeAfterStartTime is called → '
        'THEN does not throw',
        () {
          // GIVEN
          final startTime = DateTime(2024, 1, 1, 10);
          final endTime = DateTime(2024, 1, 1, 11);

          // WHEN & THEN
          expect(
            () => requireEndTimeAfterStartTime(
              startTime: startTime,
              endTime: endTime,
            ),
            returnsNormally,
          );
        },
      );

      test(
        'GIVEN end time is the same as start time → '
        'WHEN requireEndTimeAfterStartTime is called → '
        'THEN throws ArgumentError',
        () {
          // GIVEN
          final time = DateTime(2024, 1, 1, 10);

          // WHEN & THEN
          expect(
            () => requireEndTimeAfterStartTime(
              startTime: time,
              endTime: time,
            ),
            throwsArgumentError,
          );
        },
      );

      test(
        'GIVEN end time is before start time → '
        'WHEN requireEndTimeAfterStartTime is called → '
        'THEN throws ArgumentError',
        () {
          // GIVEN
          final startTime = DateTime(2024, 1, 1, 11);
          final endTime = DateTime(2024, 1, 1, 10);

          // WHEN & THEN
          expect(
            () => requireEndTimeAfterStartTime(
              startTime: startTime,
              endTime: endTime,
            ),
            throwsArgumentError,
          );
        },
      );

      test(
        'GIVEN end time is 1 millisecond after start time → '
        'WHEN requireEndTimeAfterStartTime is called → '
        'THEN does not throw',
        () {
          // GIVEN
          final startTime = DateTime(2024, 1, 1, 10);
          final endTime = DateTime(2024, 1, 1, 10, 0, 0, 1);

          // WHEN & THEN
          expect(
            () => requireEndTimeAfterStartTime(
              startTime: startTime,
              endTime: endTime,
            ),
            returnsNormally,
          );
        },
      );

      test(
        'GIVEN a large time difference → '
        'WHEN requireEndTimeAfterStartTime is called → '
        'THEN does not throw',
        () {
          // GIVEN
          final startTime = DateTime(2020);
          final endTime = DateTime(2024, 12, 31, 23, 59, 59);

          // WHEN & THEN
          expect(
            () => requireEndTimeAfterStartTime(
              startTime: startTime,
              endTime: endTime,
            ),
            returnsNormally,
          );
        },
      );

      test(
        'GIVEN invalid time range → '
        'WHEN requireEndTimeAfterStartTime is called → '
        'THEN error message includes both times',
        () {
          // GIVEN
          final startTime = DateTime(2024, 1, 1, 11);
          final endTime = DateTime(2024, 1, 1, 10);

          // WHEN & THEN
          expect(
            () => requireEndTimeAfterStartTime(
              startTime: startTime,
              endTime: endTime,
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                allOf([
                  contains('endTime must be after startTime'),
                  contains('startTime='),
                  contains('endTime='),
                ]),
              ),
            ),
          );
        },
      );
    },
  );
}
