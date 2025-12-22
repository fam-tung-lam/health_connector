part of 'health_platform_feature.dart';

/// Feature representing historical health data reading capabilities.
///
/// This feature allows an application to read health data that was created
/// before the current application was installed or before the current
/// permission grant.
///
/// ## Platform Ecosystems
///
/// - **Android (Health Connect)**: Requires the `READ_HEALTH_DATA_HISTORY`
///   permission. This is a sensitive permission that may require additional
///   justification during Google Play Store review.
/// - **iOS (HealthKit)**: implicit capability, but users can restrict the
///   read scope in system settings.
///
/// ## Permission
///
/// To use this feature, you must include it in your permission request:
///
/// ```dart
/// await HealthConnector.requestPermissions([
///   HealthPlatformFeature.readHealthDataHistory.permission,
///   // ... other data type permissions
/// ]);
/// ```
@sinceV1_0_0
@immutable
final class HealthPlatformFeatureReadHealthDataHistory
    extends HealthPlatformFeature {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthPlatformFeatureReadHealthDataHistory &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
