import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthDataPermissionAccessType;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PermissionAccessTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthDataPermissionAccessType] to [PermissionAccessTypeDto].
@internal
extension HealthDataPermissionAccessTypeToDto
    on HealthDataPermissionAccessType {
  PermissionAccessTypeDto toDto() {
    switch (this) {
      case HealthDataPermissionAccessType.read:
        return PermissionAccessTypeDto.read;
      case HealthDataPermissionAccessType.write:
        return PermissionAccessTypeDto.write;
    }
  }
}
