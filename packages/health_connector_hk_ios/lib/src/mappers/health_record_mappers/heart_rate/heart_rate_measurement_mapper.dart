import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeartRateMeasurement, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HeartRateMeasurementDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateMeasurement] to [HeartRateMeasurementDto].
@sinceV1_0_0
@internal
extension HeartRateMeasurementDomainToDto on HeartRateMeasurement {
  HeartRateMeasurementDto toDto() {
    return HeartRateMeasurementDto(
      time: time.millisecondsSinceEpoch,
      beatsPerMinute: rate.toDto(),
    );
  }
}

/// Converts [HeartRateMeasurementDto] to [HeartRateMeasurement].
@sinceV1_0_0
@internal
extension HeartRateMeasurementDtoToDomain on HeartRateMeasurementDto {
  HeartRateMeasurement toDomain() {
    return HeartRateMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      rate: beatsPerMinute.toDomain(),
    );
  }
}
