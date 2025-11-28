import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/models/operating_system.dart';

/// Represents the available health platform APIs.
@sinceV1_0_0
enum HealthPlatform {
  /// Apple Health (HealthKit) on iOS.
  appleHealth(OperatingSystem.iOS),

  /// Health Connect on Android.
  healthConnect(OperatingSystem.android);

  const HealthPlatform(this.os);

  final OperatingSystem os;
}

/// Represents the availability status of the health platform on the device.
///
/// The health platform refers to [HealthPlatform].
@sinceV1_0_0
enum HealthPlatformStatus {
  /// Health platform is unavailable on this device.
  unavailable,

  /// Health platform APIs are currently unavailable because
  /// the provider is either not installed or needs to be updated.
  ///
  /// Note: Android only.
  installationOrUpdateRequired,

  /// Health platform is available and functional on the device.
  available,
}
