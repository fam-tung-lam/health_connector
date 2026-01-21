import 'package:health_connector_core/health_connector_core_internal.dart'
    show Frequency, WalkingHeartRateAverageRecord, HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show WalkingHeartRateAverageRecordDto;
import 'package:meta/meta.dart' show internal;

/// Extension for converting [WalkingHeartRateAverageRecordDto] to
/// [WalkingHeartRateAverageRecord].
@internal
extension WalkingHeartRateAverageRecordDtoToDomain
    on WalkingHeartRateAverageRecordDto {
  WalkingHeartRateAverageRecord toDomain() {
    return WalkingHeartRateAverageRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      metadata: metadata.toDomain(),
      rate: Frequency.perMinute(beatsPerMinute),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
