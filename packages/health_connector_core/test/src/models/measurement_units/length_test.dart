import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Length',
    () {
      group(
        'meters constructor',
        () {
          test(
            'creates length from valid meters value',
            () {
              const length = Length.meters(1000);
              expect(length.inMeters, 1000);
            },
          );
        },
      );

      group(
        'kilometers constructor',
        () {
          test(
            'creates length from valid kilometers value',
            () {
              const length = Length.kilometers(1);
              expect(length.inMeters, 1000);
            },
          );

          test(
            'converts kilometers to meters correctly',
            () {
              const length = Length.kilometers(5);
              expect(length.inMeters, 5000);
              expect(length.inKilometers, 5);
            },
          );
        },
      );

      group(
        'centimeters constructor',
        () {
          test(
            'creates length from valid centimeters value',
            () {
              const length = Length.centimeters(100000);
              expect(length.inMeters, 1000);
            },
          );

          test(
            'converts centimeters to meters correctly',
            () {
              const length = Length.centimeters(150);
              expect(length.inMeters, 1.5);
            },
          );
        },
      );

      group(
        'millimeters constructor',
        () {
          test(
            'creates length from valid millimeters value',
            () {
              const length = Length.millimeters(1000000);
              expect(length.inMeters, 1000);
            },
          );
        },
      );

      group(
        'miles constructor',
        () {
          test(
            'creates length from valid miles value',
            () {
              const length = Length.miles(0.621371);
              expect(length.inMeters, closeTo(1000, 1));
            },
          );

          test(
            'converts miles to meters correctly',
            () {
              const length = Length.miles(1);
              expect(length.inMeters, closeTo(1609.344, 0.1));
            },
          );
        },
      );

      group(
        'feet constructor',
        () {
          test(
            'creates length from valid feet value',
            () {
              const length = Length.feet(3280.84);
              expect(length.inMeters, closeTo(1000, 1));
            },
          );

          test(
            'converts feet to meters correctly',
            () {
              const length = Length.feet(10);
              expect(length.inMeters, closeTo(3.048, 0.01));
            },
          );
        },
      );

      group(
        'inches constructor',
        () {
          test(
            'creates length from valid inches value',
            () {
              const length = Length.inches(39370.1);
              expect(length.inMeters, closeTo(1000, 1));
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
              expect(Length.zero.inMeters, 0);
              expect(Length.zero.inKilometers, 0);
              expect(Length.zero.inCentimeters, 0);
              expect(Length.zero.inMiles, 0);
              expect(Length.zero.inFeet, 0);
              expect(Length.zero.inInches, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inMeters returns length in meters',
            () {
              const length = Length.meters(1000);
              expect(length.inMeters, 1000);
            },
          );

          test(
            'inKilometers returns length in kilometers',
            () {
              const length = Length.meters(1500);
              expect(length.inKilometers, 1.5);
            },
          );

          test(
            'inCentimeters returns length in centimeters',
            () {
              const length = Length.meters(1.5);
              expect(length.inCentimeters, 150);
            },
          );

          test(
            'inMiles returns length in miles',
            () {
              const length = Length.meters(1609.34);
              expect(length.inMiles, closeTo(1.0, 0.01));
            },
          );

          test(
            'inFeet returns length in feet',
            () {
              const length = Length.meters(1);
              expect(length.inFeet, closeTo(3.28, 0.01));
            },
          );

          test(
            'inInches returns length in inches',
            () {
              const length = Length.feet(1);
              expect(length.inInches, closeTo(12.0, 0.1));
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines lengths',
            () {
              const l1 = Length.meters(600);
              const l2 = Length.meters(400);
              final result = l1 + l2;

              expect(result.inMeters, 1000);
            },
          );

          test(
            'subtraction operator subtracts lengths',
            () {
              const l1 = Length.meters(1500);
              const l2 = Length.meters(500);
              final result = l1 - l2;

              expect(result.inMeters, 1000);
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
              const l1 = Length.meters(1500);
              const l2 = Length.meters(1000);

              expect(l1 > l2, isTrue);
              expect(l2 > l1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const l1 = Length.meters(500);
              const l2 = Length.meters(1000);

              expect(l1 < l2, isTrue);
              expect(l2 < l1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const l1 = Length.meters(1000);
              const l2 = Length.meters(1000);
              const l3 = Length.meters(500);

              expect(l1 >= l2, isTrue);
              expect(l1 >= l3, isTrue);
              expect(l3 >= l1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const l1 = Length.meters(1000);
              const l2 = Length.meters(1000);
              const l3 = Length.meters(1500);

              expect(l1 <= l2, isTrue);
              expect(l1 <= l3, isTrue);
              expect(l3 <= l1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal lengths are equal',
            () {
              const l1 = Length.meters(1000);
              const l2 = Length.meters(1000);

              expect(l1, equals(l2));
            },
          );

          test(
            'lengths within tolerance are equal',
            () {
              const l1 = Length.meters(1000.0000);
              const l2 = Length.meters(1000.0005);

              expect(l1, equals(l2));
            },
          );

          test(
            'lengths outside tolerance are not equal',
            () {
              const l1 = Length.meters(1000.0);
              const l2 = Length.meters(1000.01);

              expect(l1, isNot(equals(l2)));
            },
          );

          test(
            'different lengths are not equal',
            () {
              const l1 = Length.meters(1000);
              const l2 = Length.meters(1500);

              expect(l1, isNot(equals(l2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const l = Length.meters(1000);

              expect(l, equals(l));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal lengths have same hash code',
            () {
              const l1 = Length.meters(1000);
              const l2 = Length.meters(1000);

              expect(l1.hashCode, equals(l2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal lengths',
            () {
              const l1 = Length.meters(1000);
              const l2 = Length.meters(1000);

              expect(l1.compareTo(l2), 0);
            },
          );

          test(
            'returns negative for smaller length',
            () {
              const l1 = Length.meters(500);
              const l2 = Length.meters(1000);

              expect(l1.compareTo(l2), lessThan(0));
            },
          );

          test(
            'returns positive for larger length',
            () {
              const l1 = Length.meters(1500);
              const l2 = Length.meters(1000);

              expect(l1.compareTo(l2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats length with three decimal places',
            () {
              const length = Length.meters(1000);
              expect(length.toString(), '1000.000 m');
            },
          );

          test(
            'formats zero length',
            () {
              expect(Length.zero.toString(), '0.000 m');
            },
          );
        },
      );
    },
  );
}
