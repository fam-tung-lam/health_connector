import 'package:health_connector_core/health_connector_core_internal.dart'
    show BasalBodyTemperatureMeasurementLocation;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BasalBodyTemperatureMeasurementLocationDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BasalBodyTemperatureMeasurementLocation] to
/// [BasalBodyTemperatureMeasurementLocationDto].
@internal
extension BasalBodyTemperatureMeasurementLocationToDto
    on BasalBodyTemperatureMeasurementLocation {
  BasalBodyTemperatureMeasurementLocationDto toDto() {
    switch (this) {
      case BasalBodyTemperatureMeasurementLocation.unknown:
        return BasalBodyTemperatureMeasurementLocationDto.unknown;
      case BasalBodyTemperatureMeasurementLocation.armpit:
        return BasalBodyTemperatureMeasurementLocationDto.armpit;
      case BasalBodyTemperatureMeasurementLocation.ear:
        return BasalBodyTemperatureMeasurementLocationDto.ear;
      case BasalBodyTemperatureMeasurementLocation.finger:
        return BasalBodyTemperatureMeasurementLocationDto.finger;
      case BasalBodyTemperatureMeasurementLocation.forehead:
        return BasalBodyTemperatureMeasurementLocationDto.forehead;
      case BasalBodyTemperatureMeasurementLocation.mouth:
        return BasalBodyTemperatureMeasurementLocationDto.mouth;
      case BasalBodyTemperatureMeasurementLocation.rectum:
        return BasalBodyTemperatureMeasurementLocationDto.rectum;
      case BasalBodyTemperatureMeasurementLocation.temporalArtery:
        return BasalBodyTemperatureMeasurementLocationDto.temporalArtery;
      case BasalBodyTemperatureMeasurementLocation.toe:
        return BasalBodyTemperatureMeasurementLocationDto.toe;
      case BasalBodyTemperatureMeasurementLocation.vagina:
        return BasalBodyTemperatureMeasurementLocationDto.vagina;
      case BasalBodyTemperatureMeasurementLocation.wrist:
        return BasalBodyTemperatureMeasurementLocationDto.wrist;
    }
  }
}

/// Converts [BasalBodyTemperatureMeasurementLocationDto] to
/// [BasalBodyTemperatureMeasurementLocation].
@internal
extension BasalBodyTemperatureMeasurementLocationDtoToDomain
    on BasalBodyTemperatureMeasurementLocationDto {
  BasalBodyTemperatureMeasurementLocation toDomain() {
    switch (this) {
      case BasalBodyTemperatureMeasurementLocationDto.unknown:
        return BasalBodyTemperatureMeasurementLocation.unknown;
      case BasalBodyTemperatureMeasurementLocationDto.armpit:
        return BasalBodyTemperatureMeasurementLocation.armpit;
      case BasalBodyTemperatureMeasurementLocationDto.ear:
        return BasalBodyTemperatureMeasurementLocation.ear;
      case BasalBodyTemperatureMeasurementLocationDto.finger:
        return BasalBodyTemperatureMeasurementLocation.finger;
      case BasalBodyTemperatureMeasurementLocationDto.forehead:
        return BasalBodyTemperatureMeasurementLocation.forehead;
      case BasalBodyTemperatureMeasurementLocationDto.mouth:
        return BasalBodyTemperatureMeasurementLocation.mouth;
      case BasalBodyTemperatureMeasurementLocationDto.rectum:
        return BasalBodyTemperatureMeasurementLocation.rectum;
      case BasalBodyTemperatureMeasurementLocationDto.temporalArtery:
        return BasalBodyTemperatureMeasurementLocation.temporalArtery;
      case BasalBodyTemperatureMeasurementLocationDto.toe:
        return BasalBodyTemperatureMeasurementLocation.toe;
      case BasalBodyTemperatureMeasurementLocationDto.vagina:
        return BasalBodyTemperatureMeasurementLocation.vagina;
      case BasalBodyTemperatureMeasurementLocationDto.wrist:
        return BasalBodyTemperatureMeasurementLocation.wrist;
    }
  }
}
