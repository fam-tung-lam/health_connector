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
/// final record = HeartRateRecord(
///   id: HealthRecordId('ABC-123'),
///   time: DateTime.now(),
///   rate: Frequency.perMinute(72),
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [HeartRateDataType]
/// - [HeartRateSeriesRecord] for series-based heart rate measurements
/// - [HeartRateSample] is used exclusively for series record samples
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnAppleHealth
@immutable
final class HeartRateRecord extends InstantHealthRecord {
  /// Minimum valid heart rate in beats per minute.
  ///
  /// Valid range: 1-300 bpm, as enforced by Android Health Connect.
  ///
  /// ## Platform Compatibility
  ///
  /// - **Android Health Connect**: [HeartRateRecord.kt](https://cs.android.com/androidx/platform/frameworks/support/+/androidx-main:health/connect/connect-client/src/main/java/androidx/health/connect/client/records/HeartRateRecord.kt)
  /// - **Apple HealthKit**: No platform limits (application-defined)
  static final Frequency minRate = Frequency.perMinute(1.0);

  /// Maximum valid heart rate in beats per minute.
  ///
  /// Valid range: 1-300 bpm, as enforced by Android Health Connect.
  ///
  /// ## Platform Compatibility
  ///
  /// - **Android Health Connect**: [HeartRateRecord.kt](https://cs.android.com/androidx/platform/frameworks/support/+/androidx-main:health/connect/connect-client/src/main/java/androidx/health/connect/client/records/HeartRateRecord.kt)
  /// - **Apple HealthKit**: No platform limits (application-defined)
  static final Frequency maxRate = Frequency.perMinute(300.0);

  /// Creates a heart rate measurement record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the heart rate was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [rate]: The heart rate value in beats per minute (BPM).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [rate] is outside the valid range of
  ///   [minRate]-[maxRate].
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minRate])**: 1 bpm allows for extreme bradycardia and
  ///   ensures all Health Connect data can be processed.
  /// - **Maximum ([maxRate])**: 300 bpm accommodates extreme tachycardia,
  ///   stress test conditions, and sensor artifacts.
  HeartRateRecord({
    required super.id,
    required super.time,
    required super.metadata,
    required this.rate,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: rate >= minRate && rate <= maxRate,
      value: rate,
      name: 'rate',
      message:
          'Heart rate must be between '
          '${minRate.inPerMinute.toStringAsFixed(0)}-'
          '${maxRate.inPerMinute.toStringAsFixed(0)} bpm. '
          'Got ${rate.inPerMinute.toStringAsFixed(1)} bpm.',
    );
  }

  /// Internal factory for creating [HeartRateRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [HeartRateRecord] constructor, which enforces validation.
  @internalUse
  factory HeartRateRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Frequency rate,
    int? zoneOffsetSeconds,
  }) {
    return HeartRateRecord._(
      id: id,
      time: time,
      metadata: metadata,
      rate: rate,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const HeartRateRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.rate,
    super.zoneOffsetSeconds,
  });

  /// The heart rate value in beats per minute (BPM).
  final Frequency rate;

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    Frequency? rate,
    int? zoneOffsetSeconds,
  }) {
    return HeartRateRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      time: time ?? this.time,
      rate: rate ?? this.rate,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          time == other.time &&
          rate == other.rate;

  @override
  int get hashCode =>
      id.hashCode ^ metadata.hashCode ^ time.hashCode ^ rate.hashCode;
}
