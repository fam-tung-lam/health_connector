import 'package:health_connector_core/health_connector_core_internal.dart'
    show Frequency, HeartRateRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show FrequencyDto, HeartRateRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateRecord] to [HeartRateRecordDto].
@sinceV1_0_0
@internal
extension HeartRateRecordToDto on HeartRateRecord {
  HeartRateRecordDto toDto() {
    return HeartRateRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      beatsPerMinute: FrequencyDto(perMinute: rate.inPerMinute),
    );
  }
}

/// Converts [HeartRateRecordDto] to [HeartRateRecord].
@sinceV1_0_0
@internal
extension HeartRateRecordDtoToDomain on HeartRateRecordDto {
  HeartRateRecord toDomain() {
    return HeartRateRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      rate: Frequency.perMinute(beatsPerMinute.perMinute),
    );
  }
}
