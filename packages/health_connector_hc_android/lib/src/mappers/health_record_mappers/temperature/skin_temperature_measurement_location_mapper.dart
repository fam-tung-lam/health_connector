import 'package:health_connector_core/health_connector_core_internal.dart'
    show SkinTemperatureMeasurementLocation;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SkinTemperatureMeasurementLocationDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SkinTemperatureMeasurementLocation] to
/// [SkinTemperatureMeasurementLocationDto].
@internal
extension SkinTemperatureMeasurementLocationToDto
    on SkinTemperatureMeasurementLocation {
  SkinTemperatureMeasurementLocationDto toDto() {
    switch (this) {
      case SkinTemperatureMeasurementLocation.unknown:
        return SkinTemperatureMeasurementLocationDto.unknown;
      case SkinTemperatureMeasurementLocation.finger:
        return SkinTemperatureMeasurementLocationDto.finger;
      case SkinTemperatureMeasurementLocation.toe:
        return SkinTemperatureMeasurementLocationDto.toe;
      case SkinTemperatureMeasurementLocation.wrist:
        return SkinTemperatureMeasurementLocationDto.wrist;
    }
  }
}

/// Converts [SkinTemperatureMeasurementLocationDto] to
/// [SkinTemperatureMeasurementLocation].
@internal
extension SkinTemperatureMeasurementLocationDtoToDomain
    on SkinTemperatureMeasurementLocationDto {
  SkinTemperatureMeasurementLocation toDomain() {
    switch (this) {
      case SkinTemperatureMeasurementLocationDto.unknown:
        return SkinTemperatureMeasurementLocation.unknown;
      case SkinTemperatureMeasurementLocationDto.finger:
        return SkinTemperatureMeasurementLocation.finger;
      case SkinTemperatureMeasurementLocationDto.toe:
        return SkinTemperatureMeasurementLocation.toe;
      case SkinTemperatureMeasurementLocationDto.wrist:
        return SkinTemperatureMeasurementLocation.wrist;
    }
  }
}
