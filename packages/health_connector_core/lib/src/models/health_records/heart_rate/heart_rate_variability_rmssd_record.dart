part of '../health_record.dart';

/// Represents a heart rate variability (RMSSD) record.
///
/// This record captures the user's Heart Rate Variability (RMSSD), which is a
/// measure of the variation in time between each heartbeat. RMSSD stands for
/// the Root Mean Square of Successive Differences.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`HeartRateVariabilityRMSSDRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateVariabilityRMSSDRecord)
/// - **iOS HealthKit**: Not supported.
///
/// ## Example
///
/// ```dart
/// final record = HeartRateVariabilityRMSSDRecord(
///   time: DateTime.now(),
///   rmssd: TimeDuration.milliseconds(45.0),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [HeartRateVariabilityRMSSDDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class HeartRateVariabilityRMSSDRecord extends InstantHealthRecord {
  /// Creates a heart rate variability (RMSSD) record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the measurement was taken.
  /// - [rmssd]: The heart rate variability duration.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [rmssd] is negative.
  factory HeartRateVariabilityRMSSDRecord({
    required DateTime time,
    required Metadata metadata,
    required TimeDuration rmssd,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
  }) {
    if (rmssd < TimeDuration.zero) {
      throw ArgumentError.value(
        rmssd,
        'RMSSD',
        'Heart rate variability RMSSD must be non-negative',
      );
    }
    return HeartRateVariabilityRMSSDRecord._(
      time: time,
      metadata: metadata,
      rmssd: rmssd,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor for internal use.
  const HeartRateVariabilityRMSSDRecord._({
    required super.time,
    required super.metadata,
    required this.rmssd,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The heart rate variability duration.
  final TimeDuration rmssd;

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateVariabilityRMSSDRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    TimeDuration? rmssd,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return HeartRateVariabilityRMSSDRecord._(
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      rmssd: rmssd ?? this.rmssd,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateVariabilityRMSSDRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          rmssd == other.rmssd &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      rmssd.hashCode ^
      metadata.hashCode;
}
