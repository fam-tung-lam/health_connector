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
/// - **Android Health Connect**: [`RestingHeartRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RestingHeartRateRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.restingHeartRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/restingheartrate)
///
/// ## Example
///
/// ```dart
/// final record = RestingHeartRateRecord(
///   time: DateTime.now(),
///   rate: Frequency.perMinute(60),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [RestingHeartRateDataType]
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
  /// - [rate]: The resting heart rate measurement in beats per minute.
  const RestingHeartRateRecord({
    required super.time,
    required super.metadata,
    required this.rate,
    super.id,
    super.zoneOffsetSeconds,
  });

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
  factory RestingHeartRateRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Frequency rate,
    int? zoneOffsetSeconds,
  }) {
    return RestingHeartRateRecord._(
      id: id,
      time: time,
      metadata: metadata,
      rate: rate,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const RestingHeartRateRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.rate,
    super.zoneOffsetSeconds,
  });

  /// The resting heart rate measurement in beats per minute.
  final Frequency rate;

  /// Creates a copy with the given fields replaced with the new values.
  RestingHeartRateRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    Frequency? rate,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return RestingHeartRateRecord(
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      rate: rate ?? this.rate,
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
          rate == other.rate &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      rate.hashCode ^
      metadata.hashCode;
}
