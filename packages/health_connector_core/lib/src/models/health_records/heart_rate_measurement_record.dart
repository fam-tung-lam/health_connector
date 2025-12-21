part of 'health_record.dart';

/// Represents a single heart rate measurement (iOS HealthKit).
///
/// **Platform:** iOS only
///
/// Each heart rate measurement record represents one BPM measurement at a
/// specific time. This maps directly to iOS's `HKQuantitySample` with
/// `.heartRate` type.
///
/// ## Example
/// ```dart
/// final record = HeartRateMeasurementRecord(
///   id: HealthRecordId('ABC-123'),
///   time: DateTime.now(),
///   measurement: HeartRateMeasurement(
///     time: DateTime.now(),
///     beatsPerMinute: Frequency.perMinute(72),
///   ),
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.apple.health'),
///   ),
/// );
/// ```
@sinceV1_0_0
@supportedOnAppleHealth
@immutable
final class HeartRateMeasurementRecord extends InstantHealthRecord {
  factory HeartRateMeasurementRecord({
    required HealthRecordId id,
    required Metadata metadata,
    required HeartRateMeasurement measurement,
    int? zoneOffsetSeconds,
  }) {
    return HeartRateMeasurementRecord._(
      id: id,
      metadata: metadata,
      time: measurement.time,
      measurement: measurement,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const HeartRateMeasurementRecord._({
    required super.id,
    required super.metadata,
    required super.time,
    required this.measurement,
    super.zoneOffsetSeconds,
  });

  /// The heart rate measurement.
  final HeartRateMeasurement measurement;

  /// The time when this measurement was taken.
  ///
  /// Convenience getter that returns the time from the measurement.
  @override
  DateTime get time => measurement.time;

  /// The heart rate value in beats per minute (BPM).
  ///
  /// Convenience getter that returns the BPM from the measurement.
  Number get beatsPerMinute => measurement.beatsPerMinute;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateMeasurementRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          measurement == other.measurement;

  @override
  int get hashCode => id.hashCode ^ metadata.hashCode ^ measurement.hashCode;

  @override
  String toString() {
    return 'HeartRateMeasurementRecord('
        'id: $id, '
        'time: $time, '
        'beatsPerMinute: ${beatsPerMinute.value} BPM, '
        'metadata: $metadata'
        ');';
  }

  @override
  String get name => 'heart_rate_measurement_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];
}
