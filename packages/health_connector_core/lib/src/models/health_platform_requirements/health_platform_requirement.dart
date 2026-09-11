import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/operating_system_info/android_sdk_extension_version.dart';
import 'package:health_connector_core/src/models/operating_system_info/ios_version.dart';
import 'package:meta/meta.dart' show immutable;

/// A runtime support requirement for one health platform.
///
/// A platform absent from an API's requirements is unsupported.
@sinceV4_0_0
sealed class HealthPlatformRequirement {
  /// Creates a health platform requirement.
  const HealthPlatformRequirement();

  /// The health platform this requirement applies to.
  HealthPlatform get healthPlatform;

  /// Both health platforms without an additional version requirement.
  static const List<HealthPlatformRequirement> allPlatforms = [
    HealthConnectRequirement.allVersions,
    AppleHealthRequirement.allVersions,
  ];
}

/// Platform projections for a list of health platform requirements.
@sinceV4_0_0
extension HealthPlatformRequirementsExtension
    on List<HealthPlatformRequirement> {
  /// The health platforms represented by these requirements.
  List<HealthPlatform> get supportedHealthPlatforms =>
      map((requirement) => requirement.healthPlatform).toList(growable: false);
}

/// A runtime support requirement for Android Health Connect.
@sinceV4_0_0
@immutable
final class HealthConnectRequirement extends HealthPlatformRequirement {
  /// Creates a Health Connect requirement.
  const HealthConnectRequirement({
    this.minApiLevel,
    this.minSDKExtensionVersion,
  });

  /// Health Connect on any Android version supported by this SDK.
  static const allVersions = HealthConnectRequirement();

  /// Health Connect SDK Extension 13 on the Android 14 extension track.
  static const sdkExtension13 = HealthConnectRequirement(
    minSDKExtensionVersion: AndroidSDKExtensionVersion(
      androidApiLevel: 34,
      extensionVersion: 13,
    ),
  );

  /// Health Connect SDK Extension 15 on the Android 14 extension track.
  static const sdkExtension15 = HealthConnectRequirement(
    minSDKExtensionVersion: AndroidSDKExtensionVersion(
      androidApiLevel: 34,
      extensionVersion: 15,
    ),
  );

  /// Health Connect SDK Extension 16 on the Android 14 extension track.
  static const sdkExtension16 = HealthConnectRequirement(
    minSDKExtensionVersion: AndroidSDKExtensionVersion(
      androidApiLevel: 34,
      extensionVersion: 16,
    ),
  );

  /// Health Connect SDK Extension 19 on the Android 14 extension track.
  static const sdkExtension19 = HealthConnectRequirement(
    minSDKExtensionVersion: AndroidSDKExtensionVersion(
      androidApiLevel: 34,
      extensionVersion: 19,
    ),
  );

  /// Health Connect SDK Extension 21 on the Android 14 extension track.
  static const sdkExtension21 = HealthConnectRequirement(
    minSDKExtensionVersion: AndroidSDKExtensionVersion(
      androidApiLevel: 34,
      extensionVersion: 21,
    ),
  );

  /// Minimum `Build.VERSION.SDK_INT`, or `null` for the SDK's minimum.
  final int? minApiLevel;

  /// Minimum SDK Extension requirement, or `null` when none is required.
  ///
  /// A value implies platform Health Connect rather than the Health Connect
  /// APK used on older Android versions.
  final AndroidSDKExtensionVersion? minSDKExtensionVersion;

  @override
  HealthPlatform get healthPlatform => HealthPlatform.healthConnect;
}

/// A runtime support requirement for Apple HealthKit.
@sinceV4_0_0
@immutable
final class AppleHealthRequirement extends HealthPlatformRequirement {
  /// Creates an Apple Health requirement.
  const AppleHealthRequirement({this.minIOSVersion});

  /// Apple HealthKit on any iOS version supported by this SDK.
  static const allVersions = AppleHealthRequirement();

  /// Apple HealthKit on iOS 16 or newer.
  static const ios16 = AppleHealthRequirement(minIOSVersion: IOSVersion(16));

  /// Apple HealthKit on iOS 17 or newer.
  static const ios17 = AppleHealthRequirement(minIOSVersion: IOSVersion(17));

  /// Apple HealthKit on iOS 18 or newer.
  static const ios18 = AppleHealthRequirement(minIOSVersion: IOSVersion(18));

  /// Minimum iOS version, or `null` for the SDK's deployment target.
  final IOSVersion? minIOSVersion;

  @override
  HealthPlatform get healthPlatform => HealthPlatform.appleHealth;
}
