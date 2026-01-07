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
///   heartRateVariabilityMillis: Number(45.0), // ms
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
  /// - [heartRateVariabilityMillis]: The heart rate variability in
  ///   milliseconds.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [heartRateVariabilityMillis] is negative.
  factory HeartRateVariabilityRMSSDRecord({
    required DateTime time,
    required Metadata metadata,
    required Number heartRateVariabilityMillis,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
  }) {
    if (heartRateVariabilityMillis < Number.zero) {
      throw ArgumentError.value(
        heartRateVariabilityMillis,
        'heartRateVariabilityMillis',
        'Heart rate variability RMSSD must be non-negative',
      );
    }
    return HeartRateVariabilityRMSSDRecord._(
      time: time,
      metadata: metadata,
      heartRateVariabilityMillis: heartRateVariabilityMillis,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor for internal use.
  const HeartRateVariabilityRMSSDRecord._({
    required super.time,
    required super.metadata,
    required this.heartRateVariabilityMillis,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The heart rate variability in milliseconds.
  final Number heartRateVariabilityMillis;

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateVariabilityRMSSDRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    Number? heartRateVariabilityMillis,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return HeartRateVariabilityRMSSDRecord._(
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      heartRateVariabilityMillis:
          heartRateVariabilityMillis ?? this.heartRateVariabilityMillis,
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
          heartRateVariabilityMillis == other.heartRateVariabilityMillis &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      heartRateVariabilityMillis.hashCode ^
      metadata.hashCode;
}
