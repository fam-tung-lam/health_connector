part of '../health_record.dart';

/// Represents a single heart rate measurement.
///
/// Each heart rate measurement record represents one BPM measurement at a
/// specific time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [HeartRateSeriesRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.heartRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartrate)
///
/// ## Example
///
/// ```dart
/// final record = HeartRateMeasurementRecord(
///   id: HealthRecordId('ABC-123'),
///   time: DateTime.now(),
///   beatsPerMinute: Frequency.perMinute(72),
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.apple.health'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [HeartRateMeasurementRecordHealthDataType]
/// - [HeartRateSeriesRecord] for series-based heart rate measurements
/// - [HeartRateMeasurement] is used exclusively for series record samples
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnAppleHealth
@immutable
final class HeartRateMeasurementRecord extends InstantHealthRecord {
  /// Creates a heart rate measurement record.
  const HeartRateMeasurementRecord({
    required super.id,
    required super.metadata,
    required super.time,
    required this.beatsPerMinute,
    super.zoneOffsetSeconds,
  });

  /// The heart rate value in beats per minute (BPM).
  final Number beatsPerMinute;

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateMeasurementRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    Number? beatsPerMinute,
    int? zoneOffsetSeconds,
  }) {
    return HeartRateMeasurementRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      time: time ?? this.time,
      beatsPerMinute: beatsPerMinute ?? this.beatsPerMinute,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateMeasurementRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          time == other.time &&
          beatsPerMinute == other.beatsPerMinute;

  @override
  int get hashCode =>
      id.hashCode ^ metadata.hashCode ^ time.hashCode ^ beatsPerMinute.hashCode;
}
