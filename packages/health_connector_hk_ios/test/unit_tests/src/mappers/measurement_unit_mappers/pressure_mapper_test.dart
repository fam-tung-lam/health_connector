import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/pressure_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
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

              expect(dto.millimetersOfMercury, 120.0);
            },
          );
        },
      );

      group(
        'PressureDtoToDomain',
        () {
          test(
            'maps PressureDto to Pressure',
            () {
              const value = 120.0;
              final dto = PressureDto(millimetersOfMercury: value);
              final pressure = dto.toDomain();

              expect(pressure.inMillimetersOfMercury, value);
            },
          );
        },
      );
    },
  );
}
