import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, StairDescentSpeedRecord, Velocity;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SpeedActivityRecordDto, SpeedActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [StairDescentSpeedRecord] to [SpeedActivityRecordDto].
@internal
extension StairDescentSpeedRecordToDto on StairDescentSpeedRecord {
  /// Converts this stair descent speed record to a DTO for platform transfer.
  SpeedActivityRecordDto toDto() {
    return SpeedActivityRecordDto(
      metersPerSecond: speed.inMetersPerSecond,
      activityType: SpeedActivityTypeDto.stairDescent,
      time: time.millisecondsSinceEpoch,
      id: id.toDto(),
      metadata: metadata.toDto(),
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}

/// Converts [SpeedActivityRecordDto] to [StairDescentSpeedRecord].
@internal
extension StairDescentSpeedRecordDtoToDomain on SpeedActivityRecordDto {
  /// Converts this DTO to a stair descent speed record.
  StairDescentSpeedRecord toDomain() {
    return StairDescentSpeedRecord.internal(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      speed: Velocity.metersPerSecond(metersPerSecond),
      metadata: metadata.toDomain(),
      id: id?.toDomain() ?? HealthRecordId.none,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}
