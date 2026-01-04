import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

/// Extension to convert [ExerciseType] to [ExerciseTypeDto].
extension ExerciseTypeToDto on ExerciseType {
  /// Converts [ExerciseType] to [ExerciseTypeDto].
  ExerciseTypeDto toDto() {
    return switch (this) {
      // Cardio & Walking/Running
      ExerciseType.running => ExerciseTypeDto.running,
      ExerciseType.runningTreadmill => ExerciseTypeDto.runningTreadmill,
      ExerciseType.walking => ExerciseTypeDto.walking,
      ExerciseType.cycling => ExerciseTypeDto.cycling,
      ExerciseType.cyclingStationary => ExerciseTypeDto.cyclingStationary,
      ExerciseType.hiking => ExerciseTypeDto.hiking,

      // Water Sports
      ExerciseType.swimmingOpenWater => ExerciseTypeDto.swimmingOpenWater,
      ExerciseType.swimmingPool => ExerciseTypeDto.swimmingPool,
      ExerciseType.surfing => ExerciseTypeDto.surfing,
      ExerciseType.waterPolo => ExerciseTypeDto.waterPolo,
      ExerciseType.rowing => ExerciseTypeDto.rowing,
      ExerciseType.sailing => ExerciseTypeDto.sailing,
      ExerciseType.paddling => ExerciseTypeDto.paddling,
      ExerciseType.diving => ExerciseTypeDto.diving,

      // Strength Training
      ExerciseType.strengthTraining => ExerciseTypeDto.strengthTraining,
      ExerciseType.weightlifting => ExerciseTypeDto.weightlifting,
      ExerciseType.calisthenics => ExerciseTypeDto.calisthenics,

      // Team Sports
      ExerciseType.basketball => ExerciseTypeDto.basketball,
      ExerciseType.soccer => ExerciseTypeDto.soccer,
      ExerciseType.americanFootball => ExerciseTypeDto.americanFootball,
      ExerciseType.frisbeeDisc => ExerciseTypeDto.frisbeeDisc,
      ExerciseType.australianFootball => ExerciseTypeDto.australianFootball,
      ExerciseType.baseball => ExerciseTypeDto.baseball,
      ExerciseType.softball => ExerciseTypeDto.softball,
      ExerciseType.volleyball => ExerciseTypeDto.volleyball,
      ExerciseType.rugby => ExerciseTypeDto.rugby,
      ExerciseType.cricket => ExerciseTypeDto.cricket,
      ExerciseType.handball => ExerciseTypeDto.handball,
      ExerciseType.iceHockey => ExerciseTypeDto.iceHockey,
      ExerciseType.rollerHockey => ExerciseTypeDto.rollerHockey,

      // Racquet Sports
      ExerciseType.tennis => ExerciseTypeDto.tennis,
      ExerciseType.tableTennis => ExerciseTypeDto.tableTennis,
      ExerciseType.badminton => ExerciseTypeDto.badminton,
      ExerciseType.squash => ExerciseTypeDto.squash,
      ExerciseType.racquetball => ExerciseTypeDto.racquetball,

      // Winter Sports
      ExerciseType.skiing => ExerciseTypeDto.skiing,
      ExerciseType.snowboarding => ExerciseTypeDto.snowboarding,
      ExerciseType.snowshoeing => ExerciseTypeDto.snowshoeing,
      ExerciseType.skating => ExerciseTypeDto.skating,

      // Martial Arts & Combat Sports
      ExerciseType.boxing => ExerciseTypeDto.boxing,
      ExerciseType.martialArts => ExerciseTypeDto.martialArts,
      ExerciseType.fencing => ExerciseTypeDto.fencing,

      // Dance & Gymnastics
      ExerciseType.dancing => ExerciseTypeDto.dancing,
      ExerciseType.gymnastics => ExerciseTypeDto.gymnastics,

      // Fitness & Conditioning
      ExerciseType.yoga => ExerciseTypeDto.yoga,
      ExerciseType.pilates => ExerciseTypeDto.pilates,
      ExerciseType.highIntensityIntervalTraining =>
        ExerciseTypeDto.highIntensityIntervalTraining,
      ExerciseType.elliptical => ExerciseTypeDto.elliptical,
      ExerciseType.exerciseClass => ExerciseTypeDto.exerciseClass,
      ExerciseType.bootCamp => ExerciseTypeDto.bootCamp,
      ExerciseType.guidedBreathing => ExerciseTypeDto.guidedBreathing,
      ExerciseType.stairClimbing => ExerciseTypeDto.stairClimbing,
      ExerciseType.flexibility => ExerciseTypeDto.flexibility,

      // Golf & Precision Sports
      ExerciseType.golf => ExerciseTypeDto.golf,

      // Outdoor & Adventure
      ExerciseType.paragliding => ExerciseTypeDto.paragliding,
      ExerciseType.climbing => ExerciseTypeDto.climbing,

      // Wheelchair Activities
      ExerciseType.wheelchair => ExerciseTypeDto.wheelchair,

      // iOS-Specific Exercise Types
      ExerciseType.swimming ||
      ExerciseType.waterFitness ||
      ExerciseType.waterSports ||
      ExerciseType.hockey ||
      ExerciseType.kickboxing ||
      ExerciseType.wrestling ||
      ExerciseType.crossTraining ||
      ExerciseType.jumpRope ||
      ExerciseType.wheelchairWalkPace ||
      ExerciseType.wheelchairRunPace ||
      ExerciseType.swimBikeRun ||
      ExerciseType.pickleball ||
      ExerciseType.discSports ||
      ExerciseType.fitnessGaming ||
      ExerciseType.barre ||
      ExerciseType.taiChi ||
      ExerciseType.mixedCardio ||
      ExerciseType.handCycling ||
      ExerciseType.cooldown ||
      ExerciseType.archery ||
      ExerciseType.bowling ||
      ExerciseType.curling ||
      ExerciseType.equestrianSports ||
      ExerciseType.fishing ||
      ExerciseType.hunting ||
      ExerciseType.lacrosse ||
      ExerciseType.mindAndBody ||
      ExerciseType.play ||
      ExerciseType.preparationAndRecovery ||
      ExerciseType.stepTraining ||
      ExerciseType.trackAndField ||
      ExerciseType.transition ||
      ExerciseType.crossCountrySkiing ||
      ExerciseType.downhillSkiing ||
      ExerciseType.snowSports ||
      ExerciseType.cardioDance ||
      ExerciseType.socialDance ||
      ExerciseType.coreTraining ||
      ExerciseType.swimming => throw ArgumentError(
        'Exercise type $this is not supported on Android Health Connect',
      ),

      // Default fallback
      ExerciseType.other => ExerciseTypeDto.other,
    };
  }
}

/// Extension to convert [ExerciseTypeDto] to [ExerciseType].
extension ExerciseTypeFromDto on ExerciseTypeDto {
  /// Converts [ExerciseTypeDto] to [ExerciseType].
  ExerciseType fromDto() {
    return switch (this) {
      // Cardio & Walking/Running
      ExerciseTypeDto.running => ExerciseType.running,
      ExerciseTypeDto.runningTreadmill => ExerciseType.runningTreadmill,
      ExerciseTypeDto.walking => ExerciseType.walking,
      ExerciseTypeDto.cycling => ExerciseType.cycling,
      ExerciseTypeDto.cyclingStationary => ExerciseType.cyclingStationary,
      ExerciseTypeDto.hiking => ExerciseType.hiking,

      // Water Sports
      ExerciseTypeDto.swimmingOpenWater => ExerciseType.swimmingOpenWater,
      ExerciseTypeDto.swimmingPool => ExerciseType.swimmingPool,
      ExerciseTypeDto.surfing => ExerciseType.surfing,
      ExerciseTypeDto.waterPolo => ExerciseType.waterPolo,
      ExerciseTypeDto.rowing => ExerciseType.rowing,
      ExerciseTypeDto.sailing => ExerciseType.sailing,
      ExerciseTypeDto.paddling => ExerciseType.paddling,
      ExerciseTypeDto.diving => ExerciseType.diving,

      // Strength Training
      ExerciseTypeDto.strengthTraining => ExerciseType.strengthTraining,
      ExerciseTypeDto.weightlifting => ExerciseType.weightlifting,
      ExerciseTypeDto.calisthenics => ExerciseType.calisthenics,

      // Team Sports
      ExerciseTypeDto.basketball => ExerciseType.basketball,
      ExerciseTypeDto.soccer => ExerciseType.soccer,
      ExerciseTypeDto.americanFootball => ExerciseType.americanFootball,
      ExerciseTypeDto.frisbeeDisc => ExerciseType.frisbeeDisc,
      ExerciseTypeDto.australianFootball => ExerciseType.australianFootball,
      ExerciseTypeDto.baseball => ExerciseType.baseball,
      ExerciseTypeDto.softball => ExerciseType.softball,
      ExerciseTypeDto.volleyball => ExerciseType.volleyball,
      ExerciseTypeDto.rugby => ExerciseType.rugby,
      ExerciseTypeDto.cricket => ExerciseType.cricket,
      ExerciseTypeDto.handball => ExerciseType.handball,
      ExerciseTypeDto.iceHockey => ExerciseType.iceHockey,
      ExerciseTypeDto.rollerHockey => ExerciseType.rollerHockey,
      ExerciseTypeDto.hockey => ExerciseType.hockey,

      // Racquet Sports
      ExerciseTypeDto.tennis => ExerciseType.tennis,
      ExerciseTypeDto.tableTennis => ExerciseType.tableTennis,
      ExerciseTypeDto.badminton => ExerciseType.badminton,
      ExerciseTypeDto.squash => ExerciseType.squash,
      ExerciseTypeDto.racquetball => ExerciseType.racquetball,

      // Winter Sports
      ExerciseTypeDto.skiing => ExerciseType.skiing,
      ExerciseTypeDto.snowboarding => ExerciseType.snowboarding,
      ExerciseTypeDto.snowshoeing => ExerciseType.snowshoeing,
      ExerciseTypeDto.skating => ExerciseType.skating,

      // Martial Arts & Combat Sports
      ExerciseTypeDto.boxing => ExerciseType.boxing,
      ExerciseTypeDto.kickboxing => ExerciseType.kickboxing,
      ExerciseTypeDto.martialArts => ExerciseType.martialArts,
      ExerciseTypeDto.wrestling => ExerciseType.wrestling,
      ExerciseTypeDto.fencing => ExerciseType.fencing,

      // Dance & Gymnastics
      ExerciseTypeDto.dancing => ExerciseType.dancing,
      ExerciseTypeDto.gymnastics => ExerciseType.gymnastics,

      // Fitness & Conditioning
      ExerciseTypeDto.yoga => ExerciseType.yoga,
      ExerciseTypeDto.pilates => ExerciseType.pilates,
      ExerciseTypeDto.highIntensityIntervalTraining =>
        ExerciseType.highIntensityIntervalTraining,
      ExerciseTypeDto.elliptical => ExerciseType.elliptical,
      ExerciseTypeDto.exerciseClass => ExerciseType.exerciseClass,
      ExerciseTypeDto.bootCamp => ExerciseType.bootCamp,
      ExerciseTypeDto.guidedBreathing => ExerciseType.guidedBreathing,
      ExerciseTypeDto.stairClimbing => ExerciseType.stairClimbing,
      ExerciseTypeDto.flexibility => ExerciseType.flexibility,

      // Golf & Precision Sports
      ExerciseTypeDto.golf => ExerciseType.golf,

      // Outdoor & Adventure
      ExerciseTypeDto.paragliding => ExerciseType.paragliding,
      ExerciseTypeDto.climbing => ExerciseType.climbing,

      // Wheelchair Activities
      ExerciseTypeDto.wheelchair => ExerciseType.wheelchair,

      // Default fallback
      ExerciseTypeDto.other => ExerciseType.other,
    };
  }
}
