import 'package:health_connector_core/health_connector_core_internal.dart'
    show PowerMeasurement, sinceV2_1_0;
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PowerMeasurementDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PowerMeasurement] to [PowerMeasurementDto].
@sinceV2_1_0
@internal
extension PowerSampleToDto on PowerMeasurement {
  PowerMeasurementDto toDto() {
    return PowerMeasurementDto(
      time: time.millisecondsSinceEpoch,
      power: power.toDto(),
    );
  }
}

/// Converts [PowerMeasurementDto] to [PowerMeasurement].
@sinceV2_1_0
@internal
extension PowerSampleDtoToDomain on PowerMeasurementDto {
  PowerMeasurement toDomain() {
    return PowerMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      power: power.toDomain(),
    );
  }
}
