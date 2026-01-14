import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeartRateSample, sinceV1_0_0, Frequency;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HeartRateSampleDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateSample] to [HeartRateSampleDto].
@sinceV1_0_0
@internal
extension HeartRateSampleDtoMapper on HeartRateSample {
  HeartRateSampleDto toDto() {
    return HeartRateSampleDto(
      time: time.millisecondsSinceEpoch,
      beatsPerMinute: rate.inPerMinute,
    );
  }
}

/// Converts [HeartRateSampleDto] to [HeartRateSample].
@sinceV1_0_0
@internal
extension HeartRateSampleDtoToDomain on HeartRateSampleDto {
  HeartRateSample toDomain() {
    return HeartRateSample(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      rate: Frequency.perMinute(beatsPerMinute),
    );
  }
}
