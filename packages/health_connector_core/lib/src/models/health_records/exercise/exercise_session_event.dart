part of '../health_record.dart';

/// Base class for all exercise session events.
///
/// {@category Health Records}
@sinceV3_7_0
@immutable
sealed class ExerciseSessionEvent implements HealthPlatformData {
  /// Creates an exercise session event.
  const ExerciseSessionEvent();
}

/// Base class for exercise session events that have a start and end time.
///
/// {@category Health Records}
@sinceV3_7_0
@immutable
sealed class ExerciseSessionIntervalEvent extends ExerciseSessionEvent {
  /// Creates an interval-based exercise session event.
  const ExerciseSessionIntervalEvent({
    required this.startTime,
    required this.endTime,
  });

  /// Start time of the event.
  final DateTime startTime;

  /// End time of the event.
  final DateTime endTime;

  /// Duration of this event.
  Duration get duration => endTime.difference(startTime);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSessionIntervalEvent &&
          runtimeType == other.runtimeType &&
          startTime == other.startTime &&
          endTime == other.endTime;

  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime);
}

/// Base class for exercise session events that occur at a single point in time.
///
/// {@category Health Records}
@sinceV3_7_0
@immutable
sealed class ExerciseSessionInstantEvent extends ExerciseSessionEvent {
  /// Creates an instant exercise session event.
  const ExerciseSessionInstantEvent({required this.time});

  /// Time of the event.
  final DateTime time;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSessionInstantEvent &&
          runtimeType == other.runtimeType &&
          time == other.time;

  @override
  int get hashCode => Object.hash(runtimeType, time);
}

/// Represents exercise session pause/resume state transitions.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: Mapped from [`HKWorkoutEvent.type`](https://developer.apple.com/documentation/healthkit/hkworkoutevent/type) with pause/resume event types.
/// - **Android Health Connect**: Not supported.
///
/// {@category Health Records}
@sinceV3_7_0
@supportedOnAppleHealth
@immutable
final class ExerciseSessionStateTransitionEvent
    extends ExerciseSessionInstantEvent {
  /// Creates an exercise state transition event.
  const ExerciseSessionStateTransitionEvent({
    required super.time,
    required this.type,
  });

  /// The type of state transition.
  final ExerciseSessionStateTransitionType type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSessionStateTransitionEvent &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          type == other.type;

  @override
  int get hashCode => Object.hash(super.hashCode, type);

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];
}

/// Represents an arbitrary marker point during an exercise.
///
/// Markers are user-defined points of interest during an exercise session.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: Mapped from [`HKWorkoutEvent.type`](https://developer.apple.com/documentation/healthkit/hkworkoutevent/type) with `.marker` type
/// - **Android Health Connect**: Not supported
///
/// {@category Health Records}
@sinceV3_7_0
@supportedOnAppleHealth
@immutable
final class ExerciseSessionMarkerEvent extends ExerciseSessionInstantEvent {
  /// Creates an exercise marker event.
  const ExerciseSessionMarkerEvent({required super.time});

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];
}

/// Represents a lap within an exercise session.
///
/// Laps track time (and optionally distance) for each loop or distance unit,
/// e.g., 400m track lap or 25m pool length.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: Mapped from [`HKWorkoutEvent.type`](https://developer.apple.com/documentation/healthkit/hkworkoutevent/type) with `.lap` type
/// - **Android Health Connect**: Mapped from [`ExerciseLap`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseLap)
///
/// {@category Health Records}
@sinceV3_7_0
@immutable
final class ExerciseSessionLapEvent extends ExerciseSessionIntervalEvent {
  /// Creates an exercise lap event.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: Start time of the lap
  /// - [endTime]: End time of the lap
  /// - [distance]: Optional distance covered during this lap
  ///   (0-1,000,000 meters)
  const ExerciseSessionLapEvent({
    required super.startTime,
    required super.endTime,
    this.distance,
  });

  /// Distance covered during this lap.
  ///
  /// Valid range: 0-1,000,000 meters.
  final Length? distance;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSessionLapEvent &&
          runtimeType == other.runtimeType &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          distance == other.distance;

  @override
  int get hashCode => Object.hash(super.hashCode, distance);
}

/// Represents a segment (exercise phase) within a session.
///
/// Segments describe exercise session structure: warm-up, main set, cooldown,
/// or specific exercises like bench press, running intervals, etc.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: Mapped from [`HKWorkoutEvent.type`](https://developer.apple.com/documentation/healthkit/hkworkoutevent/type) with `.segment` type.
/// - **Android Health Connect**: Mapped from [`ExerciseSegment`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSegment).
///
/// {@category Health Records}
@sinceV3_7_0
@immutable
final class ExerciseSessionSegmentEvent extends ExerciseSessionIntervalEvent {
  /// Creates an exercise segment event.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: Start time of the segment
  /// - [endTime]: End time of the segment
  /// - [segmentType]: The type of exercise segment
  /// - [repetitions]: Optional number of repetitions in this segment
  const ExerciseSessionSegmentEvent({
    required super.startTime,
    required super.endTime,
    required this.segmentType,
    this.repetitions,
  });

  /// The type of exercise segment.
  final ExerciseSegmentType segmentType;

  /// Number of repetitions in this segment (e.g., 10 bench press reps).
  ///
  /// Must be non-negative if provided.
  final int? repetitions;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSessionSegmentEvent &&
          runtimeType == other.runtimeType &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          segmentType == other.segmentType &&
          repetitions == other.repetitions;

  @override
  int get hashCode => Object.hash(
    super.hashCode,
    segmentType,
    repetitions,
  );
}
