import 'package:health_connector_core/health_connector_core.dart'
    show Temperature;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show TemperatureDto, TemperatureUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Temperature] to [TemperatureDto].
@internal
extension TemperatureToDto on Temperature {
  TemperatureDto toDto() {
    // Uses celsius as the transfer unit for consistency.
    return TemperatureDto(
      value: inCelsius,
      unit: TemperatureUnitDto.celsius,
    );
  }
}

/// Converts [TemperatureDto] to [Temperature].
@internal
extension TemperatureDtoToDomain on TemperatureDto {
  Temperature toDomain() {
    switch (unit) {
      case TemperatureUnitDto.celsius:
        return Temperature.celsius(value);
      case TemperatureUnitDto.fahrenheit:
        return Temperature.fahrenheit(value);
      case TemperatureUnitDto.kelvin:
        return Temperature.kelvin(value);
    }
  }
}
