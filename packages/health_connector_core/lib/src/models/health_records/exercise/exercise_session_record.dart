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
///   events: [
///     ExerciseSessionLapEvent(
///       startTime: DateTime(2024, 1, 15, 7, 0),
///       endTime: DateTime(2024, 1, 15, 7, 2),
///       distance: Length.meters(400),
///     ),
///   ],
/// );
/// ```
///
/// ## See also
///
/// - [ExerciseSessionDataType]
/// - [ExerciseSessionEvent]
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
  /// The [events] list contains workout events such as laps, segments,
  /// pause/resume transitions, and markers.
  ///
  /// The optional [exerciseRoute] contains GPS location data recorded during
  /// the session. This is a **write-only** parameter - to read an exercise
  /// route, use `HealthConnector.readExerciseRoute()` instead.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [startTime] is after [endTime].
  /// - [ArgumentError] if any event is outside the session time range.
  /// - [ArgumentError] if lap events overlap.
  /// - [ArgumentError] if segment events overlap.
  /// - [ArgumentError] if marker events have the same time.
  /// - [ArgumentError] if state transition events have the same time.
  /// - [ArgumentError] if any segment event's segment type is not compatible
  ///   with the session's exercise type.
  /// - [ArgumentError] if any route location is outside the session time range.
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
    this.events = const [],
    ExerciseRoute? exerciseRoute,
  }) : _exerciseRoute = exerciseRoute {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    if (events.isNotEmpty) {
      _requireEventsWithinSessionTimeRange(
        events: events,
        sessionStartTime: startTime,
        sessionEndTime: endTime,
      );
      _requireLapEventsDoNotOverlap(
        laps: events.whereType<ExerciseSessionLapEvent>().toList(),
        sessionStartTime: startTime,
        sessionEndTime: endTime,
      );
      _requireSegmentEventsDoNotOverlap(
        segments: events.whereType<ExerciseSessionSegmentEvent>().toList(),
        sessionStartTime: startTime,
        sessionEndTime: endTime,
      );
      _requireMarkerEventsHaveUniqueTimes(
        events.whereType<ExerciseSessionMarkerEvent>().toList(),
      );
      _requireStateTransitionEventsHaveUniqueTimes(
        events.whereType<ExerciseSessionStateTransitionEvent>().toList(),
      );
      _requireSegmentTypesCompatibleWithSessionType(
        segments: events.whereType<ExerciseSessionSegmentEvent>().toList(),
        sessionType: exerciseType,
      );
    }
    if (exerciseRoute != null && exerciseRoute.isNotEmpty) {
      _requireRouteLocationsWithinSessionTimeRange(
        route: exerciseRoute,
        sessionStartTime: startTime,
        sessionEndTime: endTime,
      );
    }
  }

  /// Internal factory for creating [ExerciseSessionRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use.
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
    List<ExerciseSessionEvent> events = const [],
    ExerciseRoute? exerciseRoute,
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
      events: events,
      exerciseRoute: exerciseRoute,
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
    this.events = const [],
    ExerciseRoute? exerciseRoute,
  }) : _exerciseRoute = exerciseRoute;

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

  /// Events and segments within this exercise session.
  ///
  /// Contains a mix of event types:
  /// - [ExerciseSessionStateTransitionEvent] - pause/resume
  /// - [ExerciseSessionMarkerEvent] - arbitrary markers
  /// - [ExerciseSessionLapEvent] - lap timing
  /// - [ExerciseSessionSegmentEvent] - exercise segments
  final List<ExerciseSessionEvent> events;

  /// GPS route data for this exercise session (write-only).
  ///
  /// This field is only used when writing records to the platform. To read
  /// an exercise route, use `HealthConnector.readExerciseRoute()` instead.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  ExerciseRoute? get exerciseRoute => _exerciseRoute;
  final ExerciseRoute? _exerciseRoute;

  /// Convenience getter for state transition events only.
  List<ExerciseSessionStateTransitionEvent> get stateTransitionEvents =>
      events.whereType<ExerciseSessionStateTransitionEvent>().toList();

  /// Convenience getter for marker events only.
  List<ExerciseSessionMarkerEvent> get markerEvents =>
      events.whereType<ExerciseSessionMarkerEvent>().toList();

  /// Convenience getter for lap events only.
  List<ExerciseSessionLapEvent> get lapEvents =>
      events.whereType<ExerciseSessionLapEvent>().toList();

  /// Convenience getter for segment events only.
  List<ExerciseSessionSegmentEvent> get segmentEvents =>
      events.whereType<ExerciseSessionSegmentEvent>().toList();

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
    List<ExerciseSessionEvent>? events,
    ExerciseRoute? exerciseRoute,
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
      events: events ?? this.events,
      exerciseRoute: exerciseRoute ?? _exerciseRoute,
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
          notes == other.notes &&
          const ListEquality<ExerciseSessionEvent>().equals(
            events,
            other.events,
          ) &&
          _exerciseRoute == other._exerciseRoute;

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
      notes.hashCode ^
      const ListEquality<ExerciseSessionEvent>().hash(events) ^
      _exerciseRoute.hashCode;

  /// Validates that all [events] fall within [sessionStartTime] and
  /// [sessionEndTime]:
  ///
  /// - Interval events must have [ExerciseSessionIntervalEvent.startTime] ≥
  ///   [sessionStartTime] and [endTime] ≤ [sessionEndTime].
  /// - Instant events must have [ExerciseSessionInstantEvent.time] within
  ///   the same range.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if any event is outside the session time range.
  static void _requireEventsWithinSessionTimeRange({
    required List<ExerciseSessionEvent> events,
    required DateTime sessionStartTime,
    required DateTime sessionEndTime,
  }) {
    for (final event in events) {
      switch (event) {
        case final ExerciseSessionIntervalEvent e:
          require(
            condition:
                !e.startTime.isBefore(sessionStartTime) &&
                !e.endTime.isAfter(sessionEndTime),
            value: events,
            name: 'events',
            message:
                'Events must be within the session time range. '
                'Got event with startTime=${e.startTime}, endTime=${e.endTime} '
                'outside session $sessionStartTime–$sessionEndTime.',
          );
        case final ExerciseSessionInstantEvent e:
          require(
            condition:
                !e.time.isBefore(sessionStartTime) &&
                !e.time.isAfter(sessionEndTime),
            value: events,
            name: 'events',
            message:
                'Events must be within the session time range. '
                'Got event with time=${e.time} '
                'outside session $sessionStartTime–$sessionEndTime.',
          );
      }
    }
  }

  /// Validates that [laps] are within the session time range and do not
  /// overlap.
  ///
  /// Laps are sorted by start time; the first lap must start at or after
  /// [sessionStartTime], the last lap must end at or before [sessionEndTime],
  /// and each lap's end time must not be after the next lap's start time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if any lap is outside the session time range.
  /// - [ArgumentError] if lap events overlap.
  static void _requireLapEventsDoNotOverlap({
    required List<ExerciseSessionLapEvent> laps,
    required DateTime sessionStartTime,
    required DateTime sessionEndTime,
  }) {
    if (laps.isEmpty) {
      return;
    }

    final sorted = List<ExerciseSessionLapEvent>.from(laps)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
    require(
      condition: !sorted.first.startTime.isBefore(sessionStartTime),
      value: laps,
      name: 'events',
      message:
          'Lap events must be within the session time range. '
          'First lap startTime=${sorted.first.startTime} is before '
          'session startTime=$sessionStartTime.',
    );
    require(
      condition: !sorted.last.endTime.isAfter(sessionEndTime),
      value: laps,
      name: 'events',
      message:
          'Lap events must be within the session time range. '
          'Last lap endTime=${sorted.last.endTime} is after '
          'session endTime=$sessionEndTime.',
    );
    for (var i = 0; i < sorted.length - 1; i++) {
      require(
        condition: !sorted[i].endTime.isAfter(sorted[i + 1].startTime),
        value: laps,
        name: 'events',
        message:
            'Lap events cannot overlap. '
            'Got lap endTime=${sorted[i].endTime} after '
            'next lap startTime=${sorted[i + 1].startTime}.',
      );
    }
  }

  /// Validates that [segments] are within the session time range and do not
  /// overlap.
  ///
  /// Segments are sorted by start time; the first segment must start at or
  /// after [sessionStartTime], the last segment must end at or before
  /// [sessionEndTime], and each segment's end time must not be after the next
  /// segment's start time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if any segment is outside the session time range.
  /// - [ArgumentError] if segment events overlap.
  static void _requireSegmentEventsDoNotOverlap({
    required List<ExerciseSessionSegmentEvent> segments,
    required DateTime sessionStartTime,
    required DateTime sessionEndTime,
  }) {
    if (segments.isEmpty) {
      return;
    }
    final sorted = List<ExerciseSessionSegmentEvent>.from(segments)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
    require(
      condition: !sorted.first.startTime.isBefore(sessionStartTime),
      value: segments,
      name: 'events',
      message:
          'Segment events must be within the session time range. '
          'First segment startTime=${sorted.first.startTime} is before '
          'session startTime=$sessionStartTime.',
    );
    require(
      condition: !sorted.last.endTime.isAfter(sessionEndTime),
      value: segments,
      name: 'events',
      message:
          'Segment events must be within the session time range. '
          'Last segment endTime=${sorted.last.endTime} is after '
          'session endTime=$sessionEndTime.',
    );
    for (var i = 0; i < sorted.length - 1; i++) {
      require(
        condition: !sorted[i].endTime.isAfter(sorted[i + 1].startTime),
        value: segments,
        name: 'events',
        message:
            'Segment events cannot overlap. '
            'Got segment endTime=${sorted[i].endTime} after '
            'next segment startTime=${sorted[i + 1].startTime}.',
      );
    }
  }

  /// Validates that [markers] have distinct
  /// [ExerciseSessionInstantEvent.time] values.
  ///
  /// No two marker events may share the same timestamp.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if two or more marker events have the same time.
  static void _requireMarkerEventsHaveUniqueTimes(
    List<ExerciseSessionMarkerEvent> markers,
  ) {
    if (markers.length < 2) {
      return;
    }
    final times = markers.map((e) => e.time).toList();
    final seen = <DateTime>{};
    for (final time in times) {
      require(
        condition: seen.add(time),
        value: markers,
        name: 'events',
        message:
            'Marker events cannot have the same time. '
            'Got duplicate time $time.',
      );
    }
  }

  /// Validates that [transitions] have distinct
  /// [ExerciseSessionInstantEvent.time] values.
  ///
  /// No two state transition events may share the same timestamp.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if state transition events have the same time.
  static void _requireStateTransitionEventsHaveUniqueTimes(
    List<ExerciseSessionStateTransitionEvent> transitions,
  ) {
    if (transitions.length < 2) {
      return;
    }
    final times = transitions.map((e) => e.time).toList();
    final seen = <DateTime>{};
    for (final time in times) {
      require(
        condition: seen.add(time),
        value: transitions,
        name: 'events',
        message:
            'State transition events cannot have the same time. '
            'Got duplicate time $time.',
      );
    }
  }

  /// Validates that every segment's type is compatible with [sessionType].
  ///
  /// ## Parameters
  ///
  /// - [segments]: The segment events to validate (e.g. from [events]).
  /// - [sessionType]: The session's [exerciseType].
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if any segment type is not compatible with the session
  ///   type.
  static void _requireSegmentTypesCompatibleWithSessionType({
    required List<ExerciseSessionSegmentEvent> segments,
    required ExerciseType sessionType,
  }) {
    final allowed = sessionType.supportedSegmentTypes;
    for (final segment in segments) {
      require(
        condition: allowed.contains(segment.segmentType),
        value: segments,
        name: 'events',
        message:
            'Segment type ${segment.segmentType} is not compatible with '
            'session type $sessionType.',
      );
    }
  }

  /// Validates that all route locations fall within the session time range.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if any route location is outside the session time range.
  static void _requireRouteLocationsWithinSessionTimeRange({
    required ExerciseRoute route,
    required DateTime sessionStartTime,
    required DateTime sessionEndTime,
  }) {
    for (final location in route.locations) {
      require(
        condition:
            !location.time.isBefore(sessionStartTime) &&
            !location.time.isAfter(sessionEndTime),
        value: route,
        name: 'exerciseRoute',
        message:
            'Route locations must be within the session time range. '
            'Got location with time=${location.time} '
            'outside session $sessionStartTime–$sessionEndTime.',
      );
    }
  }
}
