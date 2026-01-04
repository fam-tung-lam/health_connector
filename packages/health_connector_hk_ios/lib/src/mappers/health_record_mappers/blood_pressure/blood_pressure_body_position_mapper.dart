import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodPressureBodyPosition, sinceV1_2_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BodyPositionDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodPressureBodyPosition] to [BodyPositionDto].
@sinceV1_2_0
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
@sinceV1_2_0
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
