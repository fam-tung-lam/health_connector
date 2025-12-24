import 'package:health_connector_core/health_connector_core_internal.dart'
    show SleepStage, SleepStageType, sinceV1_0_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SleepStageDto, SleepStageTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SleepStageType] to [SleepStageTypeDto].
@sinceV1_0_0
@internal
extension SleepStageTypeDomainToDto on SleepStageType {
  SleepStageTypeDto toDto() {
    return switch (this) {
      SleepStageType.unknown => SleepStageTypeDto.unknown,
      SleepStageType.awake => SleepStageTypeDto.awake,
      SleepStageType.sleeping => SleepStageTypeDto.sleeping,
      SleepStageType.outOfBed => SleepStageTypeDto.outOfBed,
      SleepStageType.light => SleepStageTypeDto.light,
      SleepStageType.deep => SleepStageTypeDto.deep,
      SleepStageType.rem => SleepStageTypeDto.rem,
      SleepStageType.inBed => SleepStageTypeDto.inBed,
    };
  }
}

/// Converts [SleepStageTypeDto] to [SleepStageType].
@sinceV1_0_0
@internal
extension SleepStageTypeDtoToDomain on SleepStageTypeDto {
  SleepStageType toDomain() {
    return switch (this) {
      SleepStageTypeDto.unknown => SleepStageType.unknown,
      SleepStageTypeDto.awake => SleepStageType.awake,
      SleepStageTypeDto.sleeping => SleepStageType.sleeping,
      SleepStageTypeDto.outOfBed => SleepStageType.outOfBed,
      SleepStageTypeDto.light => SleepStageType.light,
      SleepStageTypeDto.deep => SleepStageType.deep,
      SleepStageTypeDto.rem => SleepStageType.rem,
      SleepStageTypeDto.inBed => SleepStageType.inBed,
    };
  }
}

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
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      stageType: stage.toDomain(),
    );
  }
}
