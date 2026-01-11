part of '../health_record.dart';

/// Represents active energy burned over a time interval.
///
/// This record captures the amount of energy burned during physical
/// activity over a specific time period. Active calories are those burned
/// through exercise and movement, excluding basal metabolic rate.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`ActiveEnergyBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ActiveEnergyBurnedRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.activeEnergyBurned`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/activeenergyburned)
///
/// ## Example
///
/// ```dart
/// final record = ActiveEnergyBurnedRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   energy: Energy.kilocalories(300), // 300 kcal burned
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [ActiveEnergyBurnedDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class ActiveEnergyBurnedRecord extends IntervalHealthRecord {
  /// Minimum valid active energy burned (0.0 kcal).
  ///
  /// No active energy burned.
  static const Energy minEnergy = Energy.zero;

  /// Maximum valid active energy burned (15,000.0 kcal).
  ///
  /// Ultra-endurance events (e.g., multi-day races) can exceed 10,000 kcal/day;
  /// 15,000 provides margin.
  static const Energy maxEnergy = Energy.kilocalories(15000.0);

  /// Creates an active energy burned record.
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
  /// - **Minimum ([minEnergy] kcal)**: No active energy burned.
  /// - **Maximum ([maxEnergy] kcal)**: Ultra-endurance events (e.g.,
  ///   multi-day races) can exceed 10,000 kcal/day; 15,000 provides margin.
  ActiveEnergyBurnedRecord({
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
          'Active energy burned must be between '
          '${minEnergy.inKilocalories.toStringAsFixed(0)}-'
          '${maxEnergy.inKilocalories.toStringAsFixed(0)} kcal. '
          'Got ${energy.inKilocalories.toStringAsFixed(0)} kcal.',
    );
  }

  /// Internal factory for creating [ActiveEnergyBurnedRecord] instances without
  /// validation.
  ///
  /// Creates a [ActiveEnergyBurnedRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [ActiveEnergyBurnedRecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory ActiveEnergyBurnedRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Energy energy,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return ActiveEnergyBurnedRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      energy: energy,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  ActiveEnergyBurnedRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.energy,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The energy burned during the interval.
  final Energy energy;

  /// Creates a copy with the given fields replaced with the new values.
  ActiveEnergyBurnedRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Energy? energy,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return ActiveEnergyBurnedRecord(
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
      other is ActiveEnergyBurnedRecord &&
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
