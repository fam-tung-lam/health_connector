part of 'permission.dart';

/// Represents a permission request for accessing exercise route data.
///
/// Exercise routes contain GPS location data recorded during exercise sessions.
/// Due to the sensitive nature of location data, route access requires separate
/// permissions from regular exercise session access.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**:
///   - Read: `READ_EXERCISE_ROUTES` (plural)
///   - Write: `WRITE_EXERCISE_ROUTE` (singular)
/// - **iOS HealthKit**: `HKSeriesType.workoutRoute()` authorization
///
/// ## Usage
///
/// ```dart
/// final permissions = await connector.requestPermissions([
///   HealthDataType.exerciseSession.readPermission,
///   HealthDataType.exerciseSession.writePermission,
///   ExerciseRoutePermission.read,
///   ExerciseRoutePermission.write,
/// ]);
/// ```
///
/// {@category Permissions}
@sinceV3_8_0
@immutable
final class ExerciseRoutePermission extends Permission {
  /// Creates an exercise route permission.
  ///
  /// Prefer using [read] or [write] constants instead.
  const ExerciseRoutePermission._(this.accessType);

  /// Permission to read exercise route data.
  ///
  /// Note: On Android, reading third-party routes may require additional
  /// per-route consent, which is handled automatically by the SDK.
  static const read = ExerciseRoutePermission._(
    HealthDataPermissionAccessType.read,
  );

  /// Permission to write exercise route data.
  static const write = ExerciseRoutePermission._(
    HealthDataPermissionAccessType.write,
  );

  /// The type of access being requested.
  final HealthDataPermissionAccessType accessType;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseRoutePermission &&
          runtimeType == other.runtimeType &&
          accessType == other.accessType;

  @override
  int get hashCode => accessType.hashCode;
}
