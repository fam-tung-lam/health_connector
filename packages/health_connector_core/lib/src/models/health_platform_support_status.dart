import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_platform_requirements/health_platform_requirement.dart';
import 'package:meta/meta.dart' show immutable;

/// Whether a device satisfies a list of health platform requirements.
@sinceV4_0_0
sealed class HealthPlatformSupportStatus {
  /// Creates a health platform support status.
  const HealthPlatformSupportStatus();

  /// Whether the requirements are satisfied.
  bool get isSupported;
}

/// The requirements are satisfied by the current device.
@sinceV4_0_0
@immutable
final class HealthPlatformSupported extends HealthPlatformSupportStatus {
  /// Creates a supported status.
  const HealthPlatformSupported();

  @override
  bool get isSupported => true;
}

/// The requirements are not satisfied by the current device.
@sinceV4_0_0
@immutable
final class HealthPlatformNotSupported extends HealthPlatformSupportStatus {
  /// Creates a not-supported status.
  const HealthPlatformNotSupported({
    required this.reason,
    required this.message,
    this.requirement,
  });

  /// Why the requirements are not satisfied.
  final HealthPlatformNotSupportedReason reason;

  /// A human-readable explanation of the failed requirement.
  final String message;

  /// The failed requirement, or `null` when the platform is unsupported.
  final HealthPlatformRequirement? requirement;

  @override
  bool get isSupported => false;
}

/// Reasons health platform requirements may not be satisfied.
@sinceV4_0_0
enum HealthPlatformNotSupportedReason {
  /// No requirement exists for the current health platform.
  healthPlatform,

  /// The Android API level or iOS version is too old.
  operatingSystemVersion,

  /// The required Android SDK Extension track or version is unavailable.
  sdkExtensionVersion,
}
