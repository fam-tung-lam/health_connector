part of 'health_platform_feature.dart';

/// Feature representing background health data reading capabilities.
///
/// This feature allows an application to read health data while the app is
/// running in the background, without requiring a foreground service or user
/// interaction.
///
/// ## Platform Ecosystems
///
/// - **Android (Health Connect)**:
///   - Requires the `READ_HEALTH_DATA_IN_BACKGROUND` permission.
///   - This is a sensitive permission that requires additional justification
///     during Google Play Store review.
/// - **iOS (HealthKit)**:
///   - Supported via `HKObserverQuery` and Background Delivery.
///   - Requires enabling the "HealthKit" and "Background Modes" capabilities.
///
/// ## Permission
///
/// To use this feature, you must include it in your permission request:
///
/// ```dart
/// await HealthConnector.requestPermissions([
///   HealthPlatformFeature.readHealthDataInBackground.permission,
///   // ... other data type permissions
/// ]);
/// ```
@sinceV1_0_0
@immutable
final class HealthPlatformFeatureReadHealthDataInBackground
    extends HealthPlatformFeature {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthPlatformFeatureReadHealthDataInBackground &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
