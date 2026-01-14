import 'package:health_connector_core/health_connector_core_internal.dart'
    show SpeedSample, sinceV2_0_0, Velocity;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SpeedSampleDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SpeedSample] to [SpeedSampleDto].
@sinceV2_0_0
@internal
extension SpeedSampleToDto on SpeedSample {
  SpeedSampleDto toDto() {
    return SpeedSampleDto(
      time: time.millisecondsSinceEpoch,
      metersPerSecond: speed.inMetersPerSecond,
    );
  }
}

/// Converts [SpeedSampleDto] to [SpeedSample].
@sinceV2_0_0
@internal
extension SpeedSampleDtoToDomain on SpeedSampleDto {
  SpeedSample toDomain() {
    return SpeedSample(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      speed: Velocity.metersPerSecond(metersPerSecond),
    );
  }
}
