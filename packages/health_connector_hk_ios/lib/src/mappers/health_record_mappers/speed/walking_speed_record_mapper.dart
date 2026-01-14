import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, WalkingSpeedRecord, sinceV2_0_0, Velocity;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SpeedActivityRecordDto, SpeedActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [WalkingSpeedRecord] to [SpeedActivityRecordDto].
@sinceV2_0_0
@internal
extension WalkingSpeedRecordToDto on WalkingSpeedRecord {
  /// Converts this walking speed record to a DTO for platform transfer.
  SpeedActivityRecordDto toDto() {
    return SpeedActivityRecordDto(
      metersPerSecond: speed.inMetersPerSecond,
      activityType: SpeedActivityTypeDto.walking,
      time: time.millisecondsSinceEpoch,
      id: id.toDto(),
      metadata: metadata.toDto(),
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}

/// Converts [SpeedActivityRecordDto] to [WalkingSpeedRecord].
@sinceV2_0_0
@internal
extension WalkingSpeedRecordDtoToDomain on SpeedActivityRecordDto {
  /// Converts this DTO to a walking speed record.
  WalkingSpeedRecord toDomain() {
    return WalkingSpeedRecord.internal(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      speed: Velocity.metersPerSecond(metersPerSecond),
      metadata: metadata.toDomain(),
      id: id?.toDomain() ?? HealthRecordId.none,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}
