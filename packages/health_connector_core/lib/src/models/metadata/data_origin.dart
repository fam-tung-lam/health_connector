part of 'metadata.dart';

/// The source that wrote the health data.
///
/// Sources are identified by [packageName]. Display names do not affect
/// equality or hashing because they may change independently of the source's
/// identity.
///
/// {@category Core API}
@sinceV1_0_0
@immutable
final class DataOrigin {
  /// Creates a data origin with the specified [packageName].
  ///
  /// ## Parameters
  ///
  /// - [packageName]: The app's package name or bundle identifier.
  /// - [displayName]: Optional display information supplied by the platform.
  const DataOrigin(this.packageName, {this.displayName});

  /// The app's package name (Android Health Connect) or bundle
  /// identifier (iOS HealthKit).
  final String packageName;

  /// The source's display name, when available.
  ///
  /// On Android Health Connect, this is the app label resolved through the
  /// package manager. It is `null` when the package is unavailable or not
  /// visible to the reading application.
  /// On iOS HealthKit, this is `HKSource.name`: a localized app name or the
  /// reported name of a supported Bluetooth LE source.
  ///
  /// Read operations and synchronization populate this descriptive value.
  /// Writes ignore it. Names may change with locale or app updates and must not
  /// be used as identifiers or filters. Blank platform names are returned as
  /// `null`; use [packageName] as an application-level display fallback.
  ///
  /// {@category Core API}
  @sinceV3_13_0
  final String? displayName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataOrigin &&
          runtimeType == other.runtimeType &&
          packageName == other.packageName;

  @override
  int get hashCode => packageName.hashCode;
}
