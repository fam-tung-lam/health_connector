import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/mass_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
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
            'converts Mass from grams to kilograms',
            () {
              const mass = Mass.grams(70000.0);
              final dto = mass.toDto();

              expect(dto.unit, MassUnitDto.kilograms);
              expect(dto.value, 70.0);
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
              [MassUnitDto.pounds, 154.32],
              [MassUnitDto.ounces, 2469.0],
            ],
            (MassUnitDto unit, double value) {
              final dto = MassDto(value: value, unit: unit);
              final mass = dto.toDomain();

              switch (unit) {
                case MassUnitDto.kilograms:
                  expect(mass.inKilograms, value);
                case MassUnitDto.grams:
                  expect(mass.inGrams, value);
                case MassUnitDto.pounds:
                  expect(mass.inPounds, closeTo(value, 0.1));
                case MassUnitDto.ounces:
                  expect(mass.inOunces, closeTo(value, 1.0));
              }
            },
          );
        },
      );
    },
  );
}
