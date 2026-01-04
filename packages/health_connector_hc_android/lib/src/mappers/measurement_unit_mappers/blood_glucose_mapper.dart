import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodGlucose;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show BloodGlucoseDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodGlucose] to [BloodGlucoseDto].
@internal
extension BloodGlucoseToDto on BloodGlucose {
  BloodGlucoseDto toDto() {
    // Uses millimoles per liter as the transfer unit for consistency.
    return BloodGlucoseDto(
      millimolesPerLiter: inMillimolesPerLiter,
    );
  }
}

/// Converts [BloodGlucoseDto] to [BloodGlucose].
@internal
extension BloodGlucoseDtoToDomain on BloodGlucoseDto {
  BloodGlucose toDomain() {
    return BloodGlucose.millimolesPerLiter(millimolesPerLiter);
  }
}
