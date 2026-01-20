part of '../health_record.dart';

/// Represents a physical exercise session.
///
/// An exercise session tracks a period of physical activity with a specific
/// exercise type, optional title, and notes.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`ExerciseSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSessionRecord)
/// - **iOS HealthKit**: [`HKWorkoutTypeIdentifier`](https://developer.apple.com/documentation/healthkit/hkworkouttypeidentifier)
///
/// ## Example
///
/// ```dart
/// final exercise = ExerciseSessionRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime(2024, 1, 15, 7, 0),
///   endTime: DateTime(2024, 1, 15, 8, 0),
///   exerciseType: ExerciseType.running,
///   title: 'Morning Run',
///   notes: 'Felt great!',
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [ExerciseSessionDataType]
///
/// {@category Health Records}
@sinceV2_0_0
@immutable
final class ExerciseSessionRecord extends IntervalHealthRecord {
  /// Creates an exercise session record with platform-specific validation.
  ///
  /// The session spans from [startTime] to [endTime] and is categorized by
  /// [exerciseType].
  ///
  /// Optional [title] and [notes] can be provided to add context. Use
  /// [metadata] to describe the data source. Timezone offsets can be provided
  /// via [startZoneOffsetSeconds] and [endZoneOffsetSeconds] to handle
  /// exercises that span timezone changes (e.g., DST transitions).
  ///
  /// ## Throws
  ///
  /// - [InvalidArgumentException] if [startTime] is after [endTime].
  ExerciseSessionRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.exerciseType,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  });

  /// Internal factory for creating [ExerciseSessionRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [ExerciseSessionRecord] constructor, which enforces validation.
  @internalUse
  factory ExerciseSessionRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required ExerciseType exerciseType,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    String? title,
    String? notes,
  }) {
    return ExerciseSessionRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      exerciseType: exerciseType,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      title: title,
      notes: notes,
    );
  }

  ExerciseSessionRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.exerciseType,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  });

  /// The type of exercise performed during this session.
  ///
  /// Examples: [ExerciseType.running], [ExerciseType.strengthTraining],
  /// [ExerciseType.swimming]
  final ExerciseType exerciseType;

  /// Optional user-defined title for the exercise session.
  ///
  /// Example: "Morning Run", "Leg Day", "Pool Workout"
  final String? title;

  /// Optional user-defined notes about the exercise session.
  ///
  /// Example: "Felt strong today", "New personal record",
  /// "Need to improve form"
  final String? notes;

  /// Creates a copy with the given fields replaced with the new values.
  ExerciseSessionRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    ExerciseType? exerciseType,
    String? title,
    String? notes,
  }) {
    return ExerciseSessionRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      exerciseType: exerciseType ?? this.exerciseType,
      title: title ?? this.title,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSessionRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          exerciseType == other.exerciseType &&
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
      exerciseType.hashCode ^
      title.hashCode ^
      notes.hashCode;
}
