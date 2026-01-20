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
  /// Minimum valid resting heart rate in beats per minute.
  ///
  /// Valid range: 1-300 bpm, aligned with Android Health Connect.
  ///
  /// ## Platform Compatibility
  ///
  /// - **Android Health Connect**: [RestingHeartRateRecord.kt](https://cs.android.com/androidx/platform/frameworks/support/+/androidx-main:health/connect/connect-client/src/main/java/androidx/health/connect/client/records/RestingHeartRateRecord.kt)
  /// - **Apple HealthKit**: No platform limits (application-defined)
  static final Frequency minRate = Frequency.perMinute(1.0);

  /// Maximum valid resting heart rate in beats per minute.
  ///
  /// Valid range: 1-300 bpm, aligned with Android Health Connect.
  ///
  /// ## Platform Compatibility
  ///
  /// - **Android Health Connect**: [RestingHeartRateRecord.kt](https://cs.android.com/androidx/platform/frameworks/support/+/androidx-main:health/connect/connect-client/src/main/java/androidx/health/connect/client/records/RestingHeartRateRecord.kt)
  /// - **Apple HealthKit**: No platform limits (application-defined)
  static final Frequency maxRate = Frequency.perMinute(300.0);

  /// Creates a resting heart rate record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the resting heart rate was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [rate]: The resting heart rate measurement in beats per minute.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [rate] is outside the valid range of
  ///   [minRate]-[maxRate].
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minRate])**: 1 bpm allows for extreme bradycardia and
  ///   ensures all valid Health Connect data can be processed.
  /// - **Maximum ([maxRate])**: 300 bpm maintains consistency with general
  ///   heart rate validation and Health Connect requirements.
  RestingHeartRateRecord({
    required super.time,
    required super.metadata,
    required this.rate,
    super.id,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: rate >= minRate && rate <= maxRate,
      value: rate,
      name: 'rate',
      message:
          'Resting heart rate must be between '
          '${minRate.inPerMinute.toStringAsFixed(0)}-'
          '${maxRate.inPerMinute.toStringAsFixed(0)} bpm. '
          'Got ${rate.inPerMinute.toStringAsFixed(1)} bpm.',
    );
  }

  /// Internal factory for creating [RestingHeartRateRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [RestingHeartRateRecord] constructor, which enforces validation.
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
