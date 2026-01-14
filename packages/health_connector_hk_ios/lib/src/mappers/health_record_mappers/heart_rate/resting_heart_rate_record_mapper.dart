import 'package:health_connector_core/health_connector_core_internal.dart'
    show Frequency, RestingHeartRateRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show RestingHeartRateRecordDto;
import 'package:meta/meta.dart' show internal;

@sinceV1_0_0
@internal
extension RestingHeartRateRecordToDto on RestingHeartRateRecord {
  RestingHeartRateRecordDto toDto() {
    return RestingHeartRateRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      zoneOffsetSeconds: zoneOffsetSeconds,
      beatsPerMinute: rate.inPerMinute,
    );
  }
}

@sinceV1_0_0
@internal
extension RestingHeartRateRecordDtoToDomain on RestingHeartRateRecordDto {
  RestingHeartRateRecord toDomain() {
    return RestingHeartRateRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      rate: Frequency.perMinute(beatsPerMinute),
    );
  }
}
