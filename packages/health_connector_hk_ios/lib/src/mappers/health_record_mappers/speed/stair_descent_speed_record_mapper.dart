import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, StairDescentSpeedRecord, sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SpeedActivityRecordDto, SpeedActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [StairDescentSpeedRecord] to [SpeedActivityRecordDto].
@sinceV2_0_0
@internal
extension StairDescentSpeedRecordToDto on StairDescentSpeedRecord {
  /// Converts this stair descent speed record to a DTO for platform transfer.
  SpeedActivityRecordDto toDto() {
    return SpeedActivityRecordDto(
      speed: speed.toDto(),
      activityType: SpeedActivityTypeDto.stairDescent,
      time: time.millisecondsSinceEpoch,
      id: id.toDto(),
      metadata: metadata.toDto(),
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}

/// Converts [SpeedActivityRecordDto] to [StairDescentSpeedRecord].
@sinceV2_0_0
@internal
extension StairDescentSpeedRecordDtoToDomain on SpeedActivityRecordDto {
  /// Converts this DTO to a stair descent speed record.
  StairDescentSpeedRecord toDomain() {
    return StairDescentSpeedRecord(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      speed: speed.toDomain(),
      metadata: metadata.toDomain(),
      id: id?.toDomain() ?? HealthRecordId.none,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}
