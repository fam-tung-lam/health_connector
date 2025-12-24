import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodGlucose, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BloodGlucoseDto, BloodGlucoseUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodGlucose] to [BloodGlucoseDto].
@sinceV1_0_0
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
@sinceV1_0_0
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
