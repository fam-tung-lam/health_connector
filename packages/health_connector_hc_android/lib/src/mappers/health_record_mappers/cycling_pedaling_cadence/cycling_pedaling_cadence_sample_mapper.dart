import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/health_connector_core_internal.dart'
    show CyclingPedalingCadenceSample, sinceV2_2_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show CyclingPedalingCadenceSampleDto;
import 'package:meta/meta.dart' show internal;

/// Converts [CyclingPedalingCadenceSample] to
/// [CyclingPedalingCadenceSampleDto].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceSampleToDto on CyclingPedalingCadenceSample {
  CyclingPedalingCadenceSampleDto toDto() {
    return CyclingPedalingCadenceSampleDto(
      time: time.millisecondsSinceEpoch,
      revolutionsPerMinute: cadence.inPerMinute,
    );
  }
}

/// Converts [CyclingPedalingCadenceSampleDto] to
/// [CyclingPedalingCadenceSample].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceSampleDtoToDomain
    on CyclingPedalingCadenceSampleDto {
  CyclingPedalingCadenceSample toDomain() {
    return CyclingPedalingCadenceSample(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      cadence: Frequency.perMinute(revolutionsPerMinute),
    );
  }
}
