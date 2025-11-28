import 'package:health_connector_annotation/health_connector_annotation.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/health_platform_data.dart';
import 'package:health_connector_core/src/models/health_platform_features/health_platform_feature.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:meta/meta.dart' show immutable;

part 'health_data_permission.dart';
part 'health_platform_feature_permission.dart';

/// Base interface for all permission types in the health client.
@sinceV1_0_0
sealed class Permission implements HealthPlatformData {
  const Permission();
}

/// Represents the permission status.
@sinceV1_0_0
enum PermissionStatus {
  /// Permission has been explicitly granted by the user.
  granted,

  /// Permission has been explicitly denied by the user.
  denied,

  /// The permission status cannot be determined.
  ///
  /// On iOS, HealthKit does not allow apps to determine whether read permission
  /// has been granted or denied for privacy reasons.
  /// As a result, read permissions will always return [unknown] even if
  /// the user has granted access.
  ///
  /// Note: Write permissions on iOS can still return [granted] or [denied].
  unknown,
}

/// Extension methods for filtering [List<Permission>] by permission type.
@sinceV1_0_0
extension PermissionListExtension on List<Permission> {
  /// Returns a list containing only [HealthDataPermission] instances.
  ///
  /// Filters the list to include only permissions that are instances of
  /// [HealthDataPermission], excluding any [HealthPlatformFeaturePermission]
  /// instances.
  List<HealthDataPermission> get healthDataPermissions =>
      whereType<HealthDataPermission>().toList();

  /// Returns a list containing only
  /// [HealthPlatformFeaturePermission] instances.
  ///
  /// Filters the list to include only permissions that are instances of
  /// [HealthPlatformFeaturePermission], excluding any [HealthDataPermission]
  /// instances.
  List<HealthPlatformFeaturePermission> get featurePermissions =>
      whereType<HealthPlatformFeaturePermission>().toList();
}
