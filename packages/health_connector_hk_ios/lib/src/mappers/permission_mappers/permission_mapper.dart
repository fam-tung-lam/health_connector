import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        ExerciseRoutePermission,
        HealthDataPermission,
        HealthDataPermissionAccessType,
        HealthPlatformFeaturePermission,
        InvalidArgumentException,
        Permission;
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        ExerciseRoutePermissionRequestDto,
        HealthDataPermissionRequestDto,
        PermissionAccessTypeDto,
        PermissionRequestDto;
import 'package:meta/meta.dart' show internal;

export 'health_data_permission_access_type_mapper.dart';
export 'permission_status_mapper.dart';
export 'permissions_list_mapper.dart';

/// Converts a [Permission] to [PermissionRequestDto].
///
/// This extension provides a unified conversion for all permission types
/// (health data and exercise route) to their corresponding DTOs.
@internal
extension PermissionToDto on Permission {
  /// Converts this permission to the appropriate [PermissionRequestDto].
  ///
  /// Uses pattern matching to handle different permission types:
  /// - [HealthDataPermission] → [HealthDataPermissionRequestDto]
  /// - [ExerciseRoutePermission] → [ExerciseRoutePermissionRequestDto]
  /// - [HealthPlatformFeaturePermission] → throws [InvalidArgumentException]
  PermissionRequestDto toDto() {
    return switch (this) {
      final HealthDataPermission p => HealthDataPermissionRequestDto(
        healthDataType: p.dataType.toDto(),
        accessType: p.accessType == HealthDataPermissionAccessType.read
            ? PermissionAccessTypeDto.read
            : PermissionAccessTypeDto.write,
      ),
      final ExerciseRoutePermission p => ExerciseRoutePermissionRequestDto(
        accessType: p.accessType == HealthDataPermissionAccessType.read
            ? PermissionAccessTypeDto.read
            : PermissionAccessTypeDto.write,
      ),
      HealthPlatformFeaturePermission() => throw InvalidArgumentException(
        '$HealthPlatformFeaturePermission is not supported on iOS. '
        'Feature permissions are auto-granted on HealthKit.',
      ),
    };
  }
}
