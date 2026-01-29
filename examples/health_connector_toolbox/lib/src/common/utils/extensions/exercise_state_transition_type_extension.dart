import 'package:health_connector/health_connector_internal.dart'
    show ExerciseSessionStateTransitionType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension providing display names for
/// [ExerciseSessionStateTransitionType] enum values.
extension ExerciseSessionStateTransitionTypeDisplayName
    on ExerciseSessionStateTransitionType {
  /// Returns the display name for this exercise state transition type.
  String get displayName {
    return switch (this) {
      ExerciseSessionStateTransitionType.pause => AppTexts.transitionPause,
      ExerciseSessionStateTransitionType.resume => AppTexts.transitionResume,
      ExerciseSessionStateTransitionType.motionPaused =>
        AppTexts.transitionMotionPaused,
      ExerciseSessionStateTransitionType.motionResumed =>
        AppTexts.transitionMotionResumed,
      ExerciseSessionStateTransitionType.pauseOrResumeRequest =>
        AppTexts.transitionPauseOrResumeRequest,
    };
  }
}
