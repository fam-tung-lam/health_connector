import 'package:health_connector_core/health_connector_core.dart'
    show TimeDuration, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show TimeDurationDto, TimeDurationUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [TimeDuration] to [TimeDurationDto].
@sinceV1_0_0
@internal
extension TimeDurationToDto on TimeDuration {
  TimeDurationDto toDto() {
    // Uses seconds as the transfer unit for consistency.
    return TimeDurationDto(
      value: inSeconds,
      unit: TimeDurationUnitDto.seconds,
    );
  }
}

/// Converts [TimeDurationDto] to [TimeDuration].
@sinceV1_0_0
@internal
extension TimeDurationDtoToDomain on TimeDurationDto {
  TimeDuration toDomain() {
    switch (unit) {
      case TimeDurationUnitDto.seconds:
        return TimeDuration.seconds(value);
      case TimeDurationUnitDto.minutes:
        return TimeDuration.minutes(value);
      case TimeDurationUnitDto.hours:
        return TimeDuration.hours(value);
    }
  }
}
