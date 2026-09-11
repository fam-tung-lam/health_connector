import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/operating_system_info/android_sdk_extension_version.dart';
import 'package:health_connector_core/src/models/operating_system_info/ios_version.dart';
import 'package:meta/meta.dart' show immutable;

/// Device operating-system facts captured during connector creation.
@sinceV3_11_0
sealed class OperatingSystemInfo {
  /// Creates an operating-system information snapshot.
  const OperatingSystemInfo();
}

/// Android operating-system facts captured during connector creation.
@sinceV3_11_0
@immutable
final class AndroidOperatingSystemInfo extends OperatingSystemInfo {
  /// Creates an Android operating-system information snapshot.
  const AndroidOperatingSystemInfo({
    required this.apiLevel,
    required this.sdkExtensionVersions,
  });

  /// The device's `Build.VERSION.SDK_INT` value.
  final int apiLevel;

  /// Extension tracks present on the device, sorted by Android API level.
  ///
  /// This list is empty below Android API level 30.
  final List<AndroidSDKExtensionVersion> sdkExtensionVersions;

  /// Returns the extension version for [androidApiLevel].
  ///
  /// Returns `0` when the device does not have that extension track.
  int extensionVersionOf(int androidApiLevel) {
    for (final version in sdkExtensionVersions) {
      if (version.androidApiLevel == androidApiLevel) {
        return version.extensionVersion;
      }
    }

    return 0;
  }

  @override
  String toString() =>
      'AndroidOperatingSystemInfo('
      'apiLevel: $apiLevel, '
      'sdkExtensionVersions: $sdkExtensionVersions)';
}

/// iOS operating-system facts captured during connector creation.
@sinceV3_11_0
@immutable
final class IOSOperatingSystemInfo extends OperatingSystemInfo {
  /// Creates an iOS operating-system information snapshot.
  const IOSOperatingSystemInfo({required this.version});

  /// The device's iOS version.
  final IOSVersion version;

  @override
  String toString() => 'IOSOperatingSystemInfo(version: $version)';
}
