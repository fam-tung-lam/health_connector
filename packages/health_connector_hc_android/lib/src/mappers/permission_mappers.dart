import 'package:health_connector_core/health_connector_core.dart'
    show
        Permission,
        HealthDataPermission,
        HealthDataPermissionAccessType,
        HealthPlatformFeaturePermission,
        PermissionStatus,
        PermissionRequestResult,
        sinceV1_0_0,
        sinceV2_0_0;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/'
    'health_platform_feature_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        PermissionRequestsDto,
        HealthDataPermissionRequestDto,
        HealthPlatformFeaturePermissionRequest,
        PermissionAccessTypeDto,
        PermissionRequestsResponseDto,
        HealthDataPermissionRequestResultDto,
        HealthPlatformFeaturePermissionRequestResultDto,
        PermissionStatusDto,
        PermissionRequestDto;
import 'package:meta/meta.dart' show internal;

/// Converts [List<Permission>] to [PermissionRequestsDto].
@sinceV1_0_0
@internal
extension PermissionsListToDto on List<Permission> {
  /// Converts a list of [Permission] objects to a [PermissionRequestsDto].
  PermissionRequestsDto toDto() {
    final permissionRequests = map(
      (permission) => permission.toDto(),
    ).toList();

    return PermissionRequestsDto(permissionRequests: permissionRequests);
  }
}

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

/// Converts [PermissionRequestsResponseDto] to [List<PermissionRequestResult>].
@sinceV1_0_0
@internal
extension PermissionsRequestResponseDtoToDomain
    on PermissionRequestsResponseDto {
  List<PermissionRequestResult> toDomain() {
    return permissionResults.map((result) {
      return switch (result) {
        final HealthDataPermissionRequestResultDto r => PermissionRequestResult(
          permission: HealthDataPermission(
            dataType: r.permission.healthDataType.toDomain(),
            accessType: r.permission.accessType == PermissionAccessTypeDto.read
                ? HealthDataPermissionAccessType.read
                : HealthDataPermissionAccessType.write,
          ),
          status: r.status.toDomain(),
        ),
        final HealthPlatformFeaturePermissionRequestResultDto r =>
          PermissionRequestResult(
            permission: HealthPlatformFeaturePermission(
              r.feature.toDomain(),
            ),
            status: r.status.toDomain(),
          ),
      };
    }).toList();
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
