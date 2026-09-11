import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:meta/meta.dart' show immutable;

/// A semantic iOS operating-system version.
@sinceV4_0_0
@immutable
final class IOSVersion implements Comparable<IOSVersion> {
  /// Creates an iOS version.
  const IOSVersion(this.major, [this.minor = 0, this.patch = 0]);

  /// The major version component.
  final int major;

  /// The minor version component.
  final int minor;

  /// The patch version component.
  final int patch;

  /// Whether this version is newer than [other].
  bool operator >(IOSVersion other) => compareTo(other) > 0;

  /// Whether this version is older than [other].
  bool operator <(IOSVersion other) => compareTo(other) < 0;

  /// Whether this version is at least [other].
  bool operator >=(IOSVersion other) => compareTo(other) >= 0;

  /// Whether this version is at most [other].
  bool operator <=(IOSVersion other) => compareTo(other) <= 0;

  @override
  int compareTo(IOSVersion other) {
    final majorComparison = major.compareTo(other.major);
    if (majorComparison != 0) {
      return majorComparison;
    }

    final minorComparison = minor.compareTo(other.minor);
    if (minorComparison != 0) {
      return minorComparison;
    }

    return patch.compareTo(other.patch);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IOSVersion &&
          runtimeType == other.runtimeType &&
          major == other.major &&
          minor == other.minor &&
          patch == other.patch;

  @override
  int get hashCode => Object.hash(major, minor, patch);

  @override
  String toString() => '$major.$minor.$patch';
}
