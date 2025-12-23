import 'package:health_connector/health_connector.dart' show SleepStageType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension providing display names for [SleepStageType] enum values.
extension SleepStageTypeDisplayName on SleepStageType {
  /// Returns the localized display name for this sleep stage type.
  String get displayName {
    return switch (this) {
      SleepStageType.unknown => AppTexts.unknown,
      SleepStageType.awake => AppTexts.sleepStageAwake,
      SleepStageType.sleeping => AppTexts.sleepStageSleeping,
      SleepStageType.outOfBed => AppTexts.sleepStageOutOfBed,
      SleepStageType.light => AppTexts.sleepStageLight,
      SleepStageType.deep => AppTexts.sleepStageDeep,
      SleepStageType.rem => AppTexts.sleepStageRem,
      SleepStageType.inBed => AppTexts.sleepStageInBed,
    };
  }
}
