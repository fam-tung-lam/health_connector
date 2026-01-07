import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Percentage',
    () {
      group(
        'fromDecimal constructor',
        () {
          test(
            'creates percentage from valid decimal value',
            () {
              const percentage = Percentage.fromDecimal(0.25);
              expect(percentage.asDecimal, 0.25);
              expect(percentage.asWhole, 25.0);
            },
          );
        },
      );

      group(
        'fromWhole constructor',
        () {
          test(
            'creates percentage from valid whole value',
            () {
              const percentage = Percentage.fromWhole(75);
              expect(percentage.asWhole, 75.0);
              expect(percentage.asDecimal, 0.75);
            },
          );

          test(
            'converts whole to decimal correctly',
            () {
              const percentage = Percentage.fromWhole(50);
              expect(percentage.asDecimal, 0.5);
            },
          );
        },
      );

      group(
        'constants',
        () {
          test(
            'zero constant has zero value',
            () {
              expect(Percentage.zero.asDecimal, 0.0);
              expect(Percentage.zero.asWhole, 0.0);
            },
          );

          test(
            'full constant has 100% value',
            () {
              expect(Percentage.full.asDecimal, 1.0);
              expect(Percentage.full.asWhole, 100.0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'asDecimal returns decimal value',
            () {
              const percentage = Percentage.fromWhole(25);
              expect(percentage.asDecimal, 0.25);
            },
          );

          test(
            'asWhole returns whole value',
            () {
              const percentage = Percentage.fromDecimal(0.63);
              expect(percentage.asWhole, 63.0);
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines percentages',
            () {
              const p1 = Percentage.fromWhole(15);
              const p2 = Percentage.fromWhole(10);
              final result = p1 + p2;

              expect(result.asWhole, 25.0);
            },
          );

          test(
            'subtraction operator subtracts percentages',
            () {
              const p1 = Percentage.fromWhole(50);
              const p2 = Percentage.fromWhole(25);
              final result = p1 - p2;

              expect(result.asWhole, 25.0);
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
              const p1 = Percentage.fromWhole(75);
              const p2 = Percentage.fromWhole(50);

              expect(p1 > p2, isTrue);
              expect(p2 > p1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const p1 = Percentage.fromWhole(25);
              const p2 = Percentage.fromWhole(75);

              expect(p1 < p2, isTrue);
              expect(p2 < p1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const p1 = Percentage.fromWhole(75);
              const p2 = Percentage.fromWhole(75);
              const p3 = Percentage.fromWhole(50);

              expect(p1 >= p2, isTrue);
              expect(p1 >= p3, isTrue);
              expect(p3 >= p1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const p1 = Percentage.fromWhole(50);
              const p2 = Percentage.fromWhole(50);
              const p3 = Percentage.fromWhole(75);

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
            'equal percentages are equal',
            () {
              const p1 = Percentage.fromWhole(75);
              const p2 = Percentage.fromWhole(75);

              expect(p1, equals(p2));
            },
          );

          test(
            'percentages within tolerance are equal',
            () {
              const p1 = Percentage.fromDecimal(0.75);
              const p2 = Percentage.fromDecimal(0.750001);

              expect(p1, equals(p2));
            },
          );

          test(
            'percentages outside tolerance are not equal',
            () {
              const p1 = Percentage.fromWhole(75.0);
              const p2 = Percentage.fromWhole(75.1);

              expect(p1, isNot(equals(p2)));
            },
          );

          test(
            'different percentages are not equal',
            () {
              const p1 = Percentage.fromWhole(75);
              const p2 = Percentage.fromWhole(50);

              expect(p1, isNot(equals(p2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const p = Percentage.fromWhole(75);

              expect(p, equals(p));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal percentages have same hash code',
            () {
              const p1 = Percentage.fromWhole(75);
              const p2 = Percentage.fromWhole(75);

              expect(p1.hashCode, equals(p2.hashCode));
            },
          );

          test(
            'percentages within tolerance have same hash code',
            () {
              const p1 = Percentage.fromDecimal(0.75);
              const p2 = Percentage.fromDecimal(0.750001);

              expect(p1.hashCode, equals(p2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal percentages',
            () {
              const p1 = Percentage.fromWhole(75);
              const p2 = Percentage.fromWhole(75);

              expect(p1.compareTo(p2), 0);
            },
          );

          test(
            'returns negative for smaller percentage',
            () {
              const p1 = Percentage.fromWhole(50);
              const p2 = Percentage.fromWhole(75);

              expect(p1.compareTo(p2), lessThan(0));
            },
          );

          test(
            'returns positive for larger percentage',
            () {
              const p1 = Percentage.fromWhole(75);
              const p2 = Percentage.fromWhole(50);

              expect(p1.compareTo(p2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats percentage with one decimal place',
            () {
              const percentage = Percentage.fromWhole(75);
              expect(percentage.toString(), '75.0%');
            },
          );

          test(
            'formats decimal percentage with one decimal place',
            () {
              const percentage = Percentage.fromDecimal(0.635);
              expect(percentage.toString(), '63.5%');
            },
          );

          test(
            'formats zero percentage',
            () {
              expect(Percentage.zero.toString(), '0.0%');
            },
          );

          test(
            'formats full percentage',
            () {
              expect(Percentage.full.toString(), '100.0%');
            },
          );
        },
      );
    },
  );
}
