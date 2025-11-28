part of 'metadata.dart';

/// The origin application that wrote the health data.
@sinceV1_0_0
@immutable
final class DataOrigin {
  /// Creates a data origin with the specified [packageName].
  ///
  /// Example:
  /// ```dart
  /// final origin = DataOrigin('com.example.fitness');
  /// ```
  const DataOrigin(this.packageName);

  /// The application's package name (Android) or bundle identifier (iOS).
  ///
  /// This uniquely identifies the application that wrote the data.
  ///
  /// ## Platform Specifics
  ///
  /// ### Android (Health Connect)
  /// - Package name: Automatically set by Health Connect from
  ///   AndroidManifest.xml app's package name
  /// - See: https://developer.android.com/reference/android/health/connect/client/records/metadata/DataOrigin
  ///
  /// ### iOS (HealthKit)
  /// - Package name: Maps to `HKSource.bundleIdentifier` from Info.plist
  /// - See: https://developer.apple.com/documentation/healthkit/hksource
  /// - See: https://developer.apple.com/documentation/healthkit/hksourcerevision
  final String packageName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataOrigin &&
          runtimeType == other.runtimeType &&
          packageName == other.packageName;

  @override
  int get hashCode => packageName.hashCode;

  @override
  String toString() => packageName;
}
