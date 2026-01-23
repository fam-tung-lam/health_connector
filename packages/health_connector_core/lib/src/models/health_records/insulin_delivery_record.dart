part of 'health_record.dart';

/// Represents a record of insulin delivery.
///
/// [InsulinDeliveryRecord] tracks the amount of insulin delivered during
/// a specific time period.
///
/// ## See also
///
/// - [InsulinDeliveryDataType]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealth
@immutable
final class InsulinDeliveryRecord extends IntervalHealthRecord {
  /// Minimum valid units (0).
  static const Number minUnits = Number.zero;

  /// Maximum valid units (500).
  ///
  /// Represents a safety margin for extreme cases.
  static const Number maxUnits = Number(500);

  /// Creates an insulin delivery record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [units]: The amount of insulin delivered in international units
  ///   (must be >= 0).
  /// - [reason]: The reason for the insulin delivery.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [units] is negative.
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [units] is outside the valid range of
  ///   [minUnits]-[maxUnits].
  InsulinDeliveryRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.units,
    required this.reason,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: units >= minUnits && units <= maxUnits,
      value: units,
      name: 'units',
      message:
          'Units must be between ${minUnits.value}-'
          '${maxUnits.value}. '
          'Got ${units.value}.',
    );
  }

  /// Internal factory for creating [InsulinDeliveryRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory InsulinDeliveryRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Number units,
    required InsulinDeliveryReason reason,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return InsulinDeliveryRecord._(
      startTime: startTime,
      endTime: endTime,
      units: units,
      reason: reason,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  InsulinDeliveryRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.units,
    required this.reason,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The amount of insulin delivered in international units.
  ///
  /// Must be non-negative (>= 0).
  final Number units;

  /// The reason for the insulin delivery.
  final InsulinDeliveryReason reason;

  /// Creates a copy with the given fields replaced with the new values.
  InsulinDeliveryRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? units,
    InsulinDeliveryReason? reason,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return InsulinDeliveryRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      units: units ?? this.units,
      reason: reason ?? this.reason,
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
      other is InsulinDeliveryRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          units == other.units &&
          reason == other.reason &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      units.hashCode ^
      reason.hashCode ^
      metadata.hashCode;
}

/// Represents the reason for insulin delivery.
///
/// {@category Health Records}
enum InsulinDeliveryReason {
  /// Insulin administered to meet the user’s basic metabolic needs.
  basal,

  /// Insulin administered to meet the user’s episodic requirements.
  bolus,
}
