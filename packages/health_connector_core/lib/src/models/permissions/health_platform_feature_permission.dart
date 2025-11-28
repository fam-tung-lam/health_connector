part of 'permission.dart';

/// Represents a permission request for a platform feature.
///
/// [HealthPlatformFeaturePermission] wraps a [HealthPlatformFeature] to enable
/// permission checking and requesting for feature-dependent functionality.
/// While features represent capabilities, feature permissions represent the
/// authorization to use those capabilities.
@sinceV1_0_0
@availableOnHealthConnect
@immutable
final class HealthPlatformFeaturePermission extends Permission {
  /// Creates a permission for the specified [feature].
  ///
  /// The [feature] parameter specifies which platform feature this
  /// permission is for.
  const HealthPlatformFeaturePermission(this.feature);

  /// The feature that this permission is for.
  ///
  /// This specifies which platform capability requires authorization.
  final HealthPlatformFeature feature;

  @override
  List<HealthPlatform> get supportedHealthPlatforms =>
      feature.supportedHealthPlatforms;

  @override
  String get name => feature.name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthPlatformFeaturePermission &&
          runtimeType == other.runtimeType &&
          feature == other.feature;

  @override
  int get hashCode => feature.hashCode;

  @override
  String toString() => 'permission_$name';
}
