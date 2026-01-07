import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Velocity',
    () {
      group(
        'metersPerSecond constructor',
        () {
          test(
            'creates velocity from valid meters per second value',
            () {
              const velocity = Velocity.metersPerSecond(2.78);
              expect(velocity.inMetersPerSecond, 2.78);
            },
          );
        },
      );

      group(
        'kilometersPerHour constructor',
        () {
          test(
            'creates velocity from valid kilometers per hour value',
            () {
              const velocity = Velocity.kilometersPerHour(10);
              expect(velocity.inMetersPerSecond, closeTo(2.78, 0.01));
            },
          );

          test(
            'converts kilometers per hour to meters per second correctly',
            () {
              const velocity = Velocity.kilometersPerHour(36);
              expect(velocity.inMetersPerSecond, 10);
              expect(velocity.inKilometersPerHour, 36);
            },
          );
        },
      );

      group(
        'milesPerHour constructor',
        () {
          test(
            'creates velocity from valid miles per hour value',
            () {
              const velocity = Velocity.milesPerHour(6.21);
              expect(velocity.inMetersPerSecond, closeTo(2.78, 0.1));
            },
          );

          test(
            'converts miles per hour to meters per second correctly',
            () {
              const velocity = Velocity.milesPerHour(10);
              expect(velocity.inMetersPerSecond, closeTo(4.47, 0.01));
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
              expect(Velocity.zero.inMetersPerSecond, 0);
              expect(Velocity.zero.inKilometersPerHour, 0);
              expect(Velocity.zero.inMilesPerHour, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inMetersPerSecond returns velocity in meters per second',
            () {
              const velocity = Velocity.metersPerSecond(2.78);
              expect(velocity.inMetersPerSecond, 2.78);
            },
          );

          test(
            'inKilometersPerHour returns velocity in kilometers per hour',
            () {
              const velocity = Velocity.metersPerSecond(2.78);
              expect(velocity.inKilometersPerHour, closeTo(10.0, 0.1));
            },
          );

          test(
            'inMilesPerHour returns velocity in miles per hour',
            () {
              const velocity = Velocity.metersPerSecond(2.78);
              expect(velocity.inMilesPerHour, closeTo(6.21, 0.1));
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines velocities',
            () {
              const v1 = Velocity.metersPerSecond(1.5);
              const v2 = Velocity.metersPerSecond(1.28);
              final result = v1 + v2;

              expect(result.inMetersPerSecond, closeTo(2.78, 0.01));
            },
          );

          test(
            'subtraction operator subtracts velocities',
            () {
              const v1 = Velocity.metersPerSecond(5.0);
              const v2 = Velocity.metersPerSecond(2.22);
              final result = v1 - v2;

              expect(result.inMetersPerSecond, 2.78);
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
              const v1 = Velocity.metersPerSecond(5);
              const v2 = Velocity.metersPerSecond(3);

              expect(v1 > v2, isTrue);
              expect(v2 > v1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const v1 = Velocity.metersPerSecond(2);
              const v2 = Velocity.metersPerSecond(4);

              expect(v1 < v2, isTrue);
              expect(v2 < v1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const v1 = Velocity.metersPerSecond(2.78);
              const v2 = Velocity.metersPerSecond(2.78);
              const v3 = Velocity.metersPerSecond(2.0);

              expect(v1 >= v2, isTrue);
              expect(v1 >= v3, isTrue);
              expect(v3 >= v1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const v1 = Velocity.metersPerSecond(2.78);
              const v2 = Velocity.metersPerSecond(2.78);
              const v3 = Velocity.metersPerSecond(3.5);

              expect(v1 <= v2, isTrue);
              expect(v1 <= v3, isTrue);
              expect(v3 <= v1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal velocities are equal',
            () {
              const v1 = Velocity.metersPerSecond(2.78);
              const v2 = Velocity.metersPerSecond(2.78);

              expect(v1, equals(v2));
            },
          );

          test(
            'velocities within tolerance are equal',
            () {
              const v1 = Velocity.metersPerSecond(2.780);
              const v2 = Velocity.metersPerSecond(2.785);

              expect(v1, equals(v2));
            },
          );

          test(
            'velocities outside tolerance are not equal',
            () {
              const v1 = Velocity.metersPerSecond(2.78);
              const v2 = Velocity.metersPerSecond(2.9);

              expect(v1, isNot(equals(v2)));
            },
          );

          test(
            'different velocities are not equal',
            () {
              const v1 = Velocity.metersPerSecond(2.78);
              const v2 = Velocity.metersPerSecond(3.5);

              expect(v1, isNot(equals(v2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const v = Velocity.metersPerSecond(2.78);

              expect(v, equals(v));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal velocities have same hash code',
            () {
              const v1 = Velocity.metersPerSecond(2.78);
              const v2 = Velocity.metersPerSecond(2.78);

              expect(v1.hashCode, equals(v2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal velocities',
            () {
              const v1 = Velocity.metersPerSecond(2.78);
              const v2 = Velocity.metersPerSecond(2.78);

              expect(v1.compareTo(v2), 0);
            },
          );

          test(
            'returns negative for smaller velocity',
            () {
              const v1 = Velocity.metersPerSecond(2);
              const v2 = Velocity.metersPerSecond(4);

              expect(v1.compareTo(v2), lessThan(0));
            },
          );

          test(
            'returns positive for larger velocity',
            () {
              const v1 = Velocity.metersPerSecond(5);
              const v2 = Velocity.metersPerSecond(3);

              expect(v1.compareTo(v2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats velocity with two decimal places',
            () {
              const velocity = Velocity.metersPerSecond(2.78);
              expect(velocity.toString(), '2.78 m/s');
            },
          );

          test(
            'formats zero velocity',
            () {
              expect(Velocity.zero.toString(), '0.00 m/s');
            },
          );
        },
      );
    },
  );
}
