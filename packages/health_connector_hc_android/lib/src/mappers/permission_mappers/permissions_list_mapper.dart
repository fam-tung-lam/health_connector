import 'package:health_connector_core/health_connector_core.dart'
    show Permission, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/permission_mappers/permission_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PermissionRequestsDto;
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
