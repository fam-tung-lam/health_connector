import 'package:health_connector_core/health_connector_core_internal.dart'
    show PowerSample, sinceV2_1_0;
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PowerSampleDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PowerSample] to [PowerSampleDto].
@sinceV2_1_0
@internal
extension PowerSampleToDto on PowerSample {
  PowerSampleDto toDto() {
    return PowerSampleDto(
      time: time.millisecondsSinceEpoch,
      power: power.toDto(),
    );
  }
}

/// Converts [PowerSampleDto] to [PowerSample].
@sinceV2_1_0
@internal
extension PowerSampleDtoToDomain on PowerSampleDto {
  PowerSample toDomain() {
    return PowerSample(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      power: power.toDomain(),
    );
  }
}
