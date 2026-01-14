import 'package:health_connector_core/health_connector_core_internal.dart'
    show BodyTemperatureRecord, HealthRecordId, Temperature, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BodyTemperatureRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BodyTemperatureRecord] to [BodyTemperatureRecordDto].
@sinceV1_0_0
@internal
extension BodyTemperatureRecordToDto on BodyTemperatureRecord {
  BodyTemperatureRecordDto toDto() {
    return BodyTemperatureRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      celsius: temperature.inCelsius,
    );
  }
}

/// Converts [BodyTemperatureRecordDto] to [BodyTemperatureRecord].
@sinceV1_0_0
@internal
extension BodyTemperatureRecordDtoToDomain on BodyTemperatureRecordDto {
  BodyTemperatureRecord toDomain() {
    return BodyTemperatureRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      temperature: Temperature.celsius(celsius),
    );
  }
}
