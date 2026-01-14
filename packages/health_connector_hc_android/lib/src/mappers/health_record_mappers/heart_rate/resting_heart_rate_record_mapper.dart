import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, RestingHeartRateRecord, sinceV1_3_0, Frequency;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show RestingHeartRateRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [RestingHeartRateRecordDto] to [RestingHeartRateRecord].
@sinceV1_3_0
@internal
extension RestingHeartRateRecordDtoToDomain on RestingHeartRateRecordDto {
  RestingHeartRateRecord toDomain() {
    return RestingHeartRateRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      rate: Frequency.perMinute(beatsPerMinute),
    );
  }
}

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
      beatsPerMinute: rate.inPerMinute,
    );
  }
}
