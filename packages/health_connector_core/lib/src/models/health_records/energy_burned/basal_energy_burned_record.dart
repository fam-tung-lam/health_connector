part of '../health_record.dart';

/// Represents basal energy burned over a time interval.
///
/// This record captures the amount of energy burned by the body
/// at rest (Basal Metabolic Rate or BMR) during a specific time period.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.basalEnergyBurned`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalenergyburned)
///
/// ## Example
///
/// ```dart
/// final record = BasalEnergyBurnedRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   energy: Energy.kilocalories(60), // 60 kcal basal burn
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [BasalEnergyBurnedDataType]
/// - [ActiveEnergyBurnedRecord]
/// - [ActiveEnergyBurnedDataType]
/// - [TotalEnergyBurnedRecord]
/// - [TotalEnergyBurnedDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnAppleHealth
@immutable
final class BasalEnergyBurnedRecord extends IntervalHealthRecord {
  /// Minimum valid basal energy burned (0.0 kcal).
  ///
  /// No basal energy during measurement period.
  static const Energy minEnergy = Energy.zero;

  /// Maximum valid basal energy burned (5,000.0 kcal).
  ///
  /// Typical BMR ~300-3,000 kcal/day; 5,000 allows for large individuals and
  /// multi-day intervals.
  static const Energy maxEnergy = Energy.kilocalories(5000.0);

  /// Creates a basal energy burned record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [energy]: The amount of energy burned during the interval.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [energy] is outside the valid range of
  ///   [minEnergy]-[maxEnergy] kcal.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minEnergy] kcal)**: No basal energy during measurement
  ///   period.
  /// - **Maximum ([maxEnergy] kcal)**: Typical BMR ~300-3,000 kcal/day;
  ///   5,000 allows for large individuals and multi-day intervals.
  BasalEnergyBurnedRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.energy,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: energy >= minEnergy && energy <= maxEnergy,
      value: energy,
      name: 'energy',
      message:
          'Basal energy burned must be between '
          '${minEnergy.inKilocalories.toStringAsFixed(0)}-'
          '${maxEnergy.inKilocalories.toStringAsFixed(0)} kcal. '
          'Got ${energy.inKilocalories.toStringAsFixed(0)} kcal.',
    );
  }

  /// Internal factory for creating [BasalEnergyBurnedRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory BasalEnergyBurnedRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Energy energy,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return BasalEnergyBurnedRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      energy: energy,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  BasalEnergyBurnedRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.energy,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The basal energy burned during the interval.
  final Energy energy;

  /// Creates a copy with the given fields replaced with the new values.
  BasalEnergyBurnedRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Energy? energy,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return BasalEnergyBurnedRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      energy: energy ?? this.energy,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasalEnergyBurnedRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          energy == other.energy &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      energy.hashCode ^
      metadata.hashCode;
}
