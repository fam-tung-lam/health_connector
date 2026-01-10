import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthPlatformFeature,
        HealthPlatformFeatureReadDataHistory,
        HealthPlatformFeatureReadDataInBackground,
        HealthPlatformFeatureStatus,
        sinceV1_0_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HealthPlatformFeatureDto, HealthPlatformFeatureStatusDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthPlatformFeature] to [HealthPlatformFeatureDto].
@sinceV1_0_0
@internal
extension HealthPlatformFeatureToDto on HealthPlatformFeature {
  HealthPlatformFeatureDto toDto() {
    switch (this) {
      case HealthPlatformFeatureReadDataHistory _:
        return HealthPlatformFeatureDto.readDataHistory;
      case HealthPlatformFeatureReadDataInBackground _:
        return HealthPlatformFeatureDto.readDataInBackground;
    }
  }
}

/// Converts [HealthPlatformFeatureDto] to [HealthPlatformFeature].
@sinceV1_0_0
@internal
extension HealthPlatformFeatureDtoToDomain on HealthPlatformFeatureDto {
  HealthPlatformFeature toDomain() {
    switch (this) {
      case HealthPlatformFeatureDto.readDataHistory:
        return HealthPlatformFeature.readDataHistory;
      case HealthPlatformFeatureDto.readDataInBackground:
        return HealthPlatformFeature.readDataInBackground;
    }
  }
}

/// Converts [HealthPlatformFeatureStatusDto] to [HealthPlatformFeatureStatus].
@sinceV1_0_0
@internal
extension HealthPlatformFeatureStatusDtoToDomain
    on HealthPlatformFeatureStatusDto {
  HealthPlatformFeatureStatus toDomain() {
    switch (this) {
      case HealthPlatformFeatureStatusDto.available:
        return HealthPlatformFeatureStatus.available;
      case HealthPlatformFeatureStatusDto.unavailable:
        return HealthPlatformFeatureStatus.unavailable;
    }
  }
}

/// Converts [HealthPlatformFeatureStatus] to [HealthPlatformFeatureStatusDto].
@sinceV1_0_0
@internal
extension HealthPlatformFeatureStatusToDto on HealthPlatformFeatureStatus {
  HealthPlatformFeatureStatusDto toDto() {
    switch (this) {
      case HealthPlatformFeatureStatus.available:
        return HealthPlatformFeatureStatusDto.available;
      case HealthPlatformFeatureStatus.unavailable:
        return HealthPlatformFeatureStatusDto.unavailable;
    }
  }
}
