import 'package:health_connector_core/health_connector_core_internal.dart'
    show BasalBodyTemperatureRecord, HealthRecordId, sinceV2_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/temperature/basal_body_temperature_measurement_location_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BasalBodyTemperatureRecordDto;
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
    return BasalBodyTemperatureRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      temperature: temperature.toDomain(),
      measurementLocation: measurementLocation.toDomain(),
      metadata: metadata.toDomain(),
    );
  }
}
