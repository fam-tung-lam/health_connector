import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthDataPermission,
        HealthDataPermissionAccessType,
        HealthPlatformFeaturePermission,
        PermissionRequestResult,
        sinceV1_0_0,
        sinceV2_3_2;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_platform_feature_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers/permission_status_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        HealthDataPermissionRequestResultDto,
        HealthPlatformFeaturePermissionRequestResultDto,
        PermissionAccessTypeDto,
        PermissionRequestResultDto;
import 'package:meta/meta.dart' show internal;

/// Converts list of [PermissionRequestResultDto] to list of
/// [PermissionRequestResult].
@sinceV1_0_0
@internal
extension PermissionsRequestResponseDtoToDomain
    on List<PermissionRequestResultDto> {
  List<PermissionRequestResult> toDomain() {
    return map(
      (result) {
        return switch (result) {
          final HealthDataPermissionRequestResultDto _ => result.toDomain(),
          final HealthPlatformFeaturePermissionRequestResultDto _ =>
            result.toDomain(),
        };
      },
    ).toList();
  }
}

/// Converts [HealthDataPermissionRequestResultDto] to
/// [PermissionRequestResult].
@sinceV2_3_2
@internal
extension HealthDataPermissionRequestResultDtoToDomain
    on HealthDataPermissionRequestResultDto {
  PermissionRequestResult toDomain() {
    return PermissionRequestResult(
      permission: HealthDataPermission(
        dataType: permission.healthDataType.toDomain(),
        accessType: permission.accessType == PermissionAccessTypeDto.read
            ? HealthDataPermissionAccessType.read
            : HealthDataPermissionAccessType.write,
      ),
      status: status.toDomain(),
    );
  }
}

/// Converts [HealthPlatformFeaturePermissionRequestResultDto] to
/// [PermissionRequestResult].
@sinceV2_3_2
@internal
extension HealthPlatformFeaturePermissionRequestResultDtoToDomain
    on HealthPlatformFeaturePermissionRequestResultDto {
  PermissionRequestResult toDomain() {
    return PermissionRequestResult(
      permission: HealthPlatformFeaturePermission(
        feature.toDomain(),
      ),
      status: status.toDomain(),
    );
  }
}
