part of 'health_record.dart';

/// Represents a record of the number of times the user has fallen.
///
/// [NumberOfTimesFallenRecord] tracks the number of times the user fell during
/// a specific time period.
///
/// ## See also
///
/// - [NumberOfTimesFallenDataType]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealth
@immutable
final class NumberOfTimesFallenRecord extends IntervalHealthRecord {
  /// Minimum valid count (0).
  static const Number minCount = Number.zero;

  /// Maximum valid count (100).
  ///
  /// Represents a safety margin.
  static const Number maxCount = Number(100);

  /// Creates a number of times fallen record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [count]: The number of times fallen (must be >= 0).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [count] is negative.
  /// - [ArgumentError] if [endTime] is not after [startTime].
  NumberOfTimesFallenRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    require(
      condition: count >= minCount && count <= maxCount,
      value: count,
      name: 'count',
      message:
          'Count must be between ${minCount.value.toInt()}-'
          '${maxCount.value.toInt()}. '
          'Got ${count.value.toInt()}.',
    );
  }

  /// Internal factory for creating [OxygenSaturationRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory NumberOfTimesFallenRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Number count,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return NumberOfTimesFallenRecord._(
      startTime: startTime,
      endTime: endTime,
      count: count,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  NumberOfTimesFallenRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The number of times fallen.
  final Number count;

  /// Creates a copy with the given fields replaced with the new values.
  NumberOfTimesFallenRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? count,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return NumberOfTimesFallenRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      count: count ?? this.count,
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
      other is NumberOfTimesFallenRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          count == other.count &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      count.hashCode ^
      metadata.hashCode;
}
