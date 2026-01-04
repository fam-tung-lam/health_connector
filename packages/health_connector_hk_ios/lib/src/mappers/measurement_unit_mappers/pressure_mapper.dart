import 'package:health_connector_core/health_connector_core_internal.dart'
    show Pressure, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PressureDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Pressure] to [PressureDto].
@sinceV1_0_0
@internal
/// Converts [Pressure] to [PressureDto].
@sinceV1_0_0
@internal
extension PressureToDto on Pressure {
  PressureDto toDto() {
    // Uses millimeters of mercury as the transfer unit.
    return PressureDto(millimetersOfMercury: inMillimetersOfMercury);
  }
}

/// Converts [PressureDto] to [Pressure].
@sinceV1_0_0
@internal
/// Converts [PressureDto] to [Pressure].
@sinceV1_0_0
@internal
extension PressureDtoToDomain on PressureDto {
  Pressure toDomain() {
    return Pressure.millimetersOfMercury(millimetersOfMercury);
  }
}
