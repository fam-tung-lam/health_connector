import 'package:health_connector_core/health_connector_core_internal.dart'
    show SleepStage, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sleep/sleep_stage_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SleepStageDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SleepStage] to [SleepStageDto].
@sinceV1_0_0
@internal
extension SleepStageDomainToDto on SleepStage {
  SleepStageDto toDto() {
    return SleepStageDto(
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      stage: stageType.toDto(),
    );
  }
}

/// Converts [SleepStageDto] to [SleepStage].
@sinceV1_0_0
@internal
extension SleepStageDtoToDomain on SleepStageDto {
  SleepStage toDomain() {
    return SleepStage(
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      stageType: stage.toDomain(),
    );
  }
}
