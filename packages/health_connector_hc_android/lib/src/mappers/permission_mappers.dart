import 'package:health_connector_core/health_connector_core.dart'
    show
        Permission,
        HealthDataPermission,
        HealthDataPermissionAccessType,
        HealthPlatformFeaturePermission,
        PermissionStatus,
        PermissionRequestResult,
        sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/'
    'health_platform_feature_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        PermissionsRequestDto,
        HealthDataPermissionDto,
        PermissionAccessTypeDto,
        HealthPlatformFeatureDto,
        PermissionsRequestResponseDto,
        PermissionStatusDto;
import 'package:meta/meta.dart' show internal;

/// Converts [List<Permission>] to [PermissionsRequestDto].
@sinceV1_0_0
@internal
extension PermissionsListToDto on List<Permission> {
  /// Converts a list of [Permission] objects to a [PermissionsRequestDto].
  PermissionsRequestDto toDto() {
    final healthDataPermissions = <HealthDataPermissionDto>[];
    final featurePermissions = <HealthPlatformFeatureDto>[];

    for (final permission in this) {
      switch (permission) {
        case HealthDataPermission _:
          healthDataPermissions.add(
            HealthDataPermissionDto(
              healthDataType: permission.dataType.toDto(),
              accessType:
                  permission.accessType == HealthDataPermissionAccessType.read
                  ? PermissionAccessTypeDto.read
                  : PermissionAccessTypeDto.write,
            ),
          );
        case HealthPlatformFeaturePermission _:
          featurePermissions.add(permission.feature.toDto());
      }
    }

    return PermissionsRequestDto(
      healthDataPermissions: healthDataPermissions,
      featurePermissions: featurePermissions,
    );
  }
}

/// Converts [PermissionsRequestResponseDto] to [List<PermissionRequestResult>].
@sinceV1_0_0
@internal
extension PermissionsRequestResponseDtoToDomain
    on PermissionsRequestResponseDto {
  List<PermissionRequestResult> toDomain() {
    final results = <PermissionRequestResult>[];

    for (final healthDataResult in healthDataPermissionResults) {
      results.add(
        PermissionRequestResult(
          permission: HealthDataPermission(
            dataType: healthDataResult.permission.healthDataType.toDomain(),
            accessType:
                healthDataResult.permission.accessType ==
                    PermissionAccessTypeDto.read
                ? HealthDataPermissionAccessType.read
                : HealthDataPermissionAccessType.write,
          ),
          status: healthDataResult.status.toDomain(),
        ),
      );
    }

    for (final featureResult in featurePermissionResults) {
      results.add(
        PermissionRequestResult(
          permission: HealthPlatformFeaturePermission(
            featureResult.feature.toDomain(),
          ),
          status: featureResult.status.toDomain(),
        ),
      );
    }

    return results;
  }
}

/// Converts [PermissionStatusDto] to [PermissionStatus].
@sinceV1_0_0
@internal
extension PermissionStatusDtoToDomain on PermissionStatusDto {
  PermissionStatus toDomain() {
    switch (this) {
      case PermissionStatusDto.granted:
        return PermissionStatus.granted;
      case PermissionStatusDto.denied:
        return PermissionStatus.denied;
      case PermissionStatusDto.unknown:
        return PermissionStatus.unknown;
    }
  }
}
