part of 'health_record.dart';

/// Represents a body height measurement at a specific point in time.
///
/// [HeightRecord] captures the user's body height as an instant measurement.
/// This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android**: Maps to Health Connect's `HeightRecord`
/// - **iOS**: Maps to HealthKit's `HKQuantityType(.height)`
///
/// ## Platform-specific validation behavior
///
/// ### Android Health Connect
///
/// The height value must be greater than 0 meters and at most 3 meters.
/// Health Connect SDK enforces this validation and throws
/// `IllegalArgumentException` if the height is outside the valid range.
/// This validation is performed before calling native Android methods.
///
/// ### iOS HealthKit
///
/// HealthKit does not enforce any height validation constraints.
/// However, this validation is still performed to maintain consistency
/// across platforms and prevent invalid data from being written.
@sinceV1_0_0
@immutable
final class HeightRecord extends InstantHealthRecord {
  /// Creates a body height record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the height was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [height]: The body height measurement. Must be greater than 0 meters
  ///   and at most 3 meters.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [height] is less than or equal to 0 meters.
  /// - [ArgumentError] if [height] is greater than 3 meters.
  factory HeightRecord({
    required DateTime time,
    required Metadata metadata,
    required Length height,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
  }) {
    final heightInMeters = height.inMeters;
    require(
      heightInMeters > 0,
      'height must be greater than 0 meters, '
      'currently $heightInMeters meters.',
    );
    require(
      heightInMeters <= 3.0,
      'height must not be more than 3.0 meters, '
      'currently $heightInMeters meters.',
    );

    return HeightRecord._(
      time: time,
      metadata: metadata,
      height: height,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor for internal use.
  ///
  /// Use [HeightRecord] factory constructor instead, which performs validation.
  const HeightRecord._({
    required super.time,
    required super.metadata,
    required this.height,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The body height measurement.
  ///
  /// This uses the [Length] unit class which supports multiple units
  /// (meters, kilometers, miles, feet, yards).
  final Length height;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeightRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          height == other.height &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      height.hashCode ^
      metadata.hashCode;

  @override
  String toString() =>
      'HeightRecord('
      'id: $id, '
      'height: $height, '
      'time: $time'
      ')';

  @override
  String get name => 'height_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
