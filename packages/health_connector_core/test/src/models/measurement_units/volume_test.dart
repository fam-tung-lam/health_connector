import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Volume',
    () {
      group(
        'liters constructor',
        () {
          test(
            'creates volume from valid liters value',
            () {
              const volume = Volume.liters(2);
              expect(volume.inLiters, 2);
            },
          );
        },
      );

      group(
        'milliliters constructor',
        () {
          test(
            'creates volume from valid milliliters value',
            () {
              const volume = Volume.milliliters(2000);
              expect(volume.inLiters, 2);
            },
          );

          test(
            'converts milliliters to liters correctly',
            () {
              const volume = Volume.milliliters(1500);
              expect(volume.inLiters, 1.5);
              expect(volume.inMilliliters, 1500);
            },
          );
        },
      );

      group(
        'fluidOuncesUs constructor',
        () {
          test(
            'creates volume from valid US fluid ounces value',
            () {
              const volume = Volume.fluidOuncesUs(67.6);
              expect(volume.inLiters, closeTo(2.0, 0.01));
            },
          );

          test(
            'converts US fluid ounces to liters correctly',
            () {
              const volume = Volume.fluidOuncesUs(33.8);
              expect(volume.inLiters, closeTo(1.0, 0.01));
            },
          );
        },
      );

      group(
        'fluidOuncesImp constructor',
        () {
          test(
            'creates volume from valid Imperial fluid ounces value',
            () {
              const volume = Volume.fluidOuncesImp(70.4);
              expect(volume.inLiters, closeTo(2.0, 0.01));
            },
          );

          test(
            'converts Imperial fluid ounces to liters correctly',
            () {
              const volume = Volume.fluidOuncesImp(35.2);
              expect(volume.inLiters, closeTo(1.0, 0.01));
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
              expect(Volume.zero.inLiters, 0);
              expect(Volume.zero.inMilliliters, 0);
              expect(Volume.zero.inFluidOuncesUs, 0);
              expect(Volume.zero.inFluidOuncesImp, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inLiters returns volume in liters',
            () {
              const volume = Volume.liters(2);
              expect(volume.inLiters, 2);
            },
          );

          test(
            'inMilliliters returns volume in milliliters',
            () {
              const volume = Volume.liters(1.5);
              expect(volume.inMilliliters, 1500);
            },
          );

          test(
            'inFluidOuncesUs returns volume in US fluid ounces',
            () {
              const volume = Volume.liters(2);
              expect(volume.inFluidOuncesUs, closeTo(67.6, 0.1));
            },
          );

          test(
            'inFluidOuncesImp returns volume in Imperial fluid ounces',
            () {
              const volume = Volume.liters(2);
              expect(volume.inFluidOuncesImp, closeTo(70.4, 0.1));
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines volumes',
            () {
              const v1 = Volume.liters(1.2);
              const v2 = Volume.liters(0.8);
              final result = v1 + v2;

              expect(result.inLiters, 2);
            },
          );

          test(
            'subtraction operator subtracts volumes',
            () {
              const v1 = Volume.liters(2.5);
              const v2 = Volume.liters(0.5);
              final result = v1 - v2;

              expect(result.inLiters, 2);
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
              const v1 = Volume.liters(3);
              const v2 = Volume.liters(2);

              expect(v1 > v2, isTrue);
              expect(v2 > v1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              const v1 = Volume.liters(1);
              const v2 = Volume.liters(2);

              expect(v1 < v2, isTrue);
              expect(v2 < v1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              const v1 = Volume.liters(2);
              const v2 = Volume.liters(2);
              const v3 = Volume.liters(1);

              expect(v1 >= v2, isTrue);
              expect(v1 >= v3, isTrue);
              expect(v3 >= v1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              const v1 = Volume.liters(2);
              const v2 = Volume.liters(2);
              const v3 = Volume.liters(3);

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
            'equal volumes are equal',
            () {
              const v1 = Volume.liters(2);
              const v2 = Volume.liters(2);

              expect(v1, equals(v2));
            },
          );

          test(
            'volumes within tolerance are equal',
            () {
              const v1 = Volume.liters(2.0000);
              const v2 = Volume.liters(2.0005);

              expect(v1, equals(v2));
            },
          );

          test(
            'volumes outside tolerance are not equal',
            () {
              const v1 = Volume.liters(2.0);
              const v2 = Volume.liters(2.01);

              expect(v1, isNot(equals(v2)));
            },
          );

          test(
            'different volumes are not equal',
            () {
              const v1 = Volume.liters(2);
              const v2 = Volume.liters(3);

              expect(v1, isNot(equals(v2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              const v = Volume.liters(2);

              expect(v, equals(v));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal volumes have same hash code',
            () {
              const v1 = Volume.liters(2);
              const v2 = Volume.liters(2);

              expect(v1.hashCode, equals(v2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal volumes',
            () {
              const v1 = Volume.liters(2);
              const v2 = Volume.liters(2);

              expect(v1.compareTo(v2), 0);
            },
          );

          test(
            'returns negative for smaller volume',
            () {
              const v1 = Volume.liters(1);
              const v2 = Volume.liters(2);

              expect(v1.compareTo(v2), lessThan(0));
            },
          );

          test(
            'returns positive for larger volume',
            () {
              const v1 = Volume.liters(3);
              const v2 = Volume.liters(2);

              expect(v1.compareTo(v2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats volume with three decimal places',
            () {
              const volume = Volume.liters(2);
              expect(volume.toString(), '2.000 L');
            },
          );

          test(
            'formats zero volume',
            () {
              expect(Volume.zero.toString(), '0.000 L');
            },
          );
        },
      );
    },
  );
}
