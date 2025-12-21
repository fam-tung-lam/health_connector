import 'package:health_connector_core/health_connector_core.dart'
    show BloodGlucose;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show BloodGlucoseDto, BloodGlucoseUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodGlucose] to [BloodGlucoseDto].
@internal
extension BloodGlucoseToDto on BloodGlucose {
  BloodGlucoseDto toDto() {
    // Uses millimoles per liter as the transfer unit for consistency.
    return BloodGlucoseDto(
      value: inMillimolesPerLiter,
      unit: BloodGlucoseUnitDto.millimolesPerLiter,
    );
  }
}

/// Converts [BloodGlucoseDto] to [BloodGlucose].
@internal
extension BloodGlucoseDtoToDomain on BloodGlucoseDto {
  BloodGlucose toDomain() {
    switch (unit) {
      case BloodGlucoseUnitDto.millimolesPerLiter:
        return BloodGlucose.millimolesPerLiter(value);
      case BloodGlucoseUnitDto.milligramsPerDeciliter:
        return BloodGlucose.milligramsPerDeciliter(value);
    }
  }
}
