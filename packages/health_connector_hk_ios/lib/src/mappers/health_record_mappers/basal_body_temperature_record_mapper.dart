import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        BasalBodyTemperatureRecord,
        BasalBodyTemperatureMeasurementLocation,
        HealthRecordId,
        sinceV2_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        BasalBodyTemperatureRecordDto,
        BasalBodyTemperatureMeasurementLocationDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BasalBodyTemperatureRecord] to [BasalBodyTemperatureRecordDto].
@sinceV2_2_0
@internal
extension BasalBodyTemperatureRecordToDto on BasalBodyTemperatureRecord {
  BasalBodyTemperatureRecordDto toDto() {
    return BasalBodyTemperatureRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      temperature: temperature.toDto(),
      measurementLocation: measurementLocation.toDto(),
      metadata: metadata.toDto(),
    );
  }
}

/// Converts [BasalBodyTemperatureRecordDto] to [BasalBodyTemperatureRecord].
@sinceV2_2_0
@internal
extension BasalBodyTemperatureRecordDtoToDomain
    on BasalBodyTemperatureRecordDto {
  BasalBodyTemperatureRecord toDomain() {
    return BasalBodyTemperatureRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      temperature: temperature.toDomain(),
      measurementLocation: measurementLocation.toDomain(),
      metadata: metadata.toDomain(),
    );
  }
}

/// Converts [BasalBodyTemperatureMeasurementLocation] to
/// [BasalBodyTemperatureMeasurementLocationDto].
@sinceV2_2_0
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
@sinceV2_2_0
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
