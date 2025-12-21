import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/health_platform_data.dart';
import 'package:health_connector_core/src/models/permissions/permission.dart';
import 'package:meta/meta.dart' show immutable;

part 'read_health_data_history_feature.dart';
part 'read_health_data_in_background_feature.dart';

/// Represents a feature available in health platforms.
///
/// Features are capabilities or functionalities provided by health platforms
/// that may or may not be available on a given device or platform version.
@sinceV1_0_0
@availableOnHealthConnect
sealed class HealthPlatformFeature implements HealthPlatformData {
  /// Returns the permission associated with this feature.
  HealthPlatformFeaturePermission get permission =>
      HealthPlatformFeaturePermission(this);

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  /// Historical health data reading capability.
  ///
  /// Allows reading historical health data.
  static final readHealthDataHistory =
      HealthPlatformFeatureReadHealthDataHistory();

  /// Background health data reading capability.
  ///
  /// Allows reading health data in the background.
  static final readHealthDataInBackground =
      HealthPlatformFeatureReadHealthDataInBackground();

  /// Returns a list of all available health platform features.
  static final List<HealthPlatformFeature> values = [
    readHealthDataHistory,
    readHealthDataInBackground,
  ];
}

/// Represents the availability status of a platform feature.
@sinceV1_0_0
@availableOnHealthConnect
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
