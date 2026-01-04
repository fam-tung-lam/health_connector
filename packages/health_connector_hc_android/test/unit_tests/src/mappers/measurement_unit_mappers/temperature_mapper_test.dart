import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/temperature_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import 'package:test/test.dart';

void main() {
  group(
    'TemperatureMapper',
    () {
      group(
        'TemperatureToDto',
        () {
          test(
            'converts Temperature to TemperatureDto in celsius',
            () {
              const temperature = Temperature.celsius(37.0);
              final dto = temperature.toDto();

              expect(dto.celsius, 37.0);
            },
          );

          test(
            'converts Temperature from fahrenheit to celsius',
            () {
              const temperature = Temperature.fahrenheit(98.6);
              final dto = temperature.toDto();

              expect(dto.celsius, closeTo(37.0, 0.1));
            },
          );
        },
      );

      group(
        'TemperatureDtoToDomain',
        () {
          test(
            'maps TemperatureDto to Temperature',
            () {
              final dto = TemperatureDto(celsius: 37.0);
              final temperature = dto.toDomain();

              expect(temperature.inCelsius, 37.0);
            },
          );
        },
      );
    },
  );
}
