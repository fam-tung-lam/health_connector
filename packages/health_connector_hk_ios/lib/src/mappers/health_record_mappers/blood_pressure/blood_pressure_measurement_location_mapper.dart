import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodPressureMeasurementLocation, sinceV1_2_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MeasurementLocationDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodPressureMeasurementLocation] to [MeasurementLocationDto].
@sinceV1_2_0
@internal
extension BloodPressureMeasurementLocationToDto
    on BloodPressureMeasurementLocation {
  MeasurementLocationDto toDto() {
    switch (this) {
      case BloodPressureMeasurementLocation.unknown:
        return MeasurementLocationDto.unknown;
      case BloodPressureMeasurementLocation.leftWrist:
        return MeasurementLocationDto.leftWrist;
      case BloodPressureMeasurementLocation.rightWrist:
        return MeasurementLocationDto.rightWrist;
      case BloodPressureMeasurementLocation.leftUpperArm:
        return MeasurementLocationDto.leftUpperArm;
      case BloodPressureMeasurementLocation.rightUpperArm:
        return MeasurementLocationDto.rightUpperArm;
    }
  }
}

/// Converts [MeasurementLocationDto] to [BloodPressureMeasurementLocation].
@sinceV1_2_0
@internal
extension MeasurementLocationDtoToDomain on MeasurementLocationDto {
  BloodPressureMeasurementLocation toDomain() {
    switch (this) {
      case MeasurementLocationDto.unknown:
        return BloodPressureMeasurementLocation.unknown;
      case MeasurementLocationDto.leftWrist:
        return BloodPressureMeasurementLocation.leftWrist;
      case MeasurementLocationDto.rightWrist:
        return BloodPressureMeasurementLocation.rightWrist;
      case MeasurementLocationDto.leftUpperArm:
        return BloodPressureMeasurementLocation.leftUpperArm;
      case MeasurementLocationDto.rightUpperArm:
        return BloodPressureMeasurementLocation.rightUpperArm;
    }
  }
}
