part of '../health_record.dart';

/// Represents a basal metabolic rate (BMR) record at a specific point in time.
///
/// This record captures the BMR of a user. Each record represents the energy
/// a user would burn if at rest all day, based on their height and weight.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BasalMetabolicRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalMetabolicRateRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Example
///
/// ```dart
/// final record = BasalMetabolicRateRecord(
///   time: DateTime.now(),
///   rate: Power.kilocaloriesPerDay(1800), // 1800 kcal/day BMR
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [BasalMetabolicRateDataType]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnHealthConnect
@immutable
final class BasalMetabolicRateRecord extends InstantHealthRecord {
  /// Minimum valid basal metabolic rate (0.0 kcal/day).
  ///
  /// No basal metabolic rate.
  static const Power minRate = Power.zero;

  /// Maximum valid basal metabolic rate (10,000.0 kcal/day).
  ///
  /// Represents extreme cases with safety margin.
  static const Power maxRate = Power.kilocaloriesPerDay(10000.0);

  /// Creates a basal metabolic rate record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the BMR was measured.
  /// - [rate]: The basal metabolic rate in kilocalories per day.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [rate] is outside the valid range of
  ///   [minRate]-[maxRate] kcal/day.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minRate] kcal/day)**: No basal metabolic rate.
  /// - **Maximum ([maxRate] kcal/day)**: Represents extreme cases with safety
  ///   margin.
  BasalMetabolicRateRecord({
    required super.time,
    required super.metadata,
    required this.rate,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: rate >= minRate && rate <= maxRate,
      value: rate,
      name: 'rate',
      message:
          'Basal metabolic rate must be between '
          '${minRate.inKilocaloriesPerDay.toStringAsFixed(0)}-'
          '${maxRate.inKilocaloriesPerDay.toStringAsFixed(0)} kcal/day. '
          'Got ${rate.inKilocaloriesPerDay.toStringAsFixed(0)} kcal/day.',
    );
  }

  /// Internal factory for creating [BasalMetabolicRateRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory BasalMetabolicRateRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Power rate,
    int? zoneOffsetSeconds,
  }) {
    return BasalMetabolicRateRecord._(
      id: id,
      time: time,
      metadata: metadata,
      rate: rate,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  BasalMetabolicRateRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.rate,
    super.zoneOffsetSeconds,
  });

  /// The basal metabolic rate in kilocalories per day.
  final Power rate;

  /// Creates a copy with the given fields replaced with the new values.
  BasalMetabolicRateRecord copyWith({
    DateTime? time,
    Power? rate,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BasalMetabolicRateRecord(
      time: time ?? this.time,
      rate: rate ?? this.rate,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasalMetabolicRateRecord &&
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
