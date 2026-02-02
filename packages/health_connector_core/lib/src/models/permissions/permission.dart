import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/health_platform_data.dart';
import 'package:health_connector_core/src/models/health_platform_features/health_platform_feature.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:meta/meta.dart' show immutable;

part 'exercise_route_permission.dart';
part 'health_data_permission.dart';
part 'health_platform_feature_permission.dart';

/// Base interface for all permission types in the health client.
///
/// {@category Permissions}
@sinceV1_0_0
@internalUse
sealed class Permission implements HealthPlatformData {
  /// Creates a base permission.
  const Permission();
}

/// Represents the permission status.
///
/// {@category Permissions}
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
