import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'BloodGlucose',
    () {
      group(
        'millimolesPerLiter constructor',
        () {
          test(
            'creates blood glucose from valid millimoles per liter value',
            () {
              const glucose = BloodGlucose.millimolesPerLiter(5.5);
              expect(glucose.inMillimolesPerLiter, 5.5);
            },
          );
        },
      );

      group(
        'milligramsPerDeciliter constructor',
        () {
          test(
            'creates blood glucose from valid milligrams per deciliter value',
            () {
              const glucose = BloodGlucose.milligramsPerDeciliter(99);
              expect(glucose.inMillimolesPerLiter, closeTo(5.49, 0.01));
            },
          );

          test(
            'converts milligrams per deciliter to millimoles per '
            'liter correctly',
            () {
              const glucose = BloodGlucose.milligramsPerDeciliter(180);
              expect(glucose.inMillimolesPerLiter, closeTo(10.0, 0.1));
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
              expect(BloodGlucose.zero.inMillimolesPerLiter, 0);
              expect(BloodGlucose.zero.inMilligramsPerDeciliter, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inMillimolesPerLiter returns blood glucose in '
            'millimoles per liter',
            () {
              const glucose = BloodGlucose.millimolesPerLiter(5.5);
              expect(glucose.inMillimolesPerLiter, 5.5);
            },
          );

          test(
            'inMilligramsPerDeciliter returns blood glucose in '
            'milligrams per deciliter',
            () {
              const glucose = BloodGlucose.millimolesPerLiter(5.5);
              expect(glucose.inMilligramsPerDeciliter, closeTo(99.1, 0.1));
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines blood glucose values',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(3.0);
              const g2 = BloodGlucose.millimolesPerLiter(2.5);
              final result = g1 + g2;

              expect(result.inMillimolesPerLiter, 5.5);
            },
          );

          test(
            'subtraction operator subtracts blood glucose values',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(7.0);
              const g2 = BloodGlucose.millimolesPerLiter(1.5);
              final result = g1 - g2;

              expect(result.inMillimolesPerLiter, 5.5);
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
              const g1 = BloodGlucose.millimolesPerLiter(7.0);
              const g2 = BloodGlucose.millimolesPerLiter(5.0);

              expect(g1 > g2, isTrue);
              expect(g2 > g1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(4.0);
              const g2 = BloodGlucose.millimolesPerLiter(6.0);

              expect(g1 < g2, isTrue);
              expect(g2 < g1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(5.5);
              const g2 = BloodGlucose.millimolesPerLiter(5.5);
              const g3 = BloodGlucose.millimolesPerLiter(4.0);

              expect(g1 >= g2, isTrue);
              expect(g1 >= g3, isTrue);
              expect(g3 >= g1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(5.5);
              const g2 = BloodGlucose.millimolesPerLiter(5.5);
              const g3 = BloodGlucose.millimolesPerLiter(7.0);

              expect(g1 <= g2, isTrue);
              expect(g1 <= g3, isTrue);
              expect(g3 <= g1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal blood glucose values are equal',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(5.5);
              const g2 = BloodGlucose.millimolesPerLiter(5.5);

              expect(g1, equals(g2));
            },
          );

          test(
            'blood glucose values within tolerance are equal',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(5.50);
              const g2 = BloodGlucose.millimolesPerLiter(5.505);

              expect(g1, equals(g2));
            },
          );

          test(
            'blood glucose values outside tolerance are not equal',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(5.5);
              const g2 = BloodGlucose.millimolesPerLiter(5.6);

              expect(g1, isNot(equals(g2)));
            },
          );

          test(
            'different blood glucose values are not equal',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(5.5);
              const g2 = BloodGlucose.millimolesPerLiter(6.0);

              expect(g1, isNot(equals(g2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const g = BloodGlucose.millimolesPerLiter(5.5);

              expect(g, equals(g));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal blood glucose values have same hash code',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(5.5);
              const g2 = BloodGlucose.millimolesPerLiter(5.5);

              expect(g1.hashCode, equals(g2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal blood glucose values',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(5.5);
              const g2 = BloodGlucose.millimolesPerLiter(5.5);

              expect(g1.compareTo(g2), 0);
            },
          );

          test(
            'returns negative for smaller blood glucose',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(4.0);
              const g2 = BloodGlucose.millimolesPerLiter(6.0);

              expect(g1.compareTo(g2), lessThan(0));
            },
          );

          test(
            'returns positive for larger blood glucose',
            () {
              const g1 = BloodGlucose.millimolesPerLiter(7.0);
              const g2 = BloodGlucose.millimolesPerLiter(5.0);

              expect(g1.compareTo(g2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats blood glucose with two decimal places',
            () {
              const glucose = BloodGlucose.millimolesPerLiter(5.5);
              expect(glucose.toString(), '5.50 mmol/L');
            },
          );

          test(
            'formats zero blood glucose',
            () {
              expect(BloodGlucose.zero.toString(), '0.00 mmol/L');
            },
          );
        },
      );
    },
  );
}
