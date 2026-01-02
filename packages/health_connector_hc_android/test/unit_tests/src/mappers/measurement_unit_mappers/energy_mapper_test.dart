import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/energy_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'EnergyMapper',
    () {
      group(
        'EnergyToDto',
        () {
          test(
            'converts Energy to EnergyDto in kilocalories',
            () {
              const energy = Energy.kilocalories(500.0);
              final dto = energy.toDto();

              expect(dto.value, 500.0);
              expect(dto.unit, EnergyUnitDto.kilocalories);
            },
          );

          test(
            'converts Energy from kilojoules to kilocalories',
            () {
              const energy = Energy.kilojoules(2092.0);
              final dto = energy.toDto();

              expect(dto.unit, EnergyUnitDto.kilocalories);
              expect(dto.value, closeTo(500.0, 0.5));
            },
          );
        },
      );

      group(
        'EnergyDtoToDomain',
        () {
          parameterizedTest(
            'maps EnergyDto to Energy',
            [
              [EnergyUnitDto.kilocalories, 500.0],
              [EnergyUnitDto.kilojoules, 2092.0],
              [EnergyUnitDto.calories, 500000.0],
              [EnergyUnitDto.joules, 2092000.0],
            ],
            (EnergyUnitDto unit, double value) {
              final dto = EnergyDto(value: value, unit: unit);
              final energy = dto.toDomain();

              switch (unit) {
                case EnergyUnitDto.kilocalories:
                  expect(energy.inKilocalories, value);
                case EnergyUnitDto.kilojoules:
                  expect(energy.inKilojoules, value);
                case EnergyUnitDto.calories:
                  expect(energy.inCalories, value);
                case EnergyUnitDto.joules:
                  expect(energy.inJoules, value);
              }
            },
          );
        },
      );
    },
  );
}
