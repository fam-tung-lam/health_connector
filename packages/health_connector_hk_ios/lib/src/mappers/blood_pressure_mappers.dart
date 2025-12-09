import 'package:health_connector_core/health_connector_core.dart'
    show BloodPressureBodyPosition, BloodPressureMeasurementLocation;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show BodyPositionDto, MeasurementLocationDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodPressureBodyPosition] to [BodyPositionDto].
@internal
extension BloodPressureBodyPositionToDto on BloodPressureBodyPosition {
  BodyPositionDto toDto() {
    switch (this) {
      case BloodPressureBodyPosition.unknown:
        return BodyPositionDto.unknown;
      case BloodPressureBodyPosition.standingUp:
        return BodyPositionDto.standingUp;
      case BloodPressureBodyPosition.sittingDown:
        return BodyPositionDto.sittingDown;
      case BloodPressureBodyPosition.lyingDown:
        return BodyPositionDto.lyingDown;
      case BloodPressureBodyPosition.reclining:
        return BodyPositionDto.reclining;
    }
  }
}

/// Converts [BodyPositionDto] to [BloodPressureBodyPosition].
@internal
extension BodyPositionDtoToDomain on BodyPositionDto {
  BloodPressureBodyPosition toDomain() {
    switch (this) {
      case BodyPositionDto.unknown:
        return BloodPressureBodyPosition.unknown;
      case BodyPositionDto.standingUp:
        return BloodPressureBodyPosition.standingUp;
      case BodyPositionDto.sittingDown:
        return BloodPressureBodyPosition.sittingDown;
      case BodyPositionDto.lyingDown:
        return BloodPressureBodyPosition.lyingDown;
      case BodyPositionDto.reclining:
        return BloodPressureBodyPosition.reclining;
    }
  }
}

/// Converts [BloodPressureMeasurementLocation] to [MeasurementLocationDto].
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
