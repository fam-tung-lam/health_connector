import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/power_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'PowerMapper',
    () {
      group(
        'PowerToDto',
        () {
          test(
            'converts Power to PowerDto in watts',
            () {
              const power = Power.watts(250.0);
              final dto = power.toDto();

              expect(dto.value, 250.0);
              expect(dto.unit, PowerUnitDto.watts);
            },
          );

          test(
            'converts Power from kilowatts to watts',
            () {
              const power = Power.kilowatts(0.25);
              final dto = power.toDto();

              expect(dto.unit, PowerUnitDto.watts);
              expect(dto.value, 250.0);
            },
          );
        },
      );

      group(
        'PowerDtoToDomain',
        () {
          parameterizedTest(
            'maps PowerDto to Power',
            [
              [PowerUnitDto.watts, 250.0],
              [PowerUnitDto.kilowatts, 0.25],
            ],
            (PowerUnitDto unit, double value) {
              final dto = PowerDto(value: value, unit: unit);
              final power = dto.toDomain();

              switch (unit) {
                case PowerUnitDto.watts:
                  expect(power.inWatts, value);
                case PowerUnitDto.kilowatts:
                  expect(power.inKilowatts, value);
              }
            },
          );
        },
      );
    },
  );
}
