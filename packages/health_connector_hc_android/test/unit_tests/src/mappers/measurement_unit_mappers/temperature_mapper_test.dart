import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/temperature_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
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

              expect(dto.value, 37.0);
              expect(dto.unit, TemperatureUnitDto.celsius);
            },
          );

          test(
            'converts Temperature from fahrenheit to celsius',
            () {
              const temperature = Temperature.fahrenheit(98.6);
              final dto = temperature.toDto();

              expect(dto.unit, TemperatureUnitDto.celsius);
              expect(dto.value, closeTo(37.0, 0.1));
            },
          );
        },
      );

      group(
        'TemperatureDtoToDomain',
        () {
          parameterizedTest(
            'maps TemperatureDto to Temperature',
            [
              [TemperatureUnitDto.celsius, 37.0],
              [TemperatureUnitDto.fahrenheit, 98.6],
              [TemperatureUnitDto.kelvin, 310.15],
            ],
            (TemperatureUnitDto unit, double value) {
              final dto = TemperatureDto(value: value, unit: unit);
              final temperature = dto.toDomain();

              switch (unit) {
                case TemperatureUnitDto.celsius:
                  expect(temperature.inCelsius, value);
                case TemperatureUnitDto.fahrenheit:
                  expect(temperature.inFahrenheit, value);
                case TemperatureUnitDto.kelvin:
                  expect(temperature.inKelvin, value);
              }
            },
          );
        },
      );
    },
  );
}
