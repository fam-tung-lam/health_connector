import 'package:health_connector_core/health_connector_core.dart'
    show
        Permission,
        HealthDataPermission,
        HealthDataPermissionAccessType,
        HealthPlatformFeaturePermission,
        sinceV2_0_0;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_platform_feature_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        HealthDataPermissionRequestDto,
        HealthPlatformFeaturePermissionRequest,
        PermissionAccessTypeDto,
        PermissionRequestDto;
import 'package:meta/meta.dart' show internal;

/// Converts a single [Permission] to [PermissionRequestDto].
@sinceV2_0_0
@internal
extension PermissionToDto on Permission {
  PermissionRequestDto toDto() {
    return switch (this) {
      final HealthDataPermission p => HealthDataPermissionRequestDto(
        healthDataType: p.dataType.toDto(),
        accessType: p.accessType == HealthDataPermissionAccessType.read
            ? PermissionAccessTypeDto.read
            : PermissionAccessTypeDto.write,
      ),
      final HealthPlatformFeaturePermission p =>
        HealthPlatformFeaturePermissionRequest(
          feature: p.feature.toDto(),
        ),
    };
  }
}
