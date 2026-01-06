import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/temperature_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

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
              const value = 37.0;
              final dto = TemperatureDto(celsius: value);
              final temperature = dto.toDomain();

              expect(temperature.inCelsius, value);
            },
          );
        },
      );
    },
  );
}
