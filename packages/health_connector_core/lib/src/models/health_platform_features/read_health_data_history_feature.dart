part of 'health_platform_feature.dart';

/// Feature representing historical health data reading capabilities.
///
/// This feature allows an application to read health data that was created
/// before the current application was installed or before the current
/// permission grant.
///
/// ## Platform Behaviors
///
/// - **Android Health Connect**: Feature might not be available depending on
///   Android or Health Connect versions. If available, usage requires the
///   `READ_HEALTH_DATA_HISTORY` permission.
/// - **iOS HealthKit**: Available by default. No permission request is
///   needed, though users can restrict the read scope in system settings.
///
/// ## Permission
///
/// If available, you must include it in your permission request to use it:
///
/// ```dart
/// await HealthConnector.requestPermissions([
///   HealthPlatformFeature.readDataHistory.permission,
///   // ... other data type permissions
/// ]);
/// ```
@sinceV1_0_0
@immutable
final class HealthPlatformFeatureReadDataHistory extends HealthPlatformFeature {
  /// Creates a instance of [HealthPlatformFeatureReadDataHistory].
  @internalUse
  const HealthPlatformFeatureReadDataHistory();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthPlatformFeatureReadDataHistory &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
