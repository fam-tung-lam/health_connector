part of '../health_record.dart';

/// Represents the total energy burned over a time interval.
///
/// This record captures the total amount of energy burned during a
/// specific time period, including both active calories (from activity) and
/// basal metabolic rate (BMR).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`TotalEnergyBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/TotalEnergyBurnedRecord)
/// - **iOS HealthKit**: Not supported. iOS separates Active and Basal energy.
///
/// ## Example
///
/// ```dart
/// final record = TotalEnergyBurnedRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   energy: Energy.kilocalories(450), // 450 kcal total (active + basal)
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [TotalEnergyBurnedDataType]
/// - [ActiveEnergyBurnedRecord]
/// - [ActiveEnergyBurnedDataType]
/// - [BasalEnergyBurnedRecord]
/// - [BasalEnergyBurnedDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class TotalEnergyBurnedRecord extends IntervalHealthRecord {
  /// Minimum valid total energy burned (0.0 kcal).
  ///
  /// No energy burned during measurement period.
  static const Energy minEnergy = Energy.zero;

  /// Maximum valid total energy burned (20,000.0 kcal).
  ///
  /// Sum of active (max 15,000) + basal (max 5,000) energy with margin for
  /// extreme multi-day events.
  static const Energy maxEnergy = Energy.kilocalories(20000.0);

  /// Creates a total energy burned record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [energy]: The total amount of energy burned during the interval.
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
  /// - **Minimum ([minEnergy] kcal)**: No energy burned during measurement
  ///   period.
  /// - **Maximum ([maxEnergy] kcal)**: Sum of active (max 15,000) +
  ///   basal (max 5,000) energy with margin for extreme multi-day events.
  TotalEnergyBurnedRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.energy,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    require(
      condition: energy >= minEnergy && energy <= maxEnergy,
      value: energy,
      name: 'energy',
      message:
          'Total energy burned must be between '
          '${minEnergy.inKilocalories.toStringAsFixed(0)}-'
          '${maxEnergy.inKilocalories.toStringAsFixed(0)} kcal. '
          'Got ${energy.inKilocalories.toStringAsFixed(0)} kcal.',
    );
  }

  /// Internal factory for creating [TotalEnergyBurnedRecord] instances without
  /// validation.
  ///
  /// Creates a [TotalEnergyBurnedRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [TotalEnergyBurnedRecord] constructor, which enforces validation and
  /// business rules. This factory is restricted to the SDK developers and
  /// contributors.
  @internalUse
  factory TotalEnergyBurnedRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Energy energy,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return TotalEnergyBurnedRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      energy: energy,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  TotalEnergyBurnedRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.energy,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The total energy burned during the interval.
  final Energy energy;

  /// Creates a copy with the given fields replaced with the new values.
  TotalEnergyBurnedRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Energy? energy,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return TotalEnergyBurnedRecord(
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
      other is TotalEnergyBurnedRecord &&
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
