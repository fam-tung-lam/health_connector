import 'package:health_connector_core/health_connector_core_internal.dart'
    show SpeedMeasurement, sinceV2_0_0;
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SpeedMeasurementDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SpeedMeasurement] to [SpeedMeasurementDto].
@sinceV2_0_0
@internal
extension SpeedMeasurementToDto on SpeedMeasurement {
  SpeedMeasurementDto toDto() {
    return SpeedMeasurementDto(
      time: time.millisecondsSinceEpoch,
      speed: speed.toDto(),
    );
  }
}

/// Converts [SpeedMeasurementDto] to [SpeedMeasurement].
@sinceV2_0_0
@internal
extension SpeedMeasurementDtoToDomain on SpeedMeasurementDto {
  SpeedMeasurement toDomain() {
    return SpeedMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      speed: speed.toDomain(),
    );
  }
}
