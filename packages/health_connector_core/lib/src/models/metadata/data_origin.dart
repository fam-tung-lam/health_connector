part of 'metadata.dart';

/// The origin app that wrote the health data.
@sinceV1_0_0
@immutable
final class DataOrigin {
  /// Creates a data origin with the specified [packageName].
  /// 
  /// ## Parameters
  /// 
  /// - [packageName]: The app's package name or bundle identifier.
  const DataOrigin(this.packageName);

  /// The app's package name (Android Health Connect) or bundle
  /// identifier (iOS HealthKit).
  final String packageName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataOrigin &&
          runtimeType == other.runtimeType &&
          packageName == other.packageName;

  @override
  int get hashCode => packageName.hashCode;
}
