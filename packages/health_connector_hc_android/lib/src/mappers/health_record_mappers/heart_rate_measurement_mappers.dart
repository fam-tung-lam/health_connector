import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeartRateMeasurement, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HeartRateMeasurementDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateMeasurement] to [HeartRateMeasurementDto].
@sinceV1_0_0
@internal
extension HeartRateMeasurementDtoMapper on HeartRateMeasurement {
  HeartRateMeasurementDto toDto() {
    return HeartRateMeasurementDto(
      time: time.millisecondsSinceEpoch,
      beatsPerMinute: beatsPerMinute.toDto(),
    );
  }
}

/// Converts [HeartRateMeasurementDto] to [HeartRateMeasurement].
@sinceV1_0_0
@internal
extension HeartRateMeasurementDtoToDomain on HeartRateMeasurementDto {
  HeartRateMeasurement toDomain() {
    return HeartRateMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time),
      beatsPerMinute: beatsPerMinute.toDomain(),
    );
  }
}
