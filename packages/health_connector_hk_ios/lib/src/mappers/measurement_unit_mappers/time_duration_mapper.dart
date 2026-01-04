import 'package:health_connector_core/health_connector_core_internal.dart'
    show TimeDuration, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show TimeDurationDto;
import 'package:meta/meta.dart' show internal;

/// Converts [TimeDuration] to [TimeDurationDto].
@sinceV1_0_0
@internal
/// Converts [TimeDuration] to [TimeDurationDto].
@sinceV1_0_0
@internal
extension TimeDurationToDto on TimeDuration {
  TimeDurationDto toDto() {
    // Uses seconds as the transfer unit for consistency.
    return TimeDurationDto(seconds: inSeconds);
  }
}

/// Converts [TimeDurationDto] to [TimeDuration].
@sinceV1_0_0
@internal
/// Converts [TimeDurationDto] to [TimeDuration].
@sinceV1_0_0
@internal
extension TimeDurationDtoToDomain on TimeDurationDto {
  TimeDuration toDomain() {
    return TimeDuration.seconds(seconds);
  }
}
