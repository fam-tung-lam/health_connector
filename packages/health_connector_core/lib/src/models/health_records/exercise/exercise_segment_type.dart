part of '../health_record.dart';

/// Types of exercise segments within an exercise session.
///
/// Segments describe specific exercises or exercise session phases.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Direct mapping to [`ExerciseSegment.EXERCISE_SEGMENT_TYPE_*`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseSegment).
/// - **iOS HealthKit**: Not supported natively. Handled by the SDK and stored
///   in [`HKWorkoutEvent.metadata`](https://developer.apple.com/documentation/healthkit/hkworkoutevent/metadata) as custom key-value pairs.
///
/// {@category Health Records}
@sinceV3_7_0
enum ExerciseSegmentType {
  /// Use this type if the type of the exercise segment is not known.
  unknown,

  /// Use this type for arm curls.
  armCurl,

  /// Use this type for back extensions.
  backExtension,

  /// Use this type for ball slams.
  ballSlam,

  /// Use this type for barbell shoulder press.
  barbellShoulderPress,

  /// Use this type for bench presses.
  benchPress,

  /// Use this type for bench sit up.
  benchSitUp,

  /// Use this type for biking.
  biking,

  /// Use this type for stationary biking.
  bikingStationary,

  /// Use this type for burpees.
  burpee,

  /// Use this type for crunches.
  crunch,

  /// Use this type for deadlifts.
  deadlift,

  /// Use this type for double arm triceps extensions.
  doubleArmTricepsExtension,

  /// Use this type for left arm dumbbell curl.
  dumbbellCurlLeftArm,

  /// Use this type for right arm dumbbell curl.
  dumbbellCurlRightArm,

  /// Use this type for dumbbell front raise.
  dumbbellFrontRaise,

  /// Use this type for dumbbell lateral raises.
  dumbbellLateralRaise,

  /// Use this type for dumbbell rows.
  dumbbellRow,

  /// Use this type for left arm triceps extensions.
  dumbbellTricepsExtensionLeftArm,

  /// Use this type for right arm triceps extensions.
  dumbbellTricepsExtensionRightArm,

  /// Use this type for two arm triceps extensions.
  dumbbellTricepsExtensionTwoArm,

  /// Use this type for elliptical workout.
  elliptical,

  /// Use this type for forward twists.
  forwardTwist,

  /// Use this type for front raises.
  frontRaise,

  /// Use this type for high intensity interval training.
  highIntensityIntervalTraining,

  /// Use this type for hip thrusts.
  hipThrust,

  /// Use this type for hula-hoops.
  hulaHoop,

  /// Use this type for jumping jacks.
  jumpingJack,

  /// Use this type for jump rope.
  jumpRope,

  /// Use this type for kettlebell swings.
  kettlebellSwing,

  /// Use this type for lateral raises.
  lateralRaise,

  /// Use this type for lat pull-downs.
  latPullDown,

  /// Use this type for leg curls.
  legCurl,

  /// Use this type for leg extensions.
  legExtension,

  /// Use this type for leg presses.
  legPress,

  /// Use this type for leg raises.
  legRaise,

  /// Use this type for lunges.
  lunge,

  /// Use this type for mountain climber.
  mountainClimber,

  /// Use this type for other workout.
  otherWorkout,

  /// Use this type for the pause.
  pause,

  /// Use this type for pilates.
  pilates,

  /// Use this type for plank.
  plank,

  /// Use this type for pull-ups.
  pullUp,

  /// Use this type for punches.
  punch,

  /// Use this type for the rest.
  rest,

  /// Use this type for rowing machine workout.
  rowingMachine,

  /// Use this type for running.
  running,

  /// Use this type for treadmill running.
  runningTreadmill,

  /// Use this type for shoulder press.
  shoulderPress,

  /// Use this type for single arm triceps extension.
  singleArmTricepsExtension,

  /// Use this type for sit-ups.
  sitUp,

  /// Use this type for squats.
  squat,

  /// Use this type for stair climbing.
  stairClimbing,

  /// Use this type for stair climbing machine.
  stairClimbingMachine,

  /// Use this type for stretching.
  stretching,

  /// Use this type for backstroke swimming.
  swimmingBackstroke,

  /// Use this type for breaststroke swimming.
  swimmingBreaststroke,

  /// Use this type for butterfly swimming.
  swimmingButterfly,

  /// Use this type for freestyle swimming.
  swimmingFreestyle,

  /// Use this type for mixed swimming.
  swimmingMixed,

  /// Use this type for swimming in open water.
  swimmingOpenWater,

  /// Use this type if other swimming styles are not suitable.
  swimmingOther,

  /// Use this type for swimming in the pool.
  swimmingPool,

  /// Use this type for upper twists.
  upperTwist,

  /// Use this type for walking.
  walking,

  /// Use this type for weightlifting.
  weightlifting,

  /// Use this type for wheelchair.
  wheelchair,

  /// Use this type for yoga.
  yoga,
}
