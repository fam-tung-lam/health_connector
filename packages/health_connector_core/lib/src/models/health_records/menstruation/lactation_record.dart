part of '../health_record.dart';

/// A record representing a lactation event.
///
/// [LactationRecord] tracks a lactation (breastfeeding) session. This is an
/// interval-based record.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.lactation`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/lactation)
/// - **Android Health Connect**: Not supported.
///
/// ## Example
///
/// ```dart
/// final record = LactationRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 20)),
///   endTime: DateTime.now(),
///   metadata: Metadata.manuallyRecorded(),
/// );
/// ```
///
/// ## See also
///
/// - [LactationDataType]
///
/// {@category Reproductive Health}
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
class LactationRecord extends IntervalHealthRecord {
  /// Creates a lactation record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the lactation session (inclusive).
  /// - [endTime]: The end of the lactation session (exclusive).
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  LactationRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// {@macro health_record.internal}
  @internalUse
  factory LactationRecord.internal({
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required HealthRecordId id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return LactationRecord._(
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  LactationRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Creates a copy of this record with the given fields replaced by the new
  /// values.
  LactationRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    Metadata? metadata,
    HealthRecordId? id,
  }) {
    return LactationRecord(
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
      other is LactationRecord &&
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
