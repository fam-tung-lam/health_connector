import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        BasalBodyTemperatureRecord,
        BasalBodyTemperatureMeasurementLocation,
        HealthRecordId,
        sinceV2_2_0,
        Temperature;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
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
      metadata: metadata.toDto(),
      celsius: temperature.inCelsius,
      measurementLocation: measurementLocation.toDto(),
    );
  }
}

/// Converts [BasalBodyTemperatureRecordDto] to [BasalBodyTemperatureRecord].
@sinceV2_2_0
@internal
extension BasalBodyTemperatureRecordDtoToDomain
    on BasalBodyTemperatureRecordDto {
  BasalBodyTemperatureRecord toDomain() {
    return BasalBodyTemperatureRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      temperature: Temperature.celsius(celsius),
      measurementLocation: measurementLocation.toDomain(),
    );
  }
}

/// Converts [BasalBodyTemperatureMeasurementLocationDto] to
/// [BasalBodyTemperatureMeasurementLocation].
@sinceV2_2_0
@internal
extension BasalBodyTemperatureMeasurementLocationDtoToDomain
    on BasalBodyTemperatureMeasurementLocationDto {
  BasalBodyTemperatureMeasurementLocation toDomain() {
    return switch (this) {
      BasalBodyTemperatureMeasurementLocationDto.unknown =>
        BasalBodyTemperatureMeasurementLocation.unknown,
      BasalBodyTemperatureMeasurementLocationDto.armpit =>
        BasalBodyTemperatureMeasurementLocation.armpit,
      BasalBodyTemperatureMeasurementLocationDto.ear =>
        BasalBodyTemperatureMeasurementLocation.ear,
      BasalBodyTemperatureMeasurementLocationDto.finger =>
        BasalBodyTemperatureMeasurementLocation.finger,
      BasalBodyTemperatureMeasurementLocationDto.forehead =>
        BasalBodyTemperatureMeasurementLocation.forehead,
      BasalBodyTemperatureMeasurementLocationDto.mouth =>
        BasalBodyTemperatureMeasurementLocation.mouth,
      BasalBodyTemperatureMeasurementLocationDto.rectum =>
        BasalBodyTemperatureMeasurementLocation.rectum,
      BasalBodyTemperatureMeasurementLocationDto.temporalArtery =>
        BasalBodyTemperatureMeasurementLocation.temporalArtery,
      BasalBodyTemperatureMeasurementLocationDto.toe =>
        BasalBodyTemperatureMeasurementLocation.toe,
      BasalBodyTemperatureMeasurementLocationDto.vagina =>
        BasalBodyTemperatureMeasurementLocation.vagina,
      BasalBodyTemperatureMeasurementLocationDto.wrist =>
        BasalBodyTemperatureMeasurementLocation.wrist,
    };
  }
}

/// Converts [BasalBodyTemperatureMeasurementLocation] to
/// [BasalBodyTemperatureMeasurementLocationDto].
@sinceV2_2_0
@internal
extension BasalBodyTemperatureMeasurementLocationToDto
    on BasalBodyTemperatureMeasurementLocation {
  BasalBodyTemperatureMeasurementLocationDto toDto() {
    return switch (this) {
      BasalBodyTemperatureMeasurementLocation.unknown =>
        BasalBodyTemperatureMeasurementLocationDto.unknown,
      BasalBodyTemperatureMeasurementLocation.armpit =>
        BasalBodyTemperatureMeasurementLocationDto.armpit,
      BasalBodyTemperatureMeasurementLocation.ear =>
        BasalBodyTemperatureMeasurementLocationDto.ear,
      BasalBodyTemperatureMeasurementLocation.finger =>
        BasalBodyTemperatureMeasurementLocationDto.finger,
      BasalBodyTemperatureMeasurementLocation.forehead =>
        BasalBodyTemperatureMeasurementLocationDto.forehead,
      BasalBodyTemperatureMeasurementLocation.mouth =>
        BasalBodyTemperatureMeasurementLocationDto.mouth,
      BasalBodyTemperatureMeasurementLocation.rectum =>
        BasalBodyTemperatureMeasurementLocationDto.rectum,
      BasalBodyTemperatureMeasurementLocation.temporalArtery =>
        BasalBodyTemperatureMeasurementLocationDto.temporalArtery,
      BasalBodyTemperatureMeasurementLocation.toe =>
        BasalBodyTemperatureMeasurementLocationDto.toe,
      BasalBodyTemperatureMeasurementLocation.vagina =>
        BasalBodyTemperatureMeasurementLocationDto.vagina,
      BasalBodyTemperatureMeasurementLocation.wrist =>
        BasalBodyTemperatureMeasurementLocationDto.wrist,
    };
  }
}
