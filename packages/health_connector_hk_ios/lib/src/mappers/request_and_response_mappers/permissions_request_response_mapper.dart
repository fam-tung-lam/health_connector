import 'package:health_connector_core/health_connector_core.dart'
    show
        HealthDataPermission,
        HealthDataPermissionAccessType,
        PermissionRequestResult,
        sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/permission_status_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PermissionsRequestResponseDto, PermissionAccessTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PermissionsRequestResponseDto] to [List<PermissionRequestResult>].
@sinceV1_0_0
@internal
extension PermissionsRequestResponseDtoToDomain
    on PermissionsRequestResponseDto {
  List<PermissionRequestResult> toDomain() {
    return healthDataPermissionResults
        .map(
          (result) => PermissionRequestResult(
            permission: HealthDataPermission(
              dataType: result.permission.healthDataType.toDomain(),
              accessType:
                  result.permission.accessType == PermissionAccessTypeDto.read
                  ? HealthDataPermissionAccessType.read
                  : HealthDataPermissionAccessType.write,
            ),
            status: result.status.toDomain(),
          ),
        )
        .toList();
  }
}
