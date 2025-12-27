import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, RestingHeartRateRecord, sinceV1_3_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show RestingHeartRateRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [RestingHeartRateRecord] to [RestingHeartRateRecordDto].
@sinceV1_3_0
@internal
extension RestingHeartRateRecordToDto on RestingHeartRateRecord {
  RestingHeartRateRecordDto toDto() {
    return RestingHeartRateRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      beatsPerMinute: beatsPerMinute.toDto(),
    );
  }
}

/// Converts [RestingHeartRateRecordDto] to [RestingHeartRateRecord].
@sinceV1_3_0
@internal
extension RestingHeartRateRecordDtoToDomain on RestingHeartRateRecordDto {
  RestingHeartRateRecord toDomain() {
    return RestingHeartRateRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      beatsPerMinute: beatsPerMinute.toDomain(),
    );
  }
}
