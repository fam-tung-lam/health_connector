part of 'health_record.dart';

/// Represents an inhaler usage record over a time interval.
///
/// [InhalerUsageRecord] tracks the number of puffs a user takes from their
/// inhaler during a specific time period.
///
/// ## See also
///
/// - [InhalerUsageDataType]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealth
@immutable
final class InhalerUsageRecord extends IntervalHealthRecord {
  /// Minimum valid puff count (0).
  static const Number minPuffs = Number.zero;

  /// Creates an inhaler usage record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [puffs]: The number of puffs taken from the inhaler (must be >= 0).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [puffs] is negative.
  /// - [ArgumentError] if [endTime] is not after [startTime].
  InhalerUsageRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.puffs,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    require(
      condition: puffs >= minPuffs,
      value: puffs,
      name: 'puffs',
      message: 'Puffs must be greater than or equal to 0. Got ${puffs.value}.',
    );
  }

  /// Internal factory for creating [InhalerUsageRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [InhalerUsageRecord] constructor, which enforces validation.
  @internalUse
  factory InhalerUsageRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Number puffs,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return InhalerUsageRecord._(
      startTime: startTime,
      endTime: endTime,
      puffs: puffs,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  InhalerUsageRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.puffs,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The number of puffs taken from the inhaler.
  ///
  /// Must be non-negative (>= 0).
  final Number puffs;

  /// Creates a copy with the given fields replaced with the new values.
  InhalerUsageRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? puffs,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return InhalerUsageRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      puffs: puffs ?? this.puffs,
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
      other is InhalerUsageRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          puffs == other.puffs &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      puffs.hashCode ^
      metadata.hashCode;
}
