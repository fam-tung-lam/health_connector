import 'package:health_connector_core/health_connector_core_internal.dart'
    show SleepStageRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/sleep/sleep_stage_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SleepStageRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SleepStageRecord] to [SleepStageRecordDto].
@sinceV1_0_0
@internal
extension SleepStageRecordToDto on SleepStageRecord {
  SleepStageRecordDto toDto() {
    return SleepStageRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      stageType: stageType.toDto(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [SleepStageRecordDto] to [SleepStageRecord].
@sinceV1_0_0
@internal
extension SleepStageRecordDtoToDomain on SleepStageRecordDto {
  SleepStageRecord toDomain() {
    return SleepStageRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      stageType: stageType.toDomain(),
    );
  }
}
