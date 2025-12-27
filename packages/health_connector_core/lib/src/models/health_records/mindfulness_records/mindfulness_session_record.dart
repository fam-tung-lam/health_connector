part of '../health_record.dart';

/// Represents a mindfulness session over a time interval.
///
/// A mindfulness session captures a period of focused mental practice such as
/// meditation, breathing exercises, or other mindfulness activities.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`MindfulnessSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MindfulnessSessionRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.mindfulSession`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/mindfulsession)
///
/// ## Example
///
/// ```dart
/// final session = MindfulnessSessionRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 15)),
///   endTime: DateTime.now(),
///   sessionType: MindfulnessSessionType.meditation,
///   title: 'Morning Meditation',
///   notes: 'Focused on breath awareness',
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [MindfulnessSessionDataType]
/// - [MindfulnessSessionType]
///
/// {@category Health Records}
@sinceV2_1_0
@immutable
final class MindfulnessSessionRecord extends IntervalHealthRecord {
  /// Creates a mindfulness session record.
  ///
  /// The session spans from [startTime] to [endTime] and is categorized by
  /// [sessionType]. Optional [title] and [notes] can provide additional context.
  const MindfulnessSessionRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.sessionType,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  });

  /// The type of mindfulness session.
  ///
  /// See [MindfulnessSessionType] for available types.
  final MindfulnessSessionType sessionType;

  /// Optional user-defined title for the session.
  ///
  /// Example: "Morning Meditation", "Evening Wind-down"
  final String? title;

  /// Optional user-defined notes about the session.
  ///
  /// Example: "Focused on breath awareness", "Felt very relaxed"
  final String? notes;

  /// Creates a copy with the given fields replaced with the new values.
  MindfulnessSessionRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    MindfulnessSessionType? sessionType,
    String? title,
    String? notes,
  }) {
    return MindfulnessSessionRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      sessionType: sessionType ?? this.sessionType,
      title: title ?? this.title,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MindfulnessSessionRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          sessionType == other.sessionType &&
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
      sessionType.hashCode ^
      title.hashCode ^
      notes.hashCode;
}
