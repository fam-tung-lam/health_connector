import 'package:health_connector_core/health_connector_core_internal.dart'
    show SleepStage, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SleepStageDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SleepStage] to [SleepStageDto].
@sinceV1_0_0
@internal
extension SleepStageDomainToDto on SleepStage {
  SleepStageDto toDto() {
    return switch (this) {
      SleepStage.unknown => SleepStageDto.unknown,
      SleepStage.awake => SleepStageDto.awake,
      SleepStage.sleeping => SleepStageDto.sleeping,
      SleepStage.outOfBed => SleepStageDto.outOfBed,
      SleepStage.light => SleepStageDto.light,
      SleepStage.deep => SleepStageDto.deep,
      SleepStage.rem => SleepStageDto.rem,
      SleepStage.inBed => SleepStageDto.inBed,
    };
  }
}

/// Converts [SleepStageDto] to [SleepStage].
@sinceV1_0_0
@internal
extension SleepStageDtoToDomain on SleepStageDto {
  SleepStage toDomain() {
    return switch (this) {
      SleepStageDto.unknown => SleepStage.unknown,
      SleepStageDto.awake => SleepStage.awake,
      SleepStageDto.sleeping => SleepStage.sleeping,
      SleepStageDto.outOfBed => SleepStage.outOfBed,
      SleepStageDto.light => SleepStage.light,
      SleepStageDto.deep => SleepStage.deep,
      SleepStageDto.rem => SleepStage.rem,
      SleepStageDto.inBed => SleepStage.inBed,
    };
  }
}
