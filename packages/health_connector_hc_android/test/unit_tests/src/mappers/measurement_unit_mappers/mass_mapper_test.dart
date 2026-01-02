import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/mass_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'MassMapper',
    () {
      group(
        'MassToDto',
        () {
          test(
            'converts Mass to MassDto in kilograms',
            () {
              const mass = Mass.kilograms(70.0);
              final dto = mass.toDto();

              expect(dto.value, 70.0);
              expect(dto.unit, MassUnitDto.kilograms);
            },
          );

          test(
            'converts Mass from pounds to kilograms',
            () {
              const mass = Mass.pounds(154.324);
              final dto = mass.toDto();

              expect(dto.unit, MassUnitDto.kilograms);
              expect(dto.value, closeTo(70.0, 0.1));
            },
          );
        },
      );

      group(
        'MassDtoToDomain',
        () {
          parameterizedTest(
            'maps MassDto to Mass',
            [
              [MassUnitDto.kilograms, 70.0],
              [MassUnitDto.grams, 70000.0],
              [MassUnitDto.pounds, 154.324],
              [MassUnitDto.ounces, 2469.2],
            ],
            (MassUnitDto unit, double value) {
              final dto = MassDto(value: value, unit: unit);
              final mass = dto.toDomain();

              switch (unit) {
                case MassUnitDto.kilograms:
                  expect(mass.inKilograms, closeTo(value, 0.0001));
                case MassUnitDto.grams:
                  expect(mass.inGrams, closeTo(value, 0.1));
                case MassUnitDto.pounds:
                  expect(mass.inPounds, closeTo(value, 0.0001));
                case MassUnitDto.ounces:
                  expect(mass.inOunces, closeTo(value, 0.1));
              }
            },
          );
        },
      );
    },
  );
}
