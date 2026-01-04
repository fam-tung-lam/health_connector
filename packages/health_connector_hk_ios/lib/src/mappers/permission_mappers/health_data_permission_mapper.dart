import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthDataPermission, sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/health_data_permission_access_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthDataPermissionDto;
import 'package:meta/meta.dart' show internal;

/// Converts a single [HealthDataPermission] to [HealthDataPermissionDto].
@sinceV2_0_0
@internal
extension HealthDataPermissionToDto on HealthDataPermission {
  HealthDataPermissionDto toDto() {
    return HealthDataPermissionDto(
      healthDataType: dataType.toDto(),
      accessType: accessType.toDto(),
    );
  }
}
