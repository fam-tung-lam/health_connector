import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'TimeDuration',
    () {
      group(
        'seconds constructor',
        () {
          test(
            'creates duration from valid seconds value',
            () {
              const duration = TimeDuration.seconds(3600);
              expect(duration.inSeconds, 3600);
            },
          );
        },
      );

      group(
        'minutes constructor',
        () {
          test(
            'creates duration from valid minutes value',
            () {
              const duration = TimeDuration.minutes(60);
              expect(duration.inSeconds, 3600);
            },
          );

          test(
            'converts minutes to seconds correctly',
            () {
              const duration = TimeDuration.minutes(30);
              expect(duration.inSeconds, 1800);
              expect(duration.inMinutes, 30);
            },
          );
        },
      );

      group(
        'hours constructor',
        () {
          test(
            'creates duration from valid hours value',
            () {
              const duration = TimeDuration.hours(8);
              expect(duration.inHours, 8);
            },
          );

          test(
            'converts hours to seconds correctly',
            () {
              const duration = TimeDuration.hours(2);
              expect(duration.inSeconds, 7200);
              expect(duration.inMinutes, 120);
            },
          );
        },
      );

      group(
        'fromDuration constructor',
        () {
          test(
            'creates duration from Dart Duration',
            () {
              final duration = TimeDuration.fromDuration(
                const Duration(hours: 8),
              );
              expect(duration.inHours, 8);
            },
          );

          test(
            'converts Dart Duration correctly',
            () {
              final duration = TimeDuration.fromDuration(
                const Duration(minutes: 90),
              );
              expect(duration.inMinutes, 90);
              expect(duration.inHours, 1.5);
            },
          );
        },
      );

      group(
        'zero constant',
        () {
          test(
            'has zero value',
            () {
              expect(TimeDuration.zero.inSeconds, 0);
              expect(TimeDuration.zero.inMinutes, 0);
              expect(TimeDuration.zero.inHours, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inSeconds returns duration in seconds',
            () {
              const duration = TimeDuration.hours(1);
              expect(duration.inSeconds, 3600);
            },
          );

          test(
            'inMinutes returns duration in minutes',
            () {
              const duration = TimeDuration.hours(1);
              expect(duration.inMinutes, 60);
            },
          );

          test(
            'inHours returns duration in hours',
            () {
              const duration = TimeDuration.minutes(120);
              expect(duration.inHours, 2);
            },
          );
        },
      );

      group(
        'toDuration',
        () {
          test(
            'converts to Dart Duration correctly',
            () {
              const timeDuration = TimeDuration.hours(8);
              final duration = timeDuration.toDuration();

              expect(duration.inHours, 8);
            },
          );

          test(
            'round-trip conversion maintains value',
            () {
              const originalDuration = Duration(hours: 8, minutes: 30);
              final timeDuration = TimeDuration.fromDuration(originalDuration);
              final convertedDuration = timeDuration.toDuration();

              expect(convertedDuration.inMinutes, originalDuration.inMinutes);
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines durations',
            () {
              const d1 = TimeDuration.hours(2);
              const d2 = TimeDuration.minutes(30);
              final result = d1 + d2;

              expect(result.inHours, 2.5);
            },
          );

          test(
            'subtraction operator subtracts durations',
            () {
              const d1 = TimeDuration.hours(3);
              const d2 = TimeDuration.minutes(30);
              final result = d1 - d2;

              expect(result.inHours, 2.5);
            },
          );
        },
      );

      group(
        'comparison operators',
        () {
          test(
            'greater than operator compares correctly',
            () {
              const d1 = TimeDuration.hours(3);
              const d2 = TimeDuration.hours(2);

              expect(d1 > d2, isTrue);
              expect(d2 > d1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const d1 = TimeDuration.hours(1);
              const d2 = TimeDuration.hours(2);

              expect(d1 < d2, isTrue);
              expect(d2 < d1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const d1 = TimeDuration.hours(2);
              const d2 = TimeDuration.hours(2);
              const d3 = TimeDuration.hours(1);

              expect(d1 >= d2, isTrue);
              expect(d1 >= d3, isTrue);
              expect(d3 >= d1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const d1 = TimeDuration.hours(2);
              const d2 = TimeDuration.hours(2);
              const d3 = TimeDuration.hours(3);

              expect(d1 <= d2, isTrue);
              expect(d1 <= d3, isTrue);
              expect(d3 <= d1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal durations are equal',
            () {
              const d1 = TimeDuration.hours(2);
              const d2 = TimeDuration.hours(2);

              expect(d1, equals(d2));
            },
          );

          test(
            'durations within tolerance are equal',
            () {
              const d1 = TimeDuration.seconds(3600.0000);
              const d2 = TimeDuration.seconds(3600.0005);

              expect(d1, equals(d2));
            },
          );

          test(
            'durations outside tolerance are not equal',
            () {
              const d1 = TimeDuration.seconds(3600.0);
              const d2 = TimeDuration.seconds(3600.01);

              expect(d1, isNot(equals(d2)));
            },
          );

          test(
            'different durations are not equal',
            () {
              const d1 = TimeDuration.hours(2);
              const d2 = TimeDuration.hours(3);

              expect(d1, isNot(equals(d2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const d = TimeDuration.hours(2);

              expect(d, equals(d));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal durations have same hash code',
            () {
              const d1 = TimeDuration.hours(2);
              const d2 = TimeDuration.hours(2);

              expect(d1.hashCode, equals(d2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal durations',
            () {
              const d1 = TimeDuration.hours(2);
              const d2 = TimeDuration.hours(2);

              expect(d1.compareTo(d2), 0);
            },
          );

          test(
            'returns negative for smaller duration',
            () {
              const d1 = TimeDuration.hours(1);
              const d2 = TimeDuration.hours(2);

              expect(d1.compareTo(d2), lessThan(0));
            },
          );

          test(
            'returns positive for larger duration',
            () {
              const d1 = TimeDuration.hours(3);
              const d2 = TimeDuration.hours(2);

              expect(d1.compareTo(d2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats duration with three decimal places',
            () {
              const duration = TimeDuration.hours(1);
              expect(duration.toString(), '3600.000 s');
            },
          );

          test(
            'formats zero duration',
            () {
              expect(TimeDuration.zero.toString(), '0.000 s');
            },
          );
        },
      );
    },
  );
}
