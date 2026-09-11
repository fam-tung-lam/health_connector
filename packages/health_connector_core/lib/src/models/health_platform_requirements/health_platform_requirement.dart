import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/operating_system_info/android_sdk_extension_version.dart';
import 'package:health_connector_core/src/models/operating_system_info/ios_version.dart';
import 'package:meta/meta.dart' show immutable;

/// A runtime support requirement for one health platform.
///
/// A platform absent from an API's requirements is unsupported.
@sinceV3_11_0
sealed class HealthPlatformRequirement {
  /// Creates a health platform requirement.
  const HealthPlatformRequirement();

  /// The health platform this requirement applies to.
  HealthPlatform get healthPlatform;

  /// Both health platforms without an additional version requirement.
  static const List<HealthPlatformRequirement> allPlatformsWithoutRequirements =
      [
        AppleHealthRequirement.none,
        HealthConnectRequirement.none,
      ];
}

/// Platform projections for a list of health platform requirements.
@sinceV3_11_0
extension HealthPlatformRequirementsExtension
    on List<HealthPlatformRequirement> {
  /// The health platforms represented by these requirements.
  List<HealthPlatform> get supportedHealthPlatforms =>
      map((requirement) => requirement.healthPlatform).toList(growable: false);
}

/// A runtime support requirement for Android Health Connect.
@sinceV3_11_0
@immutable
final class HealthConnectRequirement extends HealthPlatformRequirement {
  /// Creates a Health Connect requirement.
  const HealthConnectRequirement({
    this.minApiLevel,
    this.minSDKExtensionVersion,
  });

  /// Health Connect without an additional version requirement.
  static const HealthConnectRequirement none = HealthConnectRequirement();

  /// Android 14 or later with Health Connect SDK Extension 13 or later.
  static const HealthConnectRequirement android14OrLaterWithSDKExtension13 =
      HealthConnectRequirement(
        minApiLevel: 34,
        minSDKExtensionVersion: AndroidSDKExtensionVersion(
          androidApiLevel: 34,
          extensionVersion: 13,
        ),
      );

  /// Android 14 or later with Health Connect SDK Extension 15 or later.
  static const HealthConnectRequirement android14OrLaterWithSDKExtension15 =
      HealthConnectRequirement(
        minApiLevel: 34,
        minSDKExtensionVersion: AndroidSDKExtensionVersion(
          androidApiLevel: 34,
          extensionVersion: 15,
        ),
      );

  /// Android 14 or later with Health Connect SDK Extension 16 or later.
  static const HealthConnectRequirement android14OrLaterWithSDKExtension16 =
      HealthConnectRequirement(
        minApiLevel: 34,
        minSDKExtensionVersion: AndroidSDKExtensionVersion(
          androidApiLevel: 34,
          extensionVersion: 16,
        ),
      );

  /// Android 14 or later with Health Connect SDK Extension 19 or later.
  static const HealthConnectRequirement android14OrLaterWithSDKExtension19 =
      HealthConnectRequirement(
        minApiLevel: 34,
        minSDKExtensionVersion: AndroidSDKExtensionVersion(
          androidApiLevel: 34,
          extensionVersion: 19,
        ),
      );

  /// Android 14 or later with Health Connect SDK Extension 21 or later.
  static const HealthConnectRequirement android14OrLaterWithSDKExtension21 =
      HealthConnectRequirement(
        minApiLevel: 34,
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
@sinceV3_11_0
@immutable
final class AppleHealthRequirement extends HealthPlatformRequirement {
  /// Creates an Apple Health requirement.
  const AppleHealthRequirement({this.minIOSVersion});

  /// Apple HealthKit without an additional version requirement.
  static const AppleHealthRequirement none = AppleHealthRequirement();

  /// Apple HealthKit on iOS 16 or later.
  static const AppleHealthRequirement ios16OrLater = AppleHealthRequirement(
    minIOSVersion: IOSVersion(16),
  );

  /// Apple HealthKit on iOS 17 or later.
  static const AppleHealthRequirement ios17OrLater = AppleHealthRequirement(
    minIOSVersion: IOSVersion(17),
  );

  /// Apple HealthKit on iOS 18 or later.
  static const AppleHealthRequirement ios18OrLater = AppleHealthRequirement(
    minIOSVersion: IOSVersion(18),
  );

  /// Minimum iOS version, or `null` for the SDK's deployment target.
  final IOSVersion? minIOSVersion;

  @override
  HealthPlatform get healthPlatform => HealthPlatform.appleHealth;
}
