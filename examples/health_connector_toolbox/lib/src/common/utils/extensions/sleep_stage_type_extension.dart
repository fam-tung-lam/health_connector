import 'package:health_connector/health_connector_internal.dart'
    show SleepStage;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension providing display names for [SleepStage] enum values.
extension SleepStageTypeDisplayName on SleepStage {
  /// Returns the localized display name for this sleep stage type.
  String get displayName {
    return switch (this) {
      SleepStage.unknown => AppTexts.unknown,
      SleepStage.awake => AppTexts.sleepStageAwake,
      SleepStage.sleeping => AppTexts.sleepStageSleeping,
      SleepStage.outOfBed => AppTexts.sleepStageOutOfBed,
      SleepStage.light => AppTexts.sleepStageLight,
      SleepStage.deep => AppTexts.sleepStageDeep,
      SleepStage.rem => AppTexts.sleepStageRem,
      SleepStage.inBed => AppTexts.sleepStageInBed,
    };
  }
}
