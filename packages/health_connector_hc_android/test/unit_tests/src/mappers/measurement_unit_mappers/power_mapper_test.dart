import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/power_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

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

              expect(dto.watts, 250.0);
            },
          );

          test(
            'converts Power from kilowatts to watts',
            () {
              const power = Power.kilowatts(0.25);
              final dto = power.toDto();

              expect(dto.watts, 250.0);
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
              final dto = PowerDto(watts: 250.0);
              final power = dto.toDomain();

              expect(power.inWatts, 250.0);
            },
          );
        },
      );
    },
  );
}
