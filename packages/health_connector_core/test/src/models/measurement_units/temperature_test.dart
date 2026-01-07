import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Temperature',
    () {
      group(
        'celsius constructor',
        () {
          test(
            'creates temperature from valid celsius value',
            () {
              const temp = Temperature.celsius(36.5);
              expect(temp.inCelsius, 36.5);
            },
          );
        },
      );

      group(
        'fahrenheit constructor',
        () {
          test(
            'creates temperature from valid fahrenheit value',
            () {
              const temp = Temperature.fahrenheit(97.7);
              expect(temp.inCelsius, closeTo(36.5, 0.1));
            },
          );

          test(
            'converts fahrenheit to celsius correctly',
            () {
              const temp = Temperature.fahrenheit(98.6);
              expect(temp.inCelsius, closeTo(37.0, 0.1));
              expect(temp.inFahrenheit, closeTo(98.6, 0.1));
            },
          );
        },
      );

      group(
        'kelvin constructor',
        () {
          test(
            'creates temperature from valid kelvin value',
            () {
              const temp = Temperature.kelvin(309.65);
              expect(temp.inCelsius, closeTo(36.5, 0.1));
            },
          );
        },
      );

      group(
        'zero constant',
        () {
          test(
            'has zero celsius value',
            () {
              expect(Temperature.zero.inCelsius, 0);
              expect(Temperature.zero.inFahrenheit, closeTo(32, 0.01));
              expect(Temperature.zero.inKelvin, closeTo(273.15, 0.01));
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inCelsius returns temperature in celsius',
            () {
              const temp = Temperature.celsius(37);
              expect(temp.inCelsius, 37);
            },
          );

          test(
            'inFahrenheit returns temperature in fahrenheit',
            () {
              const temp = Temperature.celsius(37);
              expect(temp.inFahrenheit, closeTo(98.6, 0.1));
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines temperatures',
            () {
              const t1 = Temperature.celsius(20);
              const t2 = Temperature.celsius(16.5);
              final result = t1 + t2;

              expect(result.inCelsius, 36.5);
            },
          );

          test(
            'subtraction operator subtracts temperatures',
            () {
              const t1 = Temperature.celsius(40);
              const t2 = Temperature.celsius(3.5);
              final result = t1 - t2;

              expect(result.inCelsius, 36.5);
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
              const t1 = Temperature.celsius(38);
              const t2 = Temperature.celsius(36);

              expect(t1 > t2, isTrue);
              expect(t2 > t1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const t1 = Temperature.celsius(35);
              const t2 = Temperature.celsius(37);

              expect(t1 < t2, isTrue);
              expect(t2 < t1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const t1 = Temperature.celsius(36.5);
              const t2 = Temperature.celsius(36.5);
              const t3 = Temperature.celsius(35);

              expect(t1 >= t2, isTrue);
              expect(t1 >= t3, isTrue);
              expect(t3 >= t1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const t1 = Temperature.celsius(36.5);
              const t2 = Temperature.celsius(36.5);
              const t3 = Temperature.celsius(38);

              expect(t1 <= t2, isTrue);
              expect(t1 <= t3, isTrue);
              expect(t3 <= t1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal temperatures are equal',
            () {
              const t1 = Temperature.celsius(36.5);
              const t2 = Temperature.celsius(36.5);

              expect(t1, equals(t2));
            },
          );

          test(
            'temperatures within tolerance are equal',
            () {
              const t1 = Temperature.celsius(36.50);
              const t2 = Temperature.celsius(36.505);

              expect(t1, equals(t2));
            },
          );

          test(
            'temperatures outside tolerance are not equal',
            () {
              const t1 = Temperature.celsius(36.5);
              const t2 = Temperature.celsius(36.6);

              expect(t1, isNot(equals(t2)));
            },
          );

          test(
            'different temperatures are not equal',
            () {
              const t1 = Temperature.celsius(36);
              const t2 = Temperature.celsius(37);

              expect(t1, isNot(equals(t2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const t = Temperature.celsius(36.5);

              expect(t, equals(t));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal temperatures have same hash code',
            () {
              const t1 = Temperature.celsius(36.5);
              const t2 = Temperature.celsius(36.5);

              expect(t1.hashCode, equals(t2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal temperatures',
            () {
              const t1 = Temperature.celsius(36.5);
              const t2 = Temperature.celsius(36.5);

              expect(t1.compareTo(t2), 0);
            },
          );

          test(
            'returns negative for smaller temperature',
            () {
              const t1 = Temperature.celsius(35);
              const t2 = Temperature.celsius(37);

              expect(t1.compareTo(t2), lessThan(0));
            },
          );

          test(
            'returns positive for larger temperature',
            () {
              const t1 = Temperature.celsius(38);
              const t2 = Temperature.celsius(36);

              expect(t1.compareTo(t2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats temperature with two decimal places',
            () {
              const temp = Temperature.celsius(36.5);
              expect(temp.toString(), '36.50 °C');
            },
          );

          test(
            'formats zero temperature',
            () {
              expect(Temperature.zero.toString(), '0.00 °C');
            },
          );
        },
      );
    },
  );
}
