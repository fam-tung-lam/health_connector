import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Number',
    () {
      group(
        'constructor',
        () {
          test(
            'creates number from valid value',
            () {
              const number = Number(42);
              expect(number.value, 42);
            },
          );

          test(
            'creates number from decimal value',
            () {
              const number = Number(123.45);
              expect(number.value, 123.45);
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
              expect(Number.zero.value, 0);
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines numbers',
            () {
              const num1 = Number(10);
              const num2 = Number(32);
              final result = num1 + num2;

              expect(result.value, 42);
            },
          );

          test(
            'subtraction operator subtracts numbers',
            () {
              const num1 = Number(50);
              const num2 = Number(8);
              final result = num1 - num2;

              expect(result.value, 42);
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
              const num1 = Number(100);
              const num2 = Number(50);

              expect(num1 > num2, isTrue);
              expect(num2 > num1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const num1 = Number(50);
              const num2 = Number(100);

              expect(num1 < num2, isTrue);
              expect(num2 < num1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const num1 = Number(100);
              const num2 = Number(100);
              const num3 = Number(50);

              expect(num1 >= num2, isTrue);
              expect(num1 >= num3, isTrue);
              expect(num3 >= num1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const num1 = Number(100);
              const num2 = Number(100);
              const num3 = Number(150);

              expect(num1 <= num2, isTrue);
              expect(num1 <= num3, isTrue);
              expect(num3 <= num1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal numbers are equal',
            () {
              const num1 = Number(42);
              const num2 = Number(42);

              expect(num1, equals(num2));
            },
          );

          test(
            'different numbers are not equal',
            () {
              const num1 = Number(42);
              const num2 = Number(43);

              expect(num1, isNot(equals(num2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const num = Number(42);

              expect(num, equals(num));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal numbers have same hash code',
            () {
              const num1 = Number(42);
              const num2 = Number(42);

              expect(num1.hashCode, equals(num2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal numbers',
            () {
              const num1 = Number(42);
              const num2 = Number(42);

              expect(num1.compareTo(num2), 0);
            },
          );

          test(
            'returns negative for smaller number',
            () {
              const num1 = Number(10);
              const num2 = Number(20);

              expect(num1.compareTo(num2), lessThan(0));
            },
          );

          test(
            'returns positive for larger number',
            () {
              const num1 = Number(20);
              const num2 = Number(10);

              expect(num1.compareTo(num2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats integer number',
            () {
              const number = Number(42);
              expect(number.toString(), '42');
            },
          );

          test(
            'formats decimal number',
            () {
              const number = Number(42.5);
              expect(number.toString(), '42.5');
            },
          );

          test(
            'formats zero number',
            () {
              expect(Number.zero.toString(), '0');
            },
          );
        },
      );
    },
  );
}
