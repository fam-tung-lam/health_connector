import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Pressure',
    () {
      group(
        'millimetersOfMercury constructor',
        () {
          test(
            'creates pressure from valid millimeters of mercury value',
            () {
              const pressure = Pressure.millimetersOfMercury(120);
              expect(pressure.inMillimetersOfMercury, 120);
            },
          );
        },
      );

      group(
        'pascals constructor',
        () {
          test(
            'creates pressure from valid pascals value',
            () {
              const pressure = Pressure.pascals(15998.7);
              expect(pressure.inMillimetersOfMercury, closeTo(120, 1));
            },
          );

          test(
            'converts pascals to millimeters of mercury correctly',
            () {
              const pressure = Pressure.pascals(13332.2);
              expect(pressure.inMillimetersOfMercury, closeTo(100, 1));
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
              expect(Pressure.zero.inMillimetersOfMercury, 0);
              expect(Pressure.zero.inPascals, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inMillimetersOfMercury returns pressure in millimeters of mercury',
            () {
              const pressure = Pressure.millimetersOfMercury(120);
              expect(pressure.inMillimetersOfMercury, 120);
            },
          );

          test(
            'inPascals returns pressure in pascals',
            () {
              const pressure = Pressure.millimetersOfMercury(120);
              expect(pressure.inPascals, closeTo(15998.7, 1));
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines pressures',
            () {
              const p1 = Pressure.millimetersOfMercury(80);
              const p2 = Pressure.millimetersOfMercury(40);
              final result = p1 + p2;

              expect(result.inMillimetersOfMercury, 120);
            },
          );

          test(
            'subtraction operator subtracts pressures',
            () {
              const p1 = Pressure.millimetersOfMercury(150);
              const p2 = Pressure.millimetersOfMercury(30);
              final result = p1 - p2;

              expect(result.inMillimetersOfMercury, 120);
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
              const p1 = Pressure.millimetersOfMercury(130);
              const p2 = Pressure.millimetersOfMercury(110);

              expect(p1 > p2, isTrue);
              expect(p2 > p1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const p1 = Pressure.millimetersOfMercury(100);
              const p2 = Pressure.millimetersOfMercury(120);

              expect(p1 < p2, isTrue);
              expect(p2 < p1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const p1 = Pressure.millimetersOfMercury(120);
              const p2 = Pressure.millimetersOfMercury(120);
              const p3 = Pressure.millimetersOfMercury(100);

              expect(p1 >= p2, isTrue);
              expect(p1 >= p3, isTrue);
              expect(p3 >= p1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const p1 = Pressure.millimetersOfMercury(120);
              const p2 = Pressure.millimetersOfMercury(120);
              const p3 = Pressure.millimetersOfMercury(140);

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
            'equal pressures are equal',
            () {
              const p1 = Pressure.millimetersOfMercury(120);
              const p2 = Pressure.millimetersOfMercury(120);

              expect(p1, equals(p2));
            },
          );

          test(
            'pressures within tolerance are equal',
            () {
              const p1 = Pressure.millimetersOfMercury(120.00);
              const p2 = Pressure.millimetersOfMercury(120.05);

              expect(p1, equals(p2));
            },
          );

          test(
            'pressures outside tolerance are not equal',
            () {
              const p1 = Pressure.millimetersOfMercury(120.0);
              const p2 = Pressure.millimetersOfMercury(120.2);

              expect(p1, isNot(equals(p2)));
            },
          );

          test(
            'different pressures are not equal',
            () {
              const p1 = Pressure.millimetersOfMercury(120);
              const p2 = Pressure.millimetersOfMercury(130);

              expect(p1, isNot(equals(p2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const p = Pressure.millimetersOfMercury(120);

              expect(p, equals(p));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal pressures have same hash code',
            () {
              const p1 = Pressure.millimetersOfMercury(120);
              const p2 = Pressure.millimetersOfMercury(120);

              expect(p1.hashCode, equals(p2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal pressures',
            () {
              const p1 = Pressure.millimetersOfMercury(120);
              const p2 = Pressure.millimetersOfMercury(120);

              expect(p1.compareTo(p2), 0);
            },
          );

          test(
            'returns negative for smaller pressure',
            () {
              const p1 = Pressure.millimetersOfMercury(100);
              const p2 = Pressure.millimetersOfMercury(120);

              expect(p1.compareTo(p2), lessThan(0));
            },
          );

          test(
            'returns positive for larger pressure',
            () {
              const p1 = Pressure.millimetersOfMercury(140);
              const p2 = Pressure.millimetersOfMercury(120);

              expect(p1.compareTo(p2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats pressure with one decimal place',
            () {
              const pressure = Pressure.millimetersOfMercury(120);
              expect(pressure.toString(), '120.0 mmHg');
            },
          );

          test(
            'formats zero pressure',
            () {
              expect(Pressure.zero.toString(), '0.0 mmHg');
            },
          );
        },
      );
    },
  );
}
