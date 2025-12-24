import 'package:health_connector_core/health_connector_core_internal.dart'
    show PermissionStatus, sinceV1_0_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PermissionStatusDto;
import 'package:meta/meta.dart' show internal;

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
