part of 'health_platform_feature.dart';

/// Feature representing historical health data reading capabilities.
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
