import 'package:health_connector_core/health_connector_core.dart'
    show SleepStageType;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show SleepStageTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SleepStageType] to [SleepStageTypeDto].
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
