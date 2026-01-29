part of '../health_record.dart';

/// Types of exercise state transitions.
///
/// These represent pause/resume events that occur during an excercise session.
/// State transitions are only supported on iOS HealthKit via `HKWorkoutEvent`.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: Fully supported via [`HKWorkoutEventType`](https://developer.apple.com/documentation/healthkit/hkworkouteventtype).
/// - **Android Health Connect**: Not supported.
///
/// {@category Health Records}
@sinceV3_7_0
@supportedOnAppleHealth
enum ExerciseSessionStateTransitionType {
  /// User manually paused the workout.
  pause,

  /// User manually resumed the workout.
  resume,

  /// System auto-paused due to no motion detected.
  motionPaused,

  /// System auto-resumed after motion detected.
  motionResumed,

  /// User requested pause/resume toggle.
  pauseOrResumeRequest,
}
