import 'package:health_connector_core/health_connector_core_internal.dart'
    show CyclingPedalingCadenceMeasurement, sinceV2_2_0;
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show CyclingPedalingCadenceMeasurementDto;
import 'package:meta/meta.dart' show internal;

/// Converts [CyclingPedalingCadenceMeasurement] to
/// [CyclingPedalingCadenceMeasurementDto].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceMeasurementToDto
    on CyclingPedalingCadenceMeasurement {
  CyclingPedalingCadenceMeasurementDto toDto() {
    return CyclingPedalingCadenceMeasurementDto(
      time: time.millisecondsSinceEpoch,
      revolutionsPerMinute: cadence.toDto(),
    );
  }
}

/// Converts [CyclingPedalingCadenceMeasurementDto] to
/// [CyclingPedalingCadenceMeasurement].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceMeasurementDtoToDomain
    on CyclingPedalingCadenceMeasurementDto {
  CyclingPedalingCadenceMeasurement toDomain() {
    return CyclingPedalingCadenceMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      cadence: revolutionsPerMinute.toDomain(),
    );
  }
}
