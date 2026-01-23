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
///     device: Device.fromType(DeviceType.watch),
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
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  MindfulnessSessionRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.sessionType,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.title,
    this.notes,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// Internal factory for creating [MindfulnessSessionRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [MindfulnessSessionRecord] constructor, which enforces validation.
  @internalUse
  factory MindfulnessSessionRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required MindfulnessSessionType sessionType,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    String? title,
    String? notes,
  }) {
    return MindfulnessSessionRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      sessionType: sessionType,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      title: title,
      notes: notes,
    );
  }

  MindfulnessSessionRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.sessionType,
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

/// Type of mindfulness session.
///
/// Represents different types of mindfulness activities that can be recorded.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Maps to
///   `MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_*` constants.
/// - **iOS HealthKit**: Stored in custom metadata since iOS HealthKit only
///   supports generic `HKCategoryValue.notApplicable` type.
///
/// [!NOTE]
/// **iOS HealthKit Limitation**: HealthKit only supports a single generic
/// mindfulness category type with `HKCategoryValue.notApplicable`. The
/// [MindfulnessSessionType] is preserved via custom metadata when writing
/// through this SDK.
/// When viewing in the native iOS Apple Health app, all sessions appear as
/// generic "Mindful Minutes" without type differentiation.
///
/// {@category Health Records}
@sinceV2_1_0
enum MindfulnessSessionType {
  /// Unknown or unspecified session type.
  ///
  /// Health Connect value: `MINDFULNESS_SESSION_TYPE_UNKNOWN` (0)
  unknown,

  /// Meditation session.
  ///
  /// Focused mental practice for relaxation, awareness, or spiritual growth.
  meditation,

  /// Breathing exercise session.
  ///
  /// Controlled breathing techniques for relaxation or focus.
  breathing,

  /// Music-based mindfulness session.
  ///
  /// Mindfulness practice accompanied by music or sound therapy.
  music,

  /// Movement-based mindfulness session.
  ///
  /// Mindful movement practices such as walking meditation or gentle
  /// stretching.
  movement,

  /// Unguided mindfulness session.
  ///
  /// Self-directed mindfulness practice without external guidance.
  unguided,
}
