part of '../health_record.dart';

/// Represents a heart rate variability (SDNN) measurement at a point in time.
///
/// SDNN (Standard Deviation of NN intervals) measures the standard deviation
/// of the time intervals between consecutive heartbeats. It provides insight
/// into the autonomic nervous system's regulation of heart rate. Higher SDNN
/// values generally indicate better cardiovascular fitness, stress resilience,
/// and overall heart health.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.heartRateVariabilitySDNN`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartratevariabilitysdnn)
///
/// ## Example
///
/// ```dart
/// final record = HeartRateVariabilitySDNNRecord(
///   time: DateTime.now(),
///   sdnnMillis: Number(50.0), // milliseconds
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [HeartRateVariabilitySDNNDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class HeartRateVariabilitySDNNRecord extends InstantHealthRecord {
  /// Creates a heart rate variability (SDNN) record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the measurement was taken.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [heartRateVariabilitySDNN]: The SDNN value in milliseconds.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [heartRateVariabilitySDNN] is negative.
  factory HeartRateVariabilitySDNNRecord({
    required DateTime time,
    required Metadata metadata,
    required Number heartRateVariabilitySDNN,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
  }) {
    if (heartRateVariabilitySDNN < Number.zero) {
      throw ArgumentError.value(
        heartRateVariabilitySDNN,
        'heartRateVariabilitySDNN',
        'Heart rate variability SDNN must be non-negative',
      );
    }
    return HeartRateVariabilitySDNNRecord._(
      time: time,
      metadata: metadata,
      sdnnMillis: heartRateVariabilitySDNN,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor for internal use.
  const HeartRateVariabilitySDNNRecord._({
    required super.time,
    required super.metadata,
    required this.sdnnMillis,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The SDNN value in milliseconds.
  final Number sdnnMillis;

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateVariabilitySDNNRecord copyWith({
    DateTime? time,
    Number? sdnnMillis,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return HeartRateVariabilitySDNNRecord._(
      time: time ?? this.time,
      sdnnMillis: sdnnMillis ?? this.sdnnMillis,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateVariabilitySDNNRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          sdnnMillis == other.sdnnMillis &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      sdnnMillis.hashCode ^
      metadata.hashCode;
}
