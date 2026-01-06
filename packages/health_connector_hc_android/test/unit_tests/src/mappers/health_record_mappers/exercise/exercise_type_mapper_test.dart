import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise/exercise_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'ExerciseTypeMapper',
    () {
      group(
        'ExerciseTypeToDto',
        () {
          parameterizedTest(
            'converts ExerciseType to ExerciseTypeDto',
            [
              // Cardio & Walking/Running
              [ExerciseType.running, ExerciseTypeDto.running],
              [
                ExerciseType.runningTreadmill,
                ExerciseTypeDto.runningTreadmill,
              ],
              [ExerciseType.walking, ExerciseTypeDto.walking],
              [ExerciseType.cycling, ExerciseTypeDto.cycling],
              [
                ExerciseType.cyclingStationary,
                ExerciseTypeDto.cyclingStationary,
              ],
              [ExerciseType.hiking, ExerciseTypeDto.hiking],
              // Water Sports
              [
                ExerciseType.swimmingOpenWater,
                ExerciseTypeDto.swimmingOpenWater,
              ],
              [ExerciseType.swimmingPool, ExerciseTypeDto.swimmingPool],
              [ExerciseType.surfing, ExerciseTypeDto.surfing],
              [ExerciseType.waterPolo, ExerciseTypeDto.waterPolo],
              [ExerciseType.rowing, ExerciseTypeDto.rowing],
              [ExerciseType.sailing, ExerciseTypeDto.sailing],
              [ExerciseType.paddling, ExerciseTypeDto.paddling],
              [ExerciseType.diving, ExerciseTypeDto.diving],
              // Strength Training
              [
                ExerciseType.strengthTraining,
                ExerciseTypeDto.strengthTraining,
              ],
              [ExerciseType.weightlifting, ExerciseTypeDto.weightlifting],
              [ExerciseType.calisthenics, ExerciseTypeDto.calisthenics],
              // Team Sports
              [ExerciseType.basketball, ExerciseTypeDto.basketball],
              [ExerciseType.soccer, ExerciseTypeDto.soccer],
              [
                ExerciseType.americanFootball,
                ExerciseTypeDto.americanFootball,
              ],
              [ExerciseType.frisbeeDisc, ExerciseTypeDto.frisbeeDisc],
              [
                ExerciseType.australianFootball,
                ExerciseTypeDto.australianFootball,
              ],
              [ExerciseType.baseball, ExerciseTypeDto.baseball],
              [ExerciseType.softball, ExerciseTypeDto.softball],
              [ExerciseType.volleyball, ExerciseTypeDto.volleyball],
              [ExerciseType.rugby, ExerciseTypeDto.rugby],
              [ExerciseType.cricket, ExerciseTypeDto.cricket],
              [ExerciseType.handball, ExerciseTypeDto.handball],
              [ExerciseType.iceHockey, ExerciseTypeDto.iceHockey],
              [ExerciseType.rollerHockey, ExerciseTypeDto.rollerHockey],
              // Racquet Sports
              [ExerciseType.tennis, ExerciseTypeDto.tennis],
              [ExerciseType.tableTennis, ExerciseTypeDto.tableTennis],
              [ExerciseType.badminton, ExerciseTypeDto.badminton],
              [ExerciseType.squash, ExerciseTypeDto.squash],
              [ExerciseType.racquetball, ExerciseTypeDto.racquetball],
              // Winter Sports
              [ExerciseType.skiing, ExerciseTypeDto.skiing],
              [ExerciseType.snowboarding, ExerciseTypeDto.snowboarding],
              [ExerciseType.snowshoeing, ExerciseTypeDto.snowshoeing],
              [ExerciseType.skating, ExerciseTypeDto.skating],
              // Martial Arts & Combat Sports
              [ExerciseType.boxing, ExerciseTypeDto.boxing],
              [ExerciseType.martialArts, ExerciseTypeDto.martialArts],
              [ExerciseType.fencing, ExerciseTypeDto.fencing],
              // Dance & Gymnastics
              [ExerciseType.dancing, ExerciseTypeDto.dancing],
              [ExerciseType.gymnastics, ExerciseTypeDto.gymnastics],
              // Fitness & Conditioning
              [ExerciseType.yoga, ExerciseTypeDto.yoga],
              [ExerciseType.pilates, ExerciseTypeDto.pilates],
              [
                ExerciseType.highIntensityIntervalTraining,
                ExerciseTypeDto.highIntensityIntervalTraining,
              ],
              [ExerciseType.elliptical, ExerciseTypeDto.elliptical],
              [ExerciseType.exerciseClass, ExerciseTypeDto.exerciseClass],
              [ExerciseType.bootCamp, ExerciseTypeDto.bootCamp],
              [ExerciseType.guidedBreathing, ExerciseTypeDto.guidedBreathing],
              [ExerciseType.stairClimbing, ExerciseTypeDto.stairClimbing],
              [ExerciseType.flexibility, ExerciseTypeDto.flexibility],
              // Golf & Precision Sports
              [ExerciseType.golf, ExerciseTypeDto.golf],
              // Outdoor & Adventure
              [ExerciseType.paragliding, ExerciseTypeDto.paragliding],
              [ExerciseType.climbing, ExerciseTypeDto.climbing],
              // Wheelchair Activities
              [ExerciseType.wheelchair, ExerciseTypeDto.wheelchair],
              // Default fallback
              [ExerciseType.other, ExerciseTypeDto.other],
            ],
            (ExerciseType domain, ExerciseTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );

          test(
            'throws ArgumentError for iOS-only exercise types',
            () {
              expect(
                () => ExerciseType.swimming.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.waterFitness.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.crossTraining.toDto(),
                throwsA(isA<ArgumentError>()),
              );
            },
          );
        },
      );

      group(
        'ExerciseTypeFromDto',
        () {
          parameterizedTest(
            'converts ExerciseTypeDto to ExerciseType',
            [
              // Cardio & Walking/Running
              [ExerciseTypeDto.running, ExerciseType.running],
              [
                ExerciseTypeDto.runningTreadmill,
                ExerciseType.runningTreadmill,
              ],
              [ExerciseTypeDto.walking, ExerciseType.walking],
              [ExerciseTypeDto.cycling, ExerciseType.cycling],
              [
                ExerciseTypeDto.cyclingStationary,
                ExerciseType.cyclingStationary,
              ],
              [ExerciseTypeDto.hiking, ExerciseType.hiking],
              // Water Sports
              [
                ExerciseTypeDto.swimmingOpenWater,
                ExerciseType.swimmingOpenWater,
              ],
              [ExerciseTypeDto.swimmingPool, ExerciseType.swimmingPool],
              [ExerciseTypeDto.surfing, ExerciseType.surfing],
              [ExerciseTypeDto.waterPolo, ExerciseType.waterPolo],
              [ExerciseTypeDto.rowing, ExerciseType.rowing],
              [ExerciseTypeDto.sailing, ExerciseType.sailing],
              [ExerciseTypeDto.paddling, ExerciseType.paddling],
              [ExerciseTypeDto.diving, ExerciseType.diving],
              // Strength Training
              [
                ExerciseTypeDto.strengthTraining,
                ExerciseType.strengthTraining,
              ],
              [ExerciseTypeDto.weightlifting, ExerciseType.weightlifting],
              [ExerciseTypeDto.calisthenics, ExerciseType.calisthenics],
              // Team Sports
              [ExerciseTypeDto.basketball, ExerciseType.basketball],
              [ExerciseTypeDto.soccer, ExerciseType.soccer],
              [
                ExerciseTypeDto.americanFootball,
                ExerciseType.americanFootball,
              ],
              [ExerciseTypeDto.frisbeeDisc, ExerciseType.frisbeeDisc],
              [
                ExerciseTypeDto.australianFootball,
                ExerciseType.australianFootball,
              ],
              [ExerciseTypeDto.baseball, ExerciseType.baseball],
              [ExerciseTypeDto.softball, ExerciseType.softball],
              [ExerciseTypeDto.volleyball, ExerciseType.volleyball],
              [ExerciseTypeDto.rugby, ExerciseType.rugby],
              [ExerciseTypeDto.cricket, ExerciseType.cricket],
              [ExerciseTypeDto.handball, ExerciseType.handball],
              [ExerciseTypeDto.iceHockey, ExerciseType.iceHockey],
              [ExerciseTypeDto.rollerHockey, ExerciseType.rollerHockey],
              [ExerciseTypeDto.hockey, ExerciseType.hockey],
              // Racquet Sports
              [ExerciseTypeDto.tennis, ExerciseType.tennis],
              [ExerciseTypeDto.tableTennis, ExerciseType.tableTennis],
              [ExerciseTypeDto.badminton, ExerciseType.badminton],
              [ExerciseTypeDto.squash, ExerciseType.squash],
              [ExerciseTypeDto.racquetball, ExerciseType.racquetball],
              // Winter Sports
              [ExerciseTypeDto.skiing, ExerciseType.skiing],
              [ExerciseTypeDto.snowboarding, ExerciseType.snowboarding],
              [ExerciseTypeDto.snowshoeing, ExerciseType.snowshoeing],
              [ExerciseTypeDto.skating, ExerciseType.skating],
              // Martial Arts & Combat Sports
              [ExerciseTypeDto.boxing, ExerciseType.boxing],
              [ExerciseTypeDto.kickboxing, ExerciseType.kickboxing],
              [ExerciseTypeDto.martialArts, ExerciseType.martialArts],
              [ExerciseTypeDto.wrestling, ExerciseType.wrestling],
              [ExerciseTypeDto.fencing, ExerciseType.fencing],
              // Dance & Gymnastics
              [ExerciseTypeDto.dancing, ExerciseType.dancing],
              [ExerciseTypeDto.gymnastics, ExerciseType.gymnastics],
              // Fitness & Conditioning
              [ExerciseTypeDto.yoga, ExerciseType.yoga],
              [ExerciseTypeDto.pilates, ExerciseType.pilates],
              [
                ExerciseTypeDto.highIntensityIntervalTraining,
                ExerciseType.highIntensityIntervalTraining,
              ],
              [ExerciseTypeDto.elliptical, ExerciseType.elliptical],
              [ExerciseTypeDto.exerciseClass, ExerciseType.exerciseClass],
              [ExerciseTypeDto.bootCamp, ExerciseType.bootCamp],
              [
                ExerciseTypeDto.guidedBreathing,
                ExerciseType.guidedBreathing,
              ],
              [ExerciseTypeDto.stairClimbing, ExerciseType.stairClimbing],
              [ExerciseTypeDto.flexibility, ExerciseType.flexibility],
              // Golf & Precision Sports
              [ExerciseTypeDto.golf, ExerciseType.golf],
              // Outdoor & Adventure
              [ExerciseTypeDto.paragliding, ExerciseType.paragliding],
              [ExerciseTypeDto.climbing, ExerciseType.climbing],
              // Wheelchair Activities
              [ExerciseTypeDto.wheelchair, ExerciseType.wheelchair],
              // Default fallback
              [ExerciseTypeDto.other, ExerciseType.other],
            ],
            (ExerciseTypeDto dto, ExerciseType domain) {
              expect(dto.fromDto(), domain);
            },
          );
        },
      );
    },
  );
}
