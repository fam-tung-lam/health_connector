import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart';

/// Extension to convert [ActivityIntensityType] to [ActivityIntensityTypeDto].
@sinceV3_2_0
@internal
extension ActivityIntensityTypeToDto on ActivityIntensityType {
  ActivityIntensityTypeDto toDto() {
    switch (this) {
      case ActivityIntensityType.moderate:
        return ActivityIntensityTypeDto.moderate;
      case ActivityIntensityType.vigorous:
        return ActivityIntensityTypeDto.vigorous;
    }
  }
}

/// Extension to convert [ActivityIntensityTypeDto] to [ActivityIntensityType].
@sinceV3_2_0
@internal
extension ActivityIntensityTypeDtoToDomain on ActivityIntensityTypeDto {
  ActivityIntensityType toDomain() {
    switch (this) {
      case ActivityIntensityTypeDto.moderate:
        return ActivityIntensityType.moderate;
      case ActivityIntensityTypeDto.vigorous:
        return ActivityIntensityType.vigorous;
    }
  }
}
