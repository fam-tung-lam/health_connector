import 'package:health_connector_core/health_connector_core_internal.dart'
    show ExerciseSegmentType;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show ExerciseSegmentTypeDto;
import 'package:meta/meta.dart' show internal;

/// Extension to convert [ExerciseSegmentType] to [ExerciseSegmentTypeDto].
@internal
extension ExerciseSegmentTypeToDto on ExerciseSegmentType {
  ExerciseSegmentTypeDto toDto() {
    return switch (this) {
      ExerciseSegmentType.unknown => ExerciseSegmentTypeDto.unknown,
      ExerciseSegmentType.armCurl => ExerciseSegmentTypeDto.armCurl,
      ExerciseSegmentType.backExtension => ExerciseSegmentTypeDto.backExtension,
      ExerciseSegmentType.ballSlam => ExerciseSegmentTypeDto.ballSlam,
      ExerciseSegmentType.barbellShoulderPress =>
        ExerciseSegmentTypeDto.barbellShoulderPress,
      ExerciseSegmentType.benchPress => ExerciseSegmentTypeDto.benchPress,
      ExerciseSegmentType.benchSitUp => ExerciseSegmentTypeDto.benchSitUp,
      ExerciseSegmentType.biking => ExerciseSegmentTypeDto.biking,
      ExerciseSegmentType.bikingStationary =>
        ExerciseSegmentTypeDto.bikingStationary,
      ExerciseSegmentType.burpee => ExerciseSegmentTypeDto.burpee,
      ExerciseSegmentType.crunch => ExerciseSegmentTypeDto.crunch,
      ExerciseSegmentType.deadlift => ExerciseSegmentTypeDto.deadlift,
      ExerciseSegmentType.doubleArmTricepsExtension =>
        ExerciseSegmentTypeDto.doubleArmTricepsExtension,
      ExerciseSegmentType.dumbbellCurlLeftArm =>
        ExerciseSegmentTypeDto.dumbbellCurlLeftArm,
      ExerciseSegmentType.dumbbellCurlRightArm =>
        ExerciseSegmentTypeDto.dumbbellCurlRightArm,
      ExerciseSegmentType.dumbbellFrontRaise =>
        ExerciseSegmentTypeDto.dumbbellFrontRaise,
      ExerciseSegmentType.dumbbellLateralRaise =>
        ExerciseSegmentTypeDto.dumbbellLateralRaise,
      ExerciseSegmentType.dumbbellRow => ExerciseSegmentTypeDto.dumbbellRow,
      ExerciseSegmentType.dumbbellTricepsExtensionLeftArm =>
        ExerciseSegmentTypeDto.dumbbellTricepsExtensionLeftArm,
      ExerciseSegmentType.dumbbellTricepsExtensionRightArm =>
        ExerciseSegmentTypeDto.dumbbellTricepsExtensionRightArm,
      ExerciseSegmentType.dumbbellTricepsExtensionTwoArm =>
        ExerciseSegmentTypeDto.dumbbellTricepsExtensionTwoArm,
      ExerciseSegmentType.elliptical => ExerciseSegmentTypeDto.elliptical,
      ExerciseSegmentType.forwardTwist => ExerciseSegmentTypeDto.forwardTwist,
      ExerciseSegmentType.frontRaise => ExerciseSegmentTypeDto.frontRaise,
      ExerciseSegmentType.highIntensityIntervalTraining =>
        ExerciseSegmentTypeDto.highIntensityIntervalTraining,
      ExerciseSegmentType.hipThrust => ExerciseSegmentTypeDto.hipThrust,
      ExerciseSegmentType.hulaHoop => ExerciseSegmentTypeDto.hulaHoop,
      ExerciseSegmentType.jumpingJack => ExerciseSegmentTypeDto.jumpingJack,
      ExerciseSegmentType.jumpRope => ExerciseSegmentTypeDto.jumpRope,
      ExerciseSegmentType.kettlebellSwing =>
        ExerciseSegmentTypeDto.kettlebellSwing,
      ExerciseSegmentType.lateralRaise => ExerciseSegmentTypeDto.lateralRaise,
      ExerciseSegmentType.latPullDown => ExerciseSegmentTypeDto.latPullDown,
      ExerciseSegmentType.legCurl => ExerciseSegmentTypeDto.legCurl,
      ExerciseSegmentType.legExtension => ExerciseSegmentTypeDto.legExtension,
      ExerciseSegmentType.legPress => ExerciseSegmentTypeDto.legPress,
      ExerciseSegmentType.legRaise => ExerciseSegmentTypeDto.legRaise,
      ExerciseSegmentType.lunge => ExerciseSegmentTypeDto.lunge,
      ExerciseSegmentType.mountainClimber =>
        ExerciseSegmentTypeDto.mountainClimber,
      ExerciseSegmentType.otherWorkout => ExerciseSegmentTypeDto.otherWorkout,
      ExerciseSegmentType.pause => ExerciseSegmentTypeDto.pause,
      ExerciseSegmentType.pilates => ExerciseSegmentTypeDto.pilates,
      ExerciseSegmentType.plank => ExerciseSegmentTypeDto.plank,
      ExerciseSegmentType.pullUp => ExerciseSegmentTypeDto.pullUp,
      ExerciseSegmentType.punch => ExerciseSegmentTypeDto.punch,
      ExerciseSegmentType.rest => ExerciseSegmentTypeDto.rest,
      ExerciseSegmentType.rowingMachine => ExerciseSegmentTypeDto.rowingMachine,
      ExerciseSegmentType.running => ExerciseSegmentTypeDto.running,
      ExerciseSegmentType.runningTreadmill =>
        ExerciseSegmentTypeDto.runningTreadmill,
      ExerciseSegmentType.shoulderPress => ExerciseSegmentTypeDto.shoulderPress,
      ExerciseSegmentType.singleArmTricepsExtension =>
        ExerciseSegmentTypeDto.singleArmTricepsExtension,
      ExerciseSegmentType.sitUp => ExerciseSegmentTypeDto.sitUp,
      ExerciseSegmentType.squat => ExerciseSegmentTypeDto.squat,
      ExerciseSegmentType.stairClimbing => ExerciseSegmentTypeDto.stairClimbing,
      ExerciseSegmentType.stairClimbingMachine =>
        ExerciseSegmentTypeDto.stairClimbingMachine,
      ExerciseSegmentType.stretching => ExerciseSegmentTypeDto.stretching,
      ExerciseSegmentType.swimmingBackstroke =>
        ExerciseSegmentTypeDto.swimmingBackstroke,
      ExerciseSegmentType.swimmingBreaststroke =>
        ExerciseSegmentTypeDto.swimmingBreaststroke,
      ExerciseSegmentType.swimmingButterfly =>
        ExerciseSegmentTypeDto.swimmingButterfly,
      ExerciseSegmentType.swimmingFreestyle =>
        ExerciseSegmentTypeDto.swimmingFreestyle,
      ExerciseSegmentType.swimmingMixed => ExerciseSegmentTypeDto.swimmingMixed,
      ExerciseSegmentType.swimmingOpenWater =>
        ExerciseSegmentTypeDto.swimmingOpenWater,
      ExerciseSegmentType.swimmingOther => ExerciseSegmentTypeDto.swimmingOther,
      ExerciseSegmentType.swimmingPool => ExerciseSegmentTypeDto.swimmingPool,
      ExerciseSegmentType.upperTwist => ExerciseSegmentTypeDto.upperTwist,
      ExerciseSegmentType.walking => ExerciseSegmentTypeDto.walking,
      ExerciseSegmentType.weightlifting => ExerciseSegmentTypeDto.weightlifting,
      ExerciseSegmentType.wheelchair => ExerciseSegmentTypeDto.wheelchair,
      ExerciseSegmentType.yoga => ExerciseSegmentTypeDto.yoga,
    };
  }
}

/// Extension to convert [ExerciseSegmentTypeDto] to [ExerciseSegmentType].
@internal
extension ExerciseSegmentTypeDtoToDomain on ExerciseSegmentTypeDto {
  ExerciseSegmentType toDomain() {
    return switch (this) {
      ExerciseSegmentTypeDto.unknown => ExerciseSegmentType.unknown,
      ExerciseSegmentTypeDto.armCurl => ExerciseSegmentType.armCurl,
      ExerciseSegmentTypeDto.backExtension => ExerciseSegmentType.backExtension,
      ExerciseSegmentTypeDto.ballSlam => ExerciseSegmentType.ballSlam,
      ExerciseSegmentTypeDto.barbellShoulderPress =>
        ExerciseSegmentType.barbellShoulderPress,
      ExerciseSegmentTypeDto.benchPress => ExerciseSegmentType.benchPress,
      ExerciseSegmentTypeDto.benchSitUp => ExerciseSegmentType.benchSitUp,
      ExerciseSegmentTypeDto.biking => ExerciseSegmentType.biking,
      ExerciseSegmentTypeDto.bikingStationary =>
        ExerciseSegmentType.bikingStationary,
      ExerciseSegmentTypeDto.burpee => ExerciseSegmentType.burpee,
      ExerciseSegmentTypeDto.crunch => ExerciseSegmentType.crunch,
      ExerciseSegmentTypeDto.deadlift => ExerciseSegmentType.deadlift,
      ExerciseSegmentTypeDto.doubleArmTricepsExtension =>
        ExerciseSegmentType.doubleArmTricepsExtension,
      ExerciseSegmentTypeDto.dumbbellCurlLeftArm =>
        ExerciseSegmentType.dumbbellCurlLeftArm,
      ExerciseSegmentTypeDto.dumbbellCurlRightArm =>
        ExerciseSegmentType.dumbbellCurlRightArm,
      ExerciseSegmentTypeDto.dumbbellFrontRaise =>
        ExerciseSegmentType.dumbbellFrontRaise,
      ExerciseSegmentTypeDto.dumbbellLateralRaise =>
        ExerciseSegmentType.dumbbellLateralRaise,
      ExerciseSegmentTypeDto.dumbbellRow => ExerciseSegmentType.dumbbellRow,
      ExerciseSegmentTypeDto.dumbbellTricepsExtensionLeftArm =>
        ExerciseSegmentType.dumbbellTricepsExtensionLeftArm,
      ExerciseSegmentTypeDto.dumbbellTricepsExtensionRightArm =>
        ExerciseSegmentType.dumbbellTricepsExtensionRightArm,
      ExerciseSegmentTypeDto.dumbbellTricepsExtensionTwoArm =>
        ExerciseSegmentType.dumbbellTricepsExtensionTwoArm,
      ExerciseSegmentTypeDto.elliptical => ExerciseSegmentType.elliptical,
      ExerciseSegmentTypeDto.forwardTwist => ExerciseSegmentType.forwardTwist,
      ExerciseSegmentTypeDto.frontRaise => ExerciseSegmentType.frontRaise,
      ExerciseSegmentTypeDto.highIntensityIntervalTraining =>
        ExerciseSegmentType.highIntensityIntervalTraining,
      ExerciseSegmentTypeDto.hipThrust => ExerciseSegmentType.hipThrust,
      ExerciseSegmentTypeDto.hulaHoop => ExerciseSegmentType.hulaHoop,
      ExerciseSegmentTypeDto.jumpingJack => ExerciseSegmentType.jumpingJack,
      ExerciseSegmentTypeDto.jumpRope => ExerciseSegmentType.jumpRope,
      ExerciseSegmentTypeDto.kettlebellSwing =>
        ExerciseSegmentType.kettlebellSwing,
      ExerciseSegmentTypeDto.lateralRaise => ExerciseSegmentType.lateralRaise,
      ExerciseSegmentTypeDto.latPullDown => ExerciseSegmentType.latPullDown,
      ExerciseSegmentTypeDto.legCurl => ExerciseSegmentType.legCurl,
      ExerciseSegmentTypeDto.legExtension => ExerciseSegmentType.legExtension,
      ExerciseSegmentTypeDto.legPress => ExerciseSegmentType.legPress,
      ExerciseSegmentTypeDto.legRaise => ExerciseSegmentType.legRaise,
      ExerciseSegmentTypeDto.lunge => ExerciseSegmentType.lunge,
      ExerciseSegmentTypeDto.mountainClimber =>
        ExerciseSegmentType.mountainClimber,
      ExerciseSegmentTypeDto.otherWorkout => ExerciseSegmentType.otherWorkout,
      ExerciseSegmentTypeDto.pause => ExerciseSegmentType.pause,
      ExerciseSegmentTypeDto.pilates => ExerciseSegmentType.pilates,
      ExerciseSegmentTypeDto.plank => ExerciseSegmentType.plank,
      ExerciseSegmentTypeDto.pullUp => ExerciseSegmentType.pullUp,
      ExerciseSegmentTypeDto.punch => ExerciseSegmentType.punch,
      ExerciseSegmentTypeDto.rest => ExerciseSegmentType.rest,
      ExerciseSegmentTypeDto.rowingMachine => ExerciseSegmentType.rowingMachine,
      ExerciseSegmentTypeDto.running => ExerciseSegmentType.running,
      ExerciseSegmentTypeDto.runningTreadmill =>
        ExerciseSegmentType.runningTreadmill,
      ExerciseSegmentTypeDto.shoulderPress => ExerciseSegmentType.shoulderPress,
      ExerciseSegmentTypeDto.singleArmTricepsExtension =>
        ExerciseSegmentType.singleArmTricepsExtension,
      ExerciseSegmentTypeDto.sitUp => ExerciseSegmentType.sitUp,
      ExerciseSegmentTypeDto.squat => ExerciseSegmentType.squat,
      ExerciseSegmentTypeDto.stairClimbing => ExerciseSegmentType.stairClimbing,
      ExerciseSegmentTypeDto.stairClimbingMachine =>
        ExerciseSegmentType.stairClimbingMachine,
      ExerciseSegmentTypeDto.stretching => ExerciseSegmentType.stretching,
      ExerciseSegmentTypeDto.swimmingBackstroke =>
        ExerciseSegmentType.swimmingBackstroke,
      ExerciseSegmentTypeDto.swimmingBreaststroke =>
        ExerciseSegmentType.swimmingBreaststroke,
      ExerciseSegmentTypeDto.swimmingButterfly =>
        ExerciseSegmentType.swimmingButterfly,
      ExerciseSegmentTypeDto.swimmingFreestyle =>
        ExerciseSegmentType.swimmingFreestyle,
      ExerciseSegmentTypeDto.swimmingMixed => ExerciseSegmentType.swimmingMixed,
      ExerciseSegmentTypeDto.swimmingOpenWater =>
        ExerciseSegmentType.swimmingOpenWater,
      ExerciseSegmentTypeDto.swimmingOther => ExerciseSegmentType.swimmingOther,
      ExerciseSegmentTypeDto.swimmingPool => ExerciseSegmentType.swimmingPool,
      ExerciseSegmentTypeDto.upperTwist => ExerciseSegmentType.upperTwist,
      ExerciseSegmentTypeDto.walking => ExerciseSegmentType.walking,
      ExerciseSegmentTypeDto.weightlifting => ExerciseSegmentType.weightlifting,
      ExerciseSegmentTypeDto.wheelchair => ExerciseSegmentType.wheelchair,
      ExerciseSegmentTypeDto.yoga => ExerciseSegmentType.yoga,
    };
  }
}
