import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/pressure_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'PressureMapper',
    () {
      group(
        'PressureToDto',
        () {
          test(
            'converts Pressure to PressureDto in millimetersOfMercury',
            () {
              const pressure = Pressure.millimetersOfMercury(120.0);
              final dto = pressure.toDto();

              expect(dto.value, 120.0);
              expect(dto.unit, PressureUnitDto.millimetersOfMercury);
            },
          );
        },
      );

      group(
        'PressureDtoToDomain',
        () {
          parameterizedTest(
            'maps PressureDto to Pressure',
            [
              [PressureUnitDto.millimetersOfMercury, 120.0],
            ],
            (PressureUnitDto unit, double value) {
              final dto = PressureDto(value: value, unit: unit);
              final pressure = dto.toDomain();

              switch (unit) {
                case PressureUnitDto.millimetersOfMercury:
                  expect(pressure.inMillimetersOfMercury, value);
              }
            },
          );
        },
      );
    },
  );
}
