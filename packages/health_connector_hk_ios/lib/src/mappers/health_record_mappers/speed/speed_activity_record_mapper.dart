import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        RunningSpeedRecord,
        SpeedActivityRecord,
        StairAscentSpeedRecord,
        StairDescentSpeedRecord,
        WalkingSpeedRecord,
        sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed/running_speed_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed/stair_ascent_speed_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed/stair_descent_speed_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed/walking_speed_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SpeedActivityRecordDto, SpeedActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SpeedActivityRecord] subclasses to [SpeedActivityRecordDto].
@sinceV2_0_0
@internal
extension SpeedActivityRecordToDto on SpeedActivityRecord {
  /// Converts this speed activity record to a DTO for platform transfer.
  SpeedActivityRecordDto toDto() {
    return switch (this) {
      final WalkingSpeedRecord record => WalkingSpeedRecordToDto(
        record,
      ).toDto(),
      final RunningSpeedRecord record => RunningSpeedRecordToDto(
        record,
      ).toDto(),
      final StairAscentSpeedRecord record => StairAscentSpeedRecordToDto(
        record,
      ).toDto(),
      final StairDescentSpeedRecord record => StairDescentSpeedRecordToDto(
        record,
      ).toDto(),
    };
  }
}

/// Converts [SpeedActivityRecordDto] to [SpeedActivityRecord].
@sinceV2_0_0
@internal
extension SpeedActivityRecordDtoToDomain on SpeedActivityRecordDto {
  /// Converts this DTO to a speed activity record.
  SpeedActivityRecord toDomain() {
    return switch (activityType) {
      SpeedActivityTypeDto.walking => WalkingSpeedRecordDtoToDomain(
        this,
      ).toDomain(),
      SpeedActivityTypeDto.running => RunningSpeedRecordDtoToDomain(
        this,
      ).toDomain(),
      SpeedActivityTypeDto.stairAscent => StairAscentSpeedRecordDtoToDomain(
        this,
      ).toDomain(),
      SpeedActivityTypeDto.stairDescent => StairDescentSpeedRecordDtoToDomain(
        this,
      ).toDomain(),
    };
  }
}
