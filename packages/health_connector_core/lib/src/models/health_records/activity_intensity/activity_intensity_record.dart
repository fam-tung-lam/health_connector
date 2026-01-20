part of '../health_record.dart';

/// Represents an activity intensity measurement over a time interval.
///
/// Tracks periods of moderate or vigorous physical activity.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`ActivityIntensityRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ActivityIntensityRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Example
///
/// ```dart
/// final activity = ActivityIntensityRecord(
///   startTime: DateTime(2024, 1, 15, 7, 0),
///   endTime: DateTime(2024, 1, 15, 8, 0),
///   activityIntensityType: ActivityIntensityType.vigorous,
///   title: 'Morning Run',
///   notes: 'Felt energized',
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [ActivityIntensityDataType]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnHealthConnect
@immutable
final class ActivityIntensityRecord extends IntervalHealthRecord {
  /// Creates an activity intensity record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [activityIntensityType]: The intensity category of activity.
  ///
  /// ## Throws
  ///
  /// - [InvalidArgumentException] if [startTime] is after [endTime].
  ActivityIntensityRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.activityIntensityType,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  });

  /// Internal factory for creating [ActivityIntensityRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [ActivityIntensityRecord] constructor, which enforces validation.
  @internalUse
  factory ActivityIntensityRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required ActivityIntensityType activityIntensityType,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    String? title,
    String? notes,
  }) {
    return ActivityIntensityRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      activityIntensityType: activityIntensityType,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      title: title,
      notes: notes,
    );
  }

  ActivityIntensityRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.activityIntensityType,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  });

  /// The intensity type of the activity.
  final ActivityIntensityType activityIntensityType;

  /// Optional user-defined title for the activity period.
  final String? title;

  /// Optional user-defined notes about the activity period.
  final String? notes;

  /// Creates a copy with the given fields replaced with the new values.
  ActivityIntensityRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    ActivityIntensityType? activityIntensityType,
    String? title,
    String? notes,
  }) {
    return ActivityIntensityRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      activityIntensityType:
          activityIntensityType ?? this.activityIntensityType,
      title: title ?? this.title,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityIntensityRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          activityIntensityType == other.activityIntensityType &&
          title == other.title &&
          notes == other.notes;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      activityIntensityType.hashCode ^
      title.hashCode ^
      notes.hashCode;
}
