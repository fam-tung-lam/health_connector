import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Power',
    () {
      group(
        'watts constructor',
        () {
          test(
            'creates power from valid watts value',
            () {
              const power = Power.watts(250);
              expect(power.inWatts, 250);
            },
          );
        },
      );

      group(
        'kilowatts constructor',
        () {
          test(
            'creates power from valid kilowatts value',
            () {
              const power = Power.kilowatts(0.25);
              expect(power.inWatts, 250);
            },
          );

          test(
            'converts kilowatts to watts correctly',
            () {
              const power = Power.kilowatts(1);
              expect(power.inWatts, 1000);
              expect(power.inKilowatts, 1);
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
              expect(Power.zero.inWatts, 0);
              expect(Power.zero.inKilowatts, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inWatts returns power in watts',
            () {
              const power = Power.watts(250);
              expect(power.inWatts, 250);
            },
          );

          test(
            'inKilowatts returns power in kilowatts',
            () {
              const power = Power.watts(250);
              expect(power.inKilowatts, 0.25);
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines powers',
            () {
              const p1 = Power.watts(150);
              const p2 = Power.watts(100);
              final result = p1 + p2;

              expect(result.inWatts, 250);
            },
          );

          test(
            'subtraction operator subtracts powers',
            () {
              const p1 = Power.watts(400);
              const p2 = Power.watts(150);
              final result = p1 - p2;

              expect(result.inWatts, 250);
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
              const p1 = Power.watts(300);
              const p2 = Power.watts(200);

              expect(p1 > p2, isTrue);
              expect(p2 > p1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const p1 = Power.watts(150);
              const p2 = Power.watts(250);

              expect(p1 < p2, isTrue);
              expect(p2 < p1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const p1 = Power.watts(250);
              const p2 = Power.watts(250);
              const p3 = Power.watts(150);

              expect(p1 >= p2, isTrue);
              expect(p1 >= p3, isTrue);
              expect(p3 >= p1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const p1 = Power.watts(250);
              const p2 = Power.watts(250);
              const p3 = Power.watts(300);

              expect(p1 <= p2, isTrue);
              expect(p1 <= p3, isTrue);
              expect(p3 <= p1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal powers are equal',
            () {
              const p1 = Power.watts(250);
              const p2 = Power.watts(250);

              expect(p1, equals(p2));
            },
          );

          test(
            'powers within tolerance are equal',
            () {
              const p1 = Power.watts(250.00);
              const p2 = Power.watts(250.05);

              expect(p1, equals(p2));
            },
          );

          test(
            'powers outside tolerance are not equal',
            () {
              const p1 = Power.watts(250.0);
              const p2 = Power.watts(250.2);

              expect(p1, isNot(equals(p2)));
            },
          );

          test(
            'different powers are not equal',
            () {
              const p1 = Power.watts(250);
              const p2 = Power.watts(300);

              expect(p1, isNot(equals(p2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const p = Power.watts(250);

              expect(p, equals(p));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal powers have same hash code',
            () {
              const p1 = Power.watts(250);
              const p2 = Power.watts(250);

              expect(p1.hashCode, equals(p2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal powers',
            () {
              const p1 = Power.watts(250);
              const p2 = Power.watts(250);

              expect(p1.compareTo(p2), 0);
            },
          );

          test(
            'returns negative for smaller power',
            () {
              const p1 = Power.watts(150);
              const p2 = Power.watts(250);

              expect(p1.compareTo(p2), lessThan(0));
            },
          );

          test(
            'returns positive for larger power',
            () {
              const p1 = Power.watts(300);
              const p2 = Power.watts(250);

              expect(p1.compareTo(p2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats power with one decimal place',
            () {
              const power = Power.watts(250);
              expect(power.toString(), '250.0 W');
            },
          );

          test(
            'formats zero power',
            () {
              expect(Power.zero.toString(), '0.0 W');
            },
          );
        },
      );
    },
  );
}
