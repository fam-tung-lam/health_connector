import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        ExerciseRoutePermission,
        HealthDataPermission,
        HealthDataPermissionAccessType,
        PermissionRequestResult,
        UserCharacteristicPermission;
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/permission_status_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/user_characteristic_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        ExerciseRoutePermissionRequestResultDto,
        HealthDataPermissionRequestResultDto,
        PermissionAccessTypeDto,
        PermissionRequestResultDto,
        UserCharacteristicPermissionRequestResultDto;
import 'package:meta/meta.dart' show internal;

/// Converts list of [PermissionRequestResultDto] to
/// list of [PermissionRequestResult].
@internal
extension PermissionRequestResultDtoListToDomain
    on List<PermissionRequestResultDto> {
  List<PermissionRequestResult> toDomain() {
    return map(_convertResult).toList();
  }

  PermissionRequestResult _convertResult(PermissionRequestResultDto result) {
    return switch (result) {
      UserCharacteristicPermissionRequestResultDto() => PermissionRequestResult(
        permission: UserCharacteristicPermission(
          characteristicType: result.permission.characteristicType.toDomain(),
        ),
        status: result.status.toDomain(),
      ),
      HealthDataPermissionRequestResultDto() => PermissionRequestResult(
        permission: HealthDataPermission(
          dataType: result.permission.healthDataType.toDomain(),
          accessType:
              result.permission.accessType == PermissionAccessTypeDto.read
              ? HealthDataPermissionAccessType.read
              : HealthDataPermissionAccessType.write,
        ),
        status: result.status.toDomain(),
      ),
      ExerciseRoutePermissionRequestResultDto() => PermissionRequestResult(
        permission: result.permission.accessType == PermissionAccessTypeDto.read
            ? ExerciseRoutePermission.read
            : ExerciseRoutePermission.write,
        status: result.status.toDomain(),
      ),
    };
  }
}
