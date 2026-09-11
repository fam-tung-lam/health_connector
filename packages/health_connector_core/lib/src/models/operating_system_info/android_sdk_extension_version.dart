import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:meta/meta.dart' show immutable;

/// One Android SDK Extension track and its version.
///
/// In an operating-system snapshot, this is a version present on the device.
/// In a platform requirement, this is the minimum version a capability needs.
@sinceV3_11_0
@immutable
final class AndroidSDKExtensionVersion {
  /// Creates an Android SDK Extension version.
  const AndroidSDKExtensionVersion({
    required this.androidApiLevel,
    required this.extensionVersion,
  });

  /// The `Build.VERSION_CODES` value identifying the extension track.
  ///
  /// This is an Android API level, not an extension version.
  final int androidApiLevel;

  /// The version reported for [androidApiLevel] by Android's SDK Extensions.
  final int extensionVersion;

  /// Whether [actual] is on the same track and meets this minimum version.
  bool isSatisfiedBy(AndroidSDKExtensionVersion actual) =>
      actual.androidApiLevel == androidApiLevel &&
      actual.extensionVersion >= extensionVersion;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AndroidSDKExtensionVersion &&
          runtimeType == other.runtimeType &&
          androidApiLevel == other.androidApiLevel &&
          extensionVersion == other.extensionVersion;

  @override
  int get hashCode => Object.hash(androidApiLevel, extensionVersion);

  @override
  String toString() =>
      'AndroidSDKExtensionVersion('
      'androidApiLevel: $androidApiLevel, '
      'extensionVersion: $extensionVersion)';
}
