import 'package:health_connector_core/health_connector_core_internal.dart'
    show TimeDuration;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show TimeDurationDto, TimeDurationUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [TimeDuration] to [TimeDurationDto].
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
