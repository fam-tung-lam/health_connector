import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/power_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

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
              const power = Power.watts(200.0);
              final dto = power.toDto();

              expect(dto.watts, 200.0);
            },
          );

          test(
            'converts Power from kilowatts to watts',
            () {
              const power = Power.kilowatts(0.2);
              final dto = power.toDto();

              expect(dto.watts, 200.0);
            },
          );
        },
      );

      group(
        'PowerDtoToDomain',
        () {
          test(
            'maps PowerDto to Power',
            () {
              const value = 200.0;
              final dto = PowerDto(watts: value);
              final power = dto.toDomain();

              expect(power.inWatts, value);
            },
          );
        },
      );
    },
  );
}
