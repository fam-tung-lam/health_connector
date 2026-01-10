part of '../health_record.dart';

/// Represents a single heart rate measurement.
///
/// Each heart rate measurement record represents one BPM measurement at a
/// specific time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [HeartRateSeriesRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.heartRate`](https://develope
/// r.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartrate)
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
  /// Creates a heart rate measurement record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the heart rate was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [rate]: The heart rate value in beats per minute (BPM).
  const HeartRateRecord({
    required super.id,
    required super.time,
    required super.metadata,
    required this.rate,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [HeartRateRecord] instances
  /// without validation.
  ///
  /// Creates a [HeartRateRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [HeartRateRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
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
