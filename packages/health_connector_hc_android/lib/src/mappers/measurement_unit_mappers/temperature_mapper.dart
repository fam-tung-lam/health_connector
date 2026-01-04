import 'package:health_connector_core/health_connector_core_internal.dart'
    show Temperature;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show TemperatureDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Temperature] to [TemperatureDto].
@internal
extension TemperatureToDto on Temperature {
  TemperatureDto toDto() {
    // Uses celsius as the transfer unit for consistency.
    return TemperatureDto(
      celsius: inCelsius,
    );
  }
}

/// Converts [TemperatureDto] to [Temperature].
@internal
extension TemperatureDtoToDomain on TemperatureDto {
  Temperature toDomain() {
    return Temperature.celsius(celsius);
  }
}
