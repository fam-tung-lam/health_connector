import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/health_platform_requirements/health_platform_requirement.dart';
import 'package:health_connector_core/src/models/permissions/permission.dart';
import 'package:meta/meta.dart' show immutable;

part 'read_health_data_history_feature.dart';
part 'read_health_data_in_background_feature.dart';

/// Features are capabilities or functionalities provided by health platforms
/// that may or may not be available on a given device or platform version.
@sinceV1_0_0
@immutable
sealed class HealthPlatformFeature {
  @internalUse
  const HealthPlatformFeature();

  /// Returns the permission associated with this feature.
  HealthPlatformFeaturePermission get permission =>
      HealthPlatformFeaturePermission(this);

  @sinceV4_0_0
  List<HealthPlatformRequirement> get healthPlatformRequirements =>
      HealthPlatformRequirement.allPlatforms;

  /// The health platforms that support this feature.
  @Deprecated(
    'Use healthPlatformRequirements.supportedHealthPlatforms instead. '
    'Will be removed in 4.1.0.',
  )
  List<HealthPlatform> get supportedHealthPlatforms =>
      healthPlatformRequirements.supportedHealthPlatforms;

  /// Historical health data reading capability.
  ///
  /// See [HealthPlatformFeatureReadHealthDataHistory] for details on
  /// platform support and usage.
  static const readHealthDataHistory =
      HealthPlatformFeatureReadHealthDataHistory();

  /// Background health data reading capability.
  ///
  /// See [HealthPlatformFeatureReadHealthDataInBackground] for details on
  /// platform support and usage.
  static const readHealthDataInBackground =
      HealthPlatformFeatureReadHealthDataInBackground();

  /// Returns a list of all available health platform features.
  static final List<HealthPlatformFeature> values = [
    readHealthDataHistory,
    readHealthDataInBackground,
  ];
}

/// Represents the availability status of a platform feature.
@sinceV1_0_0
enum HealthPlatformFeatureStatus {
  /// The feature is available and can be used on this device/platform.
  ///
  /// When a feature has this status, it is safe to use the associated
  /// functionality. However, note that permissions may still need to be
  /// requested separately.
  available,

  /// The feature is not available on this device/platform.
  ///
  /// This status indicates that either:
  /// - The platform version doesn't support this feature
  /// - The device doesn't have the required capabilities
  /// - The feature hasn't been enabled by the health platform
  unavailable,
}
