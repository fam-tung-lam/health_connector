import 'package:health_connector_core/health_connector_core_internal.dart'
    show Temperature, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show TemperatureDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Temperature] to [TemperatureDto].
@sinceV1_0_0
@internal
/// Converts [Temperature] to [TemperatureDto].
@sinceV1_0_0
@internal
extension TemperatureToDto on Temperature {
  TemperatureDto toDto() {
    // Uses celsius as the transfer unit for consistency.
    return TemperatureDto(celsius: inCelsius);
  }
}

/// Converts [TemperatureDto] to [Temperature].
@sinceV1_0_0
@internal
/// Converts [TemperatureDto] to [Temperature].
@sinceV1_0_0
@internal
extension TemperatureDtoToDomain on TemperatureDto {
  Temperature toDomain() {
    return Temperature.celsius(celsius);
  }
}
