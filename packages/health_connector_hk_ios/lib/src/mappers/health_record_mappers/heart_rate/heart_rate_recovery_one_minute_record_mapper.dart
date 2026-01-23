import 'package:health_connector_core/health_connector_core_internal.dart'
    show Frequency, HeartRateRecoveryOneMinuteRecord, HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HeartRateRecoveryOneMinuteRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateRecoveryOneMinuteRecord] to
/// [HeartRateRecoveryOneMinuteRecordDto].
@internal
extension HeartRateRecoveryOneMinuteRecordToDto
    on HeartRateRecoveryOneMinuteRecord {
  HeartRateRecoveryOneMinuteRecordDto toDto() {
    return HeartRateRecoveryOneMinuteRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      beatsPerMinute: rate.inPerMinute,
    );
  }
}

/// Converts [HeartRateRecoveryOneMinuteRecordDto] to
/// [HeartRateRecoveryOneMinuteRecord].
@internal
extension HeartRateRecoveryOneMinuteRecordDtoToDomain
    on HeartRateRecoveryOneMinuteRecordDto {
  HeartRateRecoveryOneMinuteRecord toDomain() {
    return HeartRateRecoveryOneMinuteRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      rate: Frequency.perMinute(beatsPerMinute),
    );
  }
}
