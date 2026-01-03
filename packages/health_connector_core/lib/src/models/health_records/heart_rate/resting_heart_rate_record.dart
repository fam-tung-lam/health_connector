part of '../health_record.dart';

/// Represents a resting heart rate measurement at a specific point in time.
///
/// [RestingHeartRateRecord] captures the user's heart rate while at complete
/// rest, typically measured first thing in the morning before getting out of
/// bed.
/// This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`RestingHeartRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RestingHeartRateRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.restingHeartRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/restingheartrate)
///
/// ## Example
///
/// ```dart
/// final record = RestingHeartRateRecord(
///   time: DateTime.now(),
///   beatsPerMinute: Number(60),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [RestingHeartRateHealthDataType]
///
/// {@category Health Records}
@sinceV1_3_0
@immutable
final class RestingHeartRateRecord extends InstantHealthRecord {
  /// Creates a resting heart rate record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the resting heart rate was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [beatsPerMinute]: The resting heart rate measurement in beats per
  ///   minute.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [beatsPerMinute] is negative.
  const RestingHeartRateRecord({
    required super.time,
    required super.metadata,
    required this.beatsPerMinute,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The resting heart rate measurement in beats per minute.
  final Number beatsPerMinute;

  /// Creates a copy with the given fields replaced with the new values.
  RestingHeartRateRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    Number? beatsPerMinute,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return RestingHeartRateRecord(
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      beatsPerMinute: beatsPerMinute ?? this.beatsPerMinute,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestingHeartRateRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          beatsPerMinute == other.beatsPerMinute &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      beatsPerMinute.hashCode ^
      metadata.hashCode;
}
