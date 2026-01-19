import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, RunningSpeedRecord, Velocity;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SpeedActivityRecordDto, SpeedActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [RunningSpeedRecord] to [SpeedActivityRecordDto].
@internal
extension RunningSpeedRecordToDto on RunningSpeedRecord {
  /// Converts this running speed record to a DTO for platform transfer.
  SpeedActivityRecordDto toDto() {
    return SpeedActivityRecordDto(
      metersPerSecond: speed.inMetersPerSecond,
      activityType: SpeedActivityTypeDto.running,
      time: time.millisecondsSinceEpoch,
      id: id.toDto(),
      metadata: metadata.toDto(),
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}

/// Converts [SpeedActivityRecordDto] to [RunningSpeedRecord].
@internal
extension RunningSpeedRecordDtoToDomain on SpeedActivityRecordDto {
  /// Converts this DTO to a running speed record.
  RunningSpeedRecord toDomain() {
    return RunningSpeedRecord.internal(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      speed: Velocity.metersPerSecond(metersPerSecond),
      metadata: metadata.toDomain(),
      id: id?.toDomain() ?? HealthRecordId.none,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}
