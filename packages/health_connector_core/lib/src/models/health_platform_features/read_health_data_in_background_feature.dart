part of 'health_platform_feature.dart';

/// Feature representing background health data reading capabilities.
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
