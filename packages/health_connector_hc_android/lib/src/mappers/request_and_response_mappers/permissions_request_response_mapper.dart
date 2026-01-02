import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthDataPermission,
        HealthDataPermissionAccessType,
        HealthPlatformFeaturePermission,
        PermissionRequestResult,
        sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_platform_feature_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers/permission_status_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        PermissionRequestsResponseDto,
        HealthDataPermissionRequestResultDto,
        HealthPlatformFeaturePermissionRequestResultDto,
        PermissionAccessTypeDto;
import 'package:meta/meta.dart' show internal;

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
