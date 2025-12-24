import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthRecordId,
        RunningSpeedRecord,
        SpeedActivityRecord,
        StairAscentSpeedRecord,
        StairDescentSpeedRecord,
        WalkingSpeedRecord,
        sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SpeedActivityRecordDto, SpeedActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SpeedActivityRecord] subclasses to [SpeedActivityRecordDto].
@sinceV2_0_0
@internal
extension SpeedActivityRecordToDto on SpeedActivityRecord {
  /// Converts this speed activity record to a DTO for platform transfer.
  SpeedActivityRecordDto toDto() {
    return SpeedActivityRecordDto(
      speed: speed.toDto(),
      activityType: _mapActivityType(),
      time: time.millisecondsSinceEpoch,
      id: id.toDto(),
      metadata: metadata.toDto(),
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  SpeedActivityTypeDto _mapActivityType() {
    return switch (this) {
      WalkingSpeedRecord() => SpeedActivityTypeDto.walking,
      RunningSpeedRecord() => SpeedActivityTypeDto.running,
      StairAscentSpeedRecord() => SpeedActivityTypeDto.stairAscent,
      StairDescentSpeedRecord() => SpeedActivityTypeDto.stairDescent,
    };
  }
}

/// Converts [SpeedActivityRecordDto] to [SpeedActivityRecord].
@sinceV2_0_0
@internal
extension SpeedActivityRecordDtoToDomain on SpeedActivityRecordDto {
  /// Converts this DTO to a speed activity record.
  SpeedActivityRecord toDomain() {
    final velocityValue = speed.toDomain();
    final metadataValue = metadata.toDomain();
    final recordId = id == null ? HealthRecordId.none : HealthRecordId(id!);
    final timeValue = DateTime.fromMillisecondsSinceEpoch(
      time,
      isUtc: true,
    ).toLocal();

    return switch (activityType) {
      SpeedActivityTypeDto.walking => WalkingSpeedRecord(
        time: timeValue,
        speed: velocityValue,
        metadata: metadataValue,
        id: recordId,
        zoneOffsetSeconds: zoneOffsetSeconds,
      ),
      SpeedActivityTypeDto.running => RunningSpeedRecord(
        time: timeValue,
        speed: velocityValue,
        metadata: metadataValue,
        id: recordId,
        zoneOffsetSeconds: zoneOffsetSeconds,
      ),
      SpeedActivityTypeDto.stairAscent => StairAscentSpeedRecord(
        time: timeValue,
        speed: velocityValue,
        metadata: metadataValue,
        id: recordId,
        zoneOffsetSeconds: zoneOffsetSeconds,
      ),
      SpeedActivityTypeDto.stairDescent => StairDescentSpeedRecord(
        time: timeValue,
        speed: velocityValue,
        metadata: metadataValue,
        id: recordId,
        zoneOffsetSeconds: zoneOffsetSeconds,
      ),
    };
  }
}
