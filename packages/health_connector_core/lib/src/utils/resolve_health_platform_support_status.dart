import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/health_platform_requirements/health_platform_requirement.dart';
import 'package:health_connector_core/src/models/health_platform_requirements/health_platform_support_status.dart';
import 'package:health_connector_core/src/models/operating_system_info/android_sdk_extension_version.dart';
import 'package:health_connector_core/src/models/operating_system_info/operating_system_info.dart';

/// Resolves whether [requirements] are satisfied by the current device.
@sinceV3_11_0
@internalUse
HealthPlatformSupportStatus resolveHealthPlatformSupportStatus({
  required List<HealthPlatformRequirement> requirements,
  required HealthPlatform healthPlatform,
  required OperatingSystemInfo operatingSystemInfo,
}) {
  HealthPlatformRequirement? requirement;
  for (final candidate in requirements) {
    if (candidate.healthPlatform == healthPlatform) {
      requirement = candidate;
      break;
    }
  }
  if (requirement == null) {
    return HealthPlatformNotSupported(
      reason: HealthPlatformNotSupportedReason.healthPlatform,
      message: 'The requested operation is not supported on $healthPlatform.',
    );
  }

  return switch ((requirement, operatingSystemInfo)) {
    (
      HealthConnectRequirement(
        minApiLevel: null,
        minSDKExtensionVersion: null,
      ),
      _,
    ) =>
      const HealthPlatformSupported(),
    (AppleHealthRequirement(minIOSVersion: null), _) =>
      const HealthPlatformSupported(),
    (
      final HealthConnectRequirement requirement,
      final AndroidOperatingSystemInfo operatingSystemInfo,
    ) =>
      _resolveHealthConnectRequirement(
        requirement: requirement,
        operatingSystemInfo: operatingSystemInfo,
      ),
    (
      final AppleHealthRequirement requirement,
      final IOSOperatingSystemInfo operatingSystemInfo,
    ) =>
      _resolveAppleHealthRequirement(
        requirement: requirement,
        operatingSystemInfo: operatingSystemInfo,
      ),
    _ => HealthPlatformNotSupported(
      reason: HealthPlatformNotSupportedReason.healthPlatform,
      message: 'The requested operation is not supported on $healthPlatform.',
    ),
  };
}

HealthPlatformSupportStatus _resolveHealthConnectRequirement({
  required HealthConnectRequirement requirement,
  required AndroidOperatingSystemInfo operatingSystemInfo,
}) {
  final minApiLevel = requirement.minApiLevel;
  if (minApiLevel != null && operatingSystemInfo.apiLevel < minApiLevel) {
    return HealthPlatformNotSupported(
      reason: HealthPlatformNotSupportedReason.operatingSystemVersion,
      message:
          'Requires Android API level $minApiLevel or newer; '
          'the device runs API level ${operatingSystemInfo.apiLevel}.',
      requirement: requirement,
    );
  }

  final minimumExtension = requirement.minSDKExtensionVersion;
  if (minimumExtension != null) {
    final actualExtension = AndroidSDKExtensionVersion(
      androidApiLevel: minimumExtension.androidApiLevel,
      extensionVersion: operatingSystemInfo.extensionVersionOf(
        minimumExtension.androidApiLevel,
      ),
    );
    if (!minimumExtension.isSatisfiedBy(actualExtension)) {
      return HealthPlatformNotSupported(
        reason: HealthPlatformNotSupportedReason.sdkExtensionVersion,
        message:
            'Requires Android API level '
            '${minimumExtension.androidApiLevel} SDK Extension '
            '${minimumExtension.extensionVersion} or newer; the device has '
            'Extension ${actualExtension.extensionVersion}.',
        requirement: requirement,
      );
    }
  }

  return const HealthPlatformSupported();
}

HealthPlatformSupportStatus _resolveAppleHealthRequirement({
  required AppleHealthRequirement requirement,
  required IOSOperatingSystemInfo operatingSystemInfo,
}) {
  final minIOSVersion = requirement.minIOSVersion;
  if (minIOSVersion != null && operatingSystemInfo.version < minIOSVersion) {
    return HealthPlatformNotSupported(
      reason: HealthPlatformNotSupportedReason.operatingSystemVersion,
      message:
          'Requires iOS $minIOSVersion or newer; the device runs '
          'iOS ${operatingSystemInfo.version}.',
      requirement: requirement,
    );
  }

  return const HealthPlatformSupported();
}
