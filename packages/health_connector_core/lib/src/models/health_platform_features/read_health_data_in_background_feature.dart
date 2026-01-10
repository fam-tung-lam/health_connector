part of 'health_platform_feature.dart';

/// Feature representing background health data reading capabilities.
///
/// This feature allows an application to read health data while the app is
/// running in the background, without requiring a foreground service or user
/// interaction.
///
/// ## Platform Behaviors
///
/// - **Android Health Connect**: Feature might not be available depending on
///   Android or Health Connect versions. If available, usage requires the
///   `READ_HEALTH_DATA_IN_BACKGROUND` permission.
///   - This is a sensitive permission that requires additional justification
///     during Google Play Store review.
/// - **iOS HealthKit**: Available by default if the app has the "HealthKit"
///   and "Background Modes" capabilities enabled. No permission request is
///   needed, though users can restrict the background updates in system
///   settings.
///
/// ## Permission
///
/// If available, you must include it in your permission request to use it:
///
/// ```dart
/// await HealthConnector.requestPermissions([
///   HealthPlatformFeature.readDataInBackground.permission,
///   // ... other data type permissions
/// ]);
/// ```
@sinceV1_0_0
@immutable
final class HealthPlatformFeatureReadDataInBackground
    extends HealthPlatformFeature {
  /// Creates a instance of [HealthPlatformFeatureReadDataInBackground].
  @internalUse
  const HealthPlatformFeatureReadDataInBackground();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthPlatformFeatureReadDataInBackground &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
