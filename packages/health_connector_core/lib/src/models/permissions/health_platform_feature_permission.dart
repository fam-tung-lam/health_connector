part of 'permission.dart';

/// Represents a permission request for a platform feature.
///
/// {@category Permissions}
@sinceV1_0_0
@immutable
final class HealthPlatformFeaturePermission extends Permission {
  /// Creates a permission for the specified [feature].
  ///
  /// ## Parameters
  ///
  /// - [feature]: The platform feature this permission is for.
  @internalUse
  const HealthPlatformFeaturePermission(this.feature);

  /// The feature that this permission is for.
  ///
  /// This specifies which platform capability requires authorization.
  final HealthPlatformFeature feature;

  @override
  List<HealthPlatform> get supportedHealthPlatforms =>
      feature.supportedHealthPlatforms;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthPlatformFeaturePermission &&
          runtimeType == other.runtimeType &&
          feature == other.feature;

  @override
  int get hashCode => feature.hashCode;
}
