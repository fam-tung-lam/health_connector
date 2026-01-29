import 'package:health_connector/health_connector_internal.dart'
    show ExerciseSegmentType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension providing display names for [ExerciseSegmentType] enum values.
extension ExerciseSegmentTypeDisplayName on ExerciseSegmentType {
  /// Returns the localized display name for this exercise segment type.
  String get displayName {
    return switch (this) {
      ExerciseSegmentType.unknown => AppTexts.segmentUnknown,
      ExerciseSegmentType.armCurl => AppTexts.segmentArmCurl,
      ExerciseSegmentType.backExtension => AppTexts.segmentBackExtension,
      ExerciseSegmentType.ballSlam => AppTexts.segmentBallSlam,
      ExerciseSegmentType.barbellShoulderPress =>
        AppTexts.segmentBarbellShoulderPress,
      ExerciseSegmentType.benchPress => AppTexts.segmentBenchPress,
      ExerciseSegmentType.benchSitUp => AppTexts.segmentBenchSitUp,
      ExerciseSegmentType.biking => AppTexts.segmentBiking,
      ExerciseSegmentType.bikingStationary => AppTexts.segmentBikingStationary,
      ExerciseSegmentType.burpee => AppTexts.segmentBurpee,
      ExerciseSegmentType.crunch => AppTexts.segmentCrunch,
      ExerciseSegmentType.deadlift => AppTexts.segmentDeadlift,
      ExerciseSegmentType.doubleArmTricepsExtension =>
        AppTexts.segmentDoubleArmTricepsExtension,
      ExerciseSegmentType.dumbbellCurlLeftArm =>
        AppTexts.segmentDumbbellCurlLeftArm,
      ExerciseSegmentType.dumbbellCurlRightArm =>
        AppTexts.segmentDumbbellCurlRightArm,
      ExerciseSegmentType.dumbbellFrontRaise =>
        AppTexts.segmentDumbbellFrontRaise,
      ExerciseSegmentType.dumbbellLateralRaise =>
        AppTexts.segmentDumbbellLateralRaise,
      ExerciseSegmentType.dumbbellRow => AppTexts.segmentDumbbellRow,
      ExerciseSegmentType.dumbbellTricepsExtensionLeftArm =>
        AppTexts.segmentDumbbellTricepsExtensionLeftArm,
      ExerciseSegmentType.dumbbellTricepsExtensionRightArm =>
        AppTexts.segmentDumbbellTricepsExtensionRightArm,
      ExerciseSegmentType.dumbbellTricepsExtensionTwoArm =>
        AppTexts.segmentDumbbellTricepsExtensionTwoArm,
      ExerciseSegmentType.elliptical => AppTexts.segmentElliptical,
      ExerciseSegmentType.forwardTwist => AppTexts.segmentForwardTwist,
      ExerciseSegmentType.frontRaise => AppTexts.segmentFrontRaise,
      ExerciseSegmentType.highIntensityIntervalTraining =>
        AppTexts.segmentHighIntensityIntervalTraining,
      ExerciseSegmentType.hipThrust => AppTexts.segmentHipThrust,
      ExerciseSegmentType.hulaHoop => AppTexts.segmentHulaHoop,
      ExerciseSegmentType.jumpingJack => AppTexts.segmentJumpingJack,
      ExerciseSegmentType.jumpRope => AppTexts.segmentJumpRope,
      ExerciseSegmentType.kettlebellSwing => AppTexts.segmentKettlebellSwing,
      ExerciseSegmentType.lateralRaise => AppTexts.segmentLateralRaise,
      ExerciseSegmentType.latPullDown => AppTexts.segmentLatPullDown,
      ExerciseSegmentType.legCurl => AppTexts.segmentLegCurl,
      ExerciseSegmentType.legExtension => AppTexts.segmentLegExtension,
      ExerciseSegmentType.legPress => AppTexts.segmentLegPress,
      ExerciseSegmentType.legRaise => AppTexts.segmentLegRaise,
      ExerciseSegmentType.lunge => AppTexts.segmentLunge,
      ExerciseSegmentType.mountainClimber => AppTexts.segmentMountainClimber,
      ExerciseSegmentType.otherWorkout => AppTexts.segmentOtherWorkout,
      ExerciseSegmentType.pause => AppTexts.segmentPause,
      ExerciseSegmentType.pilates => AppTexts.segmentPilates,
      ExerciseSegmentType.plank => AppTexts.segmentPlank,
      ExerciseSegmentType.pullUp => AppTexts.segmentPullUp,
      ExerciseSegmentType.punch => AppTexts.segmentPunch,
      ExerciseSegmentType.rest => AppTexts.segmentRest,
      ExerciseSegmentType.rowingMachine => AppTexts.segmentRowingMachine,
      ExerciseSegmentType.running => AppTexts.segmentRunning,
      ExerciseSegmentType.runningTreadmill => AppTexts.segmentRunningTreadmill,
      ExerciseSegmentType.shoulderPress => AppTexts.segmentShoulderPress,
      ExerciseSegmentType.singleArmTricepsExtension =>
        AppTexts.segmentSingleArmTricepsExtension,
      ExerciseSegmentType.sitUp => AppTexts.segmentSitUp,
      ExerciseSegmentType.squat => AppTexts.segmentSquat,
      ExerciseSegmentType.stairClimbing => AppTexts.segmentStairClimbing,
      ExerciseSegmentType.stairClimbingMachine =>
        AppTexts.segmentStairClimbingMachine,
      ExerciseSegmentType.stretching => AppTexts.segmentStretching,
      ExerciseSegmentType.swimmingBackstroke =>
        AppTexts.segmentSwimmingBackstroke,
      ExerciseSegmentType.swimmingBreaststroke =>
        AppTexts.segmentSwimmingBreaststroke,
      ExerciseSegmentType.swimmingButterfly =>
        AppTexts.segmentSwimmingButterfly,
      ExerciseSegmentType.swimmingFreestyle =>
        AppTexts.segmentSwimmingFreestyle,
      ExerciseSegmentType.swimmingMixed => AppTexts.segmentSwimmingMixed,
      ExerciseSegmentType.swimmingOpenWater =>
        AppTexts.segmentSwimmingOpenWater,
      ExerciseSegmentType.swimmingOther => AppTexts.segmentSwimmingOther,
      ExerciseSegmentType.swimmingPool => AppTexts.segmentSwimmingPool,
      ExerciseSegmentType.upperTwist => AppTexts.segmentUpperTwist,
      ExerciseSegmentType.walking => AppTexts.segmentWalking,
      ExerciseSegmentType.weightlifting => AppTexts.segmentWeightlifting,
      ExerciseSegmentType.wheelchair => AppTexts.segmentWheelchair,
      ExerciseSegmentType.yoga => AppTexts.segmentYoga,
    };
  }
}
