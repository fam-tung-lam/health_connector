part of '../health_record.dart';

/// Represents a menstruation period record spanning a time interval.
///
/// [MenstruationPeriodRecord] captures user's menstruation periods. This is an
/// interval-based record, meaning it has both a start and end time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`MenstruationPeriodRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MenstruationPeriodRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Example
///
/// ```dart
/// final record = MenstruationPeriodRecord(
///   startTime: DateTime(2024, 1, 1),
///   endTime: DateTime(2024, 1, 5),
///   metadata: Metadata.manuallyRecorded(),
/// );
/// ```
///
/// ## See also
///
/// - [MenstruationPeriodDataType]
///
/// {@category Health Records}
/// {@category Reproductive Health}
@sinceV3_6_0
@supportedOnHealthConnect
@immutable
final class MenstruationPeriodRecord extends IntervalHealthRecord {
  /// Maximum valid duration for a menstruation period (31 days).
  ///
  /// Represents the maximum allowed duration for a menstruation period
  /// according to Android Health Connect API constraints.
  static const Duration maxDuration = Duration(days: 31);

  /// Creates a menstruation period record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the menstruation period (inclusive).
  /// - [endTime]: The end of the menstruation period (exclusive).
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if the duration exceeds [maxDuration] (31 days).
  MenstruationPeriodRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: duration <= maxDuration,
      value: duration,
      name: 'duration',
      message:
          'Menstruation period must not exceed ${maxDuration.inDays} days. '
          'Got ${duration.inDays} days.',
    );
  }

  /// Internal factory for creating [MenstruationPeriodRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory MenstruationPeriodRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return MenstruationPeriodRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  MenstruationPeriodRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  MenstruationPeriodRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    Metadata? metadata,
    HealthRecordId? id,
  }) {
    return MenstruationPeriodRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstruationPeriodRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      metadata.hashCode;
}
