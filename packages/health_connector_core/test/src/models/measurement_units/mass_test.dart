import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Mass',
    () {
      group(
        'kilograms constructor',
        () {
          test(
            'creates mass from valid kilograms value',
            () {
              const mass = Mass.kilograms(70.5);
              expect(mass.inKilograms, 70.5);
            },
          );
        },
      );

      group(
        'grams constructor',
        () {
          test(
            'creates mass from valid grams value',
            () {
              const mass = Mass.grams(70500);
              expect(mass.inKilograms, 70.5);
            },
          );

          test(
            'converts grams to kilograms correctly',
            () {
              const mass = Mass.grams(1000);
              expect(mass.inKilograms, 1.0);
              expect(mass.inGrams, 1000.0);
            },
          );
        },
      );

      group(
        'pounds constructor',
        () {
          test(
            'creates mass from valid pounds value',
            () {
              const mass = Mass.pounds(155.4);
              expect(mass.inKilograms, closeTo(70.5, 0.1));
            },
          );

          test(
            'converts pounds to kilograms correctly',
            () {
              const mass = Mass.pounds(220);
              expect(mass.inKilograms, closeTo(99.79, 0.1));
            },
          );
        },
      );

      group(
        'ounces constructor',
        () {
          test(
            'creates mass from valid ounces value',
            () {
              const mass = Mass.ounces(2487);
              expect(mass.inKilograms, closeTo(70.5, 0.1));
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
              expect(Mass.zero.inKilograms, 0);
              expect(Mass.zero.inGrams, 0);
              expect(Mass.zero.inPounds, 0);
              expect(Mass.zero.inOunces, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inKilograms returns mass in kilograms',
            () {
              const mass = Mass.kilograms(70.5);
              expect(mass.inKilograms, 70.5);
            },
          );

          test(
            'inGrams returns mass in grams',
            () {
              const mass = Mass.kilograms(70.5);
              expect(mass.inGrams, 70500.0);
            },
          );

          test(
            'inPounds returns mass in pounds',
            () {
              const mass = Mass.kilograms(70.5);
              expect(mass.inPounds, closeTo(155.42, 0.1));
            },
          );

          test(
            'inOunces returns mass in ounces',
            () {
              const mass = Mass.kilograms(70.5);
              expect(mass.inOunces, closeTo(2487, 1));
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines masses',
            () {
              const m1 = Mass.kilograms(50.0);
              const m2 = Mass.kilograms(20.5);
              final result = m1 + m2;

              expect(result.inKilograms, 70.5);
            },
          );

          test(
            'subtraction operator subtracts masses',
            () {
              const m1 = Mass.kilograms(100.0);
              const m2 = Mass.kilograms(29.5);
              final result = m1 - m2;

              expect(result.inKilograms, 70.5);
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
              const m1 = Mass.kilograms(80);
              const m2 = Mass.kilograms(60);

              expect(m1 > m2, isTrue);
              expect(m2 > m1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const m1 = Mass.kilograms(60);
              const m2 = Mass.kilograms(80);

              expect(m1 < m2, isTrue);
              expect(m2 < m1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const m1 = Mass.kilograms(70.5);
              const m2 = Mass.kilograms(70.5);
              const m3 = Mass.kilograms(60);

              expect(m1 >= m2, isTrue);
              expect(m1 >= m3, isTrue);
              expect(m3 >= m1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const m1 = Mass.kilograms(70.5);
              const m2 = Mass.kilograms(70.5);
              const m3 = Mass.kilograms(80);

              expect(m1 <= m2, isTrue);
              expect(m1 <= m3, isTrue);
              expect(m3 <= m1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal masses are equal',
            () {
              const m1 = Mass.kilograms(70.5);
              const m2 = Mass.kilograms(70.5);

              expect(m1, equals(m2));
            },
          );

          test(
            'masses within tolerance are equal',
            () {
              const m1 = Mass.kilograms(70.500);
              const m2 = Mass.kilograms(70.505);

              expect(m1, equals(m2));
            },
          );

          test(
            'masses outside tolerance are not equal',
            () {
              const m1 = Mass.kilograms(70.5);
              const m2 = Mass.kilograms(70.6);

              expect(m1, isNot(equals(m2)));
            },
          );

          test(
            'different masses are not equal',
            () {
              const m1 = Mass.kilograms(70.5);
              const m2 = Mass.kilograms(80.0);

              expect(m1, isNot(equals(m2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const m = Mass.kilograms(70.5);

              expect(m, equals(m));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal masses have same hash code',
            () {
              const m1 = Mass.kilograms(70.5);
              const m2 = Mass.kilograms(70.5);

              expect(m1.hashCode, equals(m2.hashCode));
            },
          );

          test(
            'masses within tolerance have same hash code',
            () {
              const m1 = Mass.kilograms(70.500);
              const m2 = Mass.kilograms(70.505);

              expect(m1.hashCode, equals(m2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal masses',
            () {
              const m1 = Mass.kilograms(70.5);
              const m2 = Mass.kilograms(70.5);

              expect(m1.compareTo(m2), 0);
            },
          );

          test(
            'returns negative for smaller mass',
            () {
              const m1 = Mass.kilograms(60);
              const m2 = Mass.kilograms(80);

              expect(m1.compareTo(m2), lessThan(0));
            },
          );

          test(
            'returns positive for larger mass',
            () {
              const m1 = Mass.kilograms(80);
              const m2 = Mass.kilograms(60);

              expect(m1.compareTo(m2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats mass with three decimal places',
            () {
              const mass = Mass.kilograms(70.5);
              expect(mass.toString(), '70.500 kg');
            },
          );

          test(
            'formats zero mass',
            () {
              expect(Mass.zero.toString(), '0.000 kg');
            },
          );
        },
      );
    },
  );
}
