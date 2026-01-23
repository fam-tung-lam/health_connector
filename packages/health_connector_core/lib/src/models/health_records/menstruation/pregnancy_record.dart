part of '../health_record.dart';

/// A record capturing the pregnancy period.
///
/// [PregnancyRecord] tracks a pregnancy interval. This is an interval-based
/// record, meaning it has both a start and end time.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.pregnancy`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/pregnancy)
/// - **Android Health Connect**: Not supported.
///
/// ## Example
///
/// ```dart
/// final record = PregnancyRecord(
///   startTime: DateTime(2023, 1, 1),
///   endTime: DateTime(2023, 9, 30),
///   metadata: Metadata.manuallyRecorded(),
/// );
/// ```
///
/// ## See also
///
/// - [PregnancyDataType]
///
/// {@category Health Records}
/// {@category Reproductive Health}
@sinceV3_1_0
@supportedOnAppleHealth
class PregnancyRecord extends IntervalHealthRecord {
  /// Creates a pregnancy record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the pregnancy term (inclusive).
  /// - [endTime]: The end of the pregnancy term (exclusive).
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  PregnancyRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// {@macro PregnancyRecord}
  @internalUse
  factory PregnancyRecord.fromRecord({
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return PregnancyRecord(
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates a copy of this record with the given fields replaced by the
  /// new values.
  PregnancyRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    Metadata? metadata,
    HealthRecordId? id,
  }) {
    return PregnancyRecord(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PregnancyRecord &&
            runtimeType == other.runtimeType &&
            startTime == other.startTime &&
            endTime == other.endTime &&
            startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
            endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
            metadata == other.metadata &&
            id == other.id;
  }

  @override
  int get hashCode =>
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      metadata.hashCode ^
      id.hashCode;
}
