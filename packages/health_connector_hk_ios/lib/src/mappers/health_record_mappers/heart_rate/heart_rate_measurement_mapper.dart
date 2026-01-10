import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeartRateSample, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HeartRateMeasurementDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateSample] to [HeartRateMeasurementDto].
@sinceV1_0_0
@internal
extension HeartRateMeasurementDomainToDto on HeartRateSample {
  HeartRateMeasurementDto toDto() {
    return HeartRateMeasurementDto(
      time: time.millisecondsSinceEpoch,
      beatsPerMinute: rate.toDto(),
    );
  }
}

/// Converts [HeartRateMeasurementDto] to [HeartRateSample].
@sinceV1_0_0
@internal
extension HeartRateMeasurementDtoToDomain on HeartRateMeasurementDto {
  HeartRateSample toDomain() {
    return HeartRateSample(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      rate: beatsPerMinute.toDomain(),
    );
  }
}
