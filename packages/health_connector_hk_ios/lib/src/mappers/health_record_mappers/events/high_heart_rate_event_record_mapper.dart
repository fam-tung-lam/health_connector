import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to map [HighHeartRateEventRecordDto] to
/// [HighHeartRateEventRecord].
@internal
extension HighHeartRateEventRecordDtoToDomain on HighHeartRateEventRecordDto {
  HighHeartRateEventRecord toDomain() {
    return HighHeartRateEventRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      rateThreshold: beatsPerMinuteThreshold == null
          ? null
          : Frequency.perMinute(beatsPerMinuteThreshold!),
      metadata: metadata.toDomain(),
    );
  }
}
