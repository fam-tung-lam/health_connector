part of 'health_record.dart';

/// Represents a body height measurement at a specific point in time.
///
/// [HeightRecord] captures the user's body height as an instant measurement.
/// This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `HeightRecord`
/// - **iOS HealthKit**: `HKQuantityType(.height)`
///
/// ## Example
///
/// ```dart
/// final record = HeightRecord(
///   time: DateTime.now(),
///   height: Length.centimeters(175),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
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
  /// - [height]: The body height measurement. Must be greater than 0 meters.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [height] is less than or equal to 0 meters.
  factory HeightRecord({
    required DateTime time,
    required Metadata metadata,
    required Length height,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
  }) {
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

  /// Creates a copy with the given fields replaced with the new values.
  HeightRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    Length? height,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return HeightRecord(
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      height: height ?? this.height,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

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
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
