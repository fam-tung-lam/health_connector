import 'package:health_connector_core/health_connector_core_internal.dart'
    show Pressure;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PressureDto, PressureUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Pressure] to [PressureDto].
@internal
extension PressureToDto on Pressure {
  PressureDto toDto() {
    // Uses millimeters of mercury as the transfer unit.
    return PressureDto(
      value: inMillimetersOfMercury,
      unit: PressureUnitDto.millimetersOfMercury,
    );
  }
}

/// Converts [PressureDto] to [Pressure].
@internal
extension PressureDtoToDomain on PressureDto {
  Pressure toDomain() {
    switch (unit) {
      case PressureUnitDto.millimetersOfMercury:
        return Pressure.millimetersOfMercury(value);
    }
  }
}
