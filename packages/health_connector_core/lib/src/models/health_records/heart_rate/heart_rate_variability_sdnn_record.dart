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
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.heartRateVariabilitySDNN`](htt
/// ps://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/he
/// artratevariabilitysdnn)
///
/// ## Example
///
/// ```dart
/// final record = HeartRateVariabilitySDNNRecord(
///   time: DateTime.now(),
///   sdnn: TimeDuration.milliseconds(50.0),
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
  /// - [sdnn]: The SDNN duration value.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [sdnn] is negative.
  HeartRateVariabilitySDNNRecord({
    required super.time,
    required super.metadata,
    required this.sdnn,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  }) {
    if (sdnn < TimeDuration.zero) {
      throw ArgumentError.value(
        sdnn,
        'SDNN',
        'Heart rate variability SDNN must be non-negative',
      );
    }
  }

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// Creates a [BloodPressureRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodPressureRecord] constructor, which enforces validation and business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory HeartRateVariabilitySDNNRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required TimeDuration sdnn,
    int? zoneOffsetSeconds,
  }) {
    return HeartRateVariabilitySDNNRecord._(
      time: time,
      metadata: metadata,
      sdnn: sdnn,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const HeartRateVariabilitySDNNRecord._({
    required super.time,
    required super.metadata,
    required this.sdnn,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The SDNN duration value.
  final TimeDuration sdnn;

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateVariabilitySDNNRecord copyWith({
    DateTime? time,
    TimeDuration? sdnn,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return HeartRateVariabilitySDNNRecord(
      time: time ?? this.time,
      sdnn: sdnn ?? this.sdnn,
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
          sdnn == other.sdnn &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      sdnn.hashCode ^
      metadata.hashCode;
}
