import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Energy',
    () {
      group(
        'kilocalories constructor',
        () {
          test(
            'creates energy from valid kilocalories value',
            () {
              const energy = Energy.kilocalories(2000);
              expect(energy.inKilocalories, 2000);
            },
          );
        },
      );

      group(
        'calories constructor',
        () {
          test(
            'creates energy from valid calories value',
            () {
              const energy = Energy.calories(2000000);
              expect(energy.inKilocalories, 2000);
            },
          );

          test(
            'converts calories to kilocalories correctly',
            () {
              const energy = Energy.calories(1000);
              expect(energy.inKilocalories, 1.0);
              expect(energy.inCalories, 1000.0);
            },
          );
        },
      );

      group(
        'kilojoules constructor',
        () {
          test(
            'creates energy from valid kilojoules value',
            () {
              const energy = Energy.kilojoules(8368);
              expect(energy.inKilocalories, closeTo(2000, 1));
            },
          );

          test(
            'converts kilojoules to kilocalories correctly',
            () {
              const energy = Energy.kilojoules(4184);
              expect(energy.inKilocalories, closeTo(1000, 1));
            },
          );
        },
      );

      group(
        'joules constructor',
        () {
          test(
            'creates energy from valid joules value',
            () {
              const energy = Energy.joules(8368000);
              expect(energy.inKilocalories, closeTo(2000, 1));
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
              expect(Energy.zero.inKilocalories, 0);
              expect(Energy.zero.inCalories, 0);
              expect(Energy.zero.inKilojoules, 0);
              expect(Energy.zero.inJoules, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inKilocalories returns energy in kilocalories',
            () {
              const energy = Energy.kilocalories(2000);
              expect(energy.inKilocalories, 2000);
            },
          );

          test(
            'inCalories returns energy in calories',
            () {
              const energy = Energy.kilocalories(2000);
              expect(energy.inCalories, 2000000);
            },
          );

          test(
            'inKilojoules returns energy in kilojoules',
            () {
              const energy = Energy.kilocalories(2000);
              expect(energy.inKilojoules, closeTo(8368, 1));
            },
          );

          test(
            'inJoules returns energy in joules',
            () {
              const energy = Energy.kilocalories(2000);
              expect(energy.inJoules, closeTo(8368000, 1000));
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines energies',
            () {
              const e1 = Energy.kilocalories(1500);
              const e2 = Energy.kilocalories(500);
              final result = e1 + e2;

              expect(result.inKilocalories, 2000);
            },
          );

          test(
            'subtraction operator subtracts energies',
            () {
              const e1 = Energy.kilocalories(2500);
              const e2 = Energy.kilocalories(500);
              final result = e1 - e2;

              expect(result.inKilocalories, 2000);
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
              const e1 = Energy.kilocalories(2500);
              const e2 = Energy.kilocalories(2000);

              expect(e1 > e2, isTrue);
              expect(e2 > e1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const e1 = Energy.kilocalories(1500);
              const e2 = Energy.kilocalories(2000);

              expect(e1 < e2, isTrue);
              expect(e2 < e1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const e1 = Energy.kilocalories(2000);
              const e2 = Energy.kilocalories(2000);
              const e3 = Energy.kilocalories(1500);

              expect(e1 >= e2, isTrue);
              expect(e1 >= e3, isTrue);
              expect(e3 >= e1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const e1 = Energy.kilocalories(2000);
              const e2 = Energy.kilocalories(2000);
              const e3 = Energy.kilocalories(2500);

              expect(e1 <= e2, isTrue);
              expect(e1 <= e3, isTrue);
              expect(e3 <= e1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal energies are equal',
            () {
              const e1 = Energy.kilocalories(2000);
              const e2 = Energy.kilocalories(2000);

              expect(e1, equals(e2));
            },
          );

          test(
            'energies within tolerance are equal',
            () {
              const e1 = Energy.kilocalories(2000.00);
              const e2 = Energy.kilocalories(2000.005);

              expect(e1, equals(e2));
            },
          );

          test(
            'energies outside tolerance are not equal',
            () {
              const e1 = Energy.kilocalories(2000.0);
              const e2 = Energy.kilocalories(2000.1);

              expect(e1, isNot(equals(e2)));
            },
          );

          test(
            'different energies are not equal',
            () {
              const e1 = Energy.kilocalories(2000);
              const e2 = Energy.kilocalories(2500);

              expect(e1, isNot(equals(e2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const e = Energy.kilocalories(2000);

              expect(e, equals(e));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal energies have same hash code',
            () {
              const e1 = Energy.kilocalories(2000);
              const e2 = Energy.kilocalories(2000);

              expect(e1.hashCode, equals(e2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal energies',
            () {
              const e1 = Energy.kilocalories(2000);
              const e2 = Energy.kilocalories(2000);

              expect(e1.compareTo(e2), 0);
            },
          );

          test(
            'returns negative for smaller energy',
            () {
              const e1 = Energy.kilocalories(1500);
              const e2 = Energy.kilocalories(2000);

              expect(e1.compareTo(e2), lessThan(0));
            },
          );

          test(
            'returns positive for larger energy',
            () {
              const e1 = Energy.kilocalories(2500);
              const e2 = Energy.kilocalories(2000);

              expect(e1.compareTo(e2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats energy with three decimal places',
            () {
              const energy = Energy.kilocalories(2000);
              expect(energy.toString(), '2000.000 kcal');
            },
          );

          test(
            'formats zero energy',
            () {
              expect(Energy.zero.toString(), '0.000 kcal');
            },
          );
        },
      );
    },
  );
}
