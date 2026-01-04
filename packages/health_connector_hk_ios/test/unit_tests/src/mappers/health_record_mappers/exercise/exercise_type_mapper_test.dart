import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/exercise/exercise_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ExerciseTypeMapper',
    () {
      group(
        'ExerciseTypeToDto',
        () {
          parameterizedTest(
            'converts Exercise Type to ExerciseTypeDto',
            [
              // Cardio & Walking/Running
              [ExerciseType.running, ExerciseTypeDto.running],
              [ExerciseType.walking, ExerciseTypeDto.walking],
              [ExerciseType.cycling, ExerciseTypeDto.cycling],
              [ExerciseType.hiking, ExerciseTypeDto.hiking],
              // Water Sports
              [ExerciseType.swimming, ExerciseTypeDto.swimming],
              [ExerciseType.surfing, ExerciseTypeDto.surfing],
              [ExerciseType.waterPolo, ExerciseTypeDto.waterPolo],
              [ExerciseType.rowing, ExerciseTypeDto.rowing],
              [ExerciseType.sailing, ExerciseTypeDto.sailing],
              [ExerciseType.paddling, ExerciseTypeDto.paddling],
              [ExerciseType.diving, ExerciseTypeDto.diving],
              // Strength Training
              [ExerciseType.strengthTraining, ExerciseTypeDto.strengthTraining],
              // Team Sports
              [ExerciseType.basketball, ExerciseTypeDto.basketball],
              [ExerciseType.soccer, ExerciseTypeDto.soccer],
              [ExerciseType.americanFootball, ExerciseTypeDto.americanFootball],
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
              [ExerciseType.hockey, ExerciseTypeDto.hockey],
              // Racquet Sports
              [ExerciseType.tennis, ExerciseTypeDto.tennis],
              [ExerciseType.tableTennis, ExerciseTypeDto.tableTennis],
              [ExerciseType.badminton, ExerciseTypeDto.badminton],
              [ExerciseType.squash, ExerciseTypeDto.squash],
              [ExerciseType.racquetball, ExerciseTypeDto.racquetball],
              [ExerciseType.pickleball, ExerciseTypeDto.pickleball],
              // Winter Sports
              [ExerciseType.snowboarding, ExerciseTypeDto.snowboarding],
              [ExerciseType.skating, ExerciseTypeDto.skating],
              [
                ExerciseType.crossCountrySkiing,
                ExerciseTypeDto.crossCountrySkiing,
              ],
              [ExerciseType.downhillSkiing, ExerciseTypeDto.downhillSkiing],
              [ExerciseType.snowSports, ExerciseTypeDto.snowSports],
              // Martial Arts & Combat Sports
              [ExerciseType.boxing, ExerciseTypeDto.boxing],
              [ExerciseType.martialArts, ExerciseTypeDto.martialArts],
              [ExerciseType.wrestling, ExerciseTypeDto.wrestling],
              [ExerciseType.fencing, ExerciseTypeDto.fencing],
              [ExerciseType.taiChi, ExerciseTypeDto.taiChi],
              // Dance & Gymnastics
              [ExerciseType.gymnastics, ExerciseTypeDto.gymnastics],
              [ExerciseType.barre, ExerciseTypeDto.barre],
              [ExerciseType.cardioDance, ExerciseTypeDto.cardioDance],
              [ExerciseType.socialDance, ExerciseTypeDto.socialDance],
              // Fitness & Conditioning
              [ExerciseType.yoga, ExerciseTypeDto.yoga],
              [ExerciseType.pilates, ExerciseTypeDto.pilates],
              [
                ExerciseType.highIntensityIntervalTraining,
                ExerciseTypeDto.highIntensityIntervalTraining,
              ],
              [ExerciseType.crossTraining, ExerciseTypeDto.crossTraining],
              [ExerciseType.jumpRope, ExerciseTypeDto.jumpRope],
              [ExerciseType.elliptical, ExerciseTypeDto.elliptical],
              [ExerciseType.stairClimbing, ExerciseTypeDto.stairClimbing],
              [ExerciseType.stepTraining, ExerciseTypeDto.stepTraining],
              [ExerciseType.fitnessGaming, ExerciseTypeDto.fitnessGaming],
              [ExerciseType.coreTraining, ExerciseTypeDto.coreTraining],
              [ExerciseType.flexibility, ExerciseTypeDto.flexibility],
              [ExerciseType.cooldown, ExerciseTypeDto.cooldown],
              [ExerciseType.mixedCardio, ExerciseTypeDto.mixedCardio],
              [ExerciseType.handCycling, ExerciseTypeDto.handCycling],
              [ExerciseType.mindAndBody, ExerciseTypeDto.mindAndBody],
              [
                ExerciseType.preparationAndRecovery,
                ExerciseTypeDto.preparationAndRecovery,
              ],
              // Golf & Precision Sports
              [ExerciseType.golf, ExerciseTypeDto.golf],
              [ExerciseType.discSports, ExerciseTypeDto.discSports],
              [ExerciseType.archery, ExerciseTypeDto.archery],
              [ExerciseType.bowling, ExerciseTypeDto.bowling],
              [ExerciseType.curling, ExerciseTypeDto.curling],
              [ExerciseType.lacrosse, ExerciseTypeDto.lacrosse],
              [ExerciseType.trackAndField, ExerciseTypeDto.trackAndField],
              // Outdoor & Adventure
              [ExerciseType.climbing, ExerciseTypeDto.climbing],
              [ExerciseType.equestrianSports, ExerciseTypeDto.equestrianSports],
              [ExerciseType.fishing, ExerciseTypeDto.fishing],
              [ExerciseType.hunting, ExerciseTypeDto.hunting],
              [ExerciseType.play, ExerciseTypeDto.play],
              // Wheelchair Activities
              [
                ExerciseType.wheelchairWalkPace,
                ExerciseTypeDto.wheelchairWalkPace,
              ],
              [
                ExerciseType.wheelchairRunPace,
                ExerciseTypeDto.wheelchairRunPace,
              ],
              // Multisport
              [ExerciseType.transition, ExerciseTypeDto.transition],
              [ExerciseType.swimBikeRun, ExerciseTypeDto.swimBikeRun],
              // Other fallback
              [ExerciseType.other, ExerciseTypeDto.other],
            ],
            (ExerciseType domain, ExerciseTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );

          test(
            'throws ArgumentError for Android-only exercise types',
            () {
              expect(
                () => ExerciseType.runningTreadmill.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.cyclingStationary.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.swimmingOpenWater.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.swimmingPool.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.weightlifting.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.calisthenics.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.iceHockey.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.rollerHockey.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.skiing.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.snowshoeing.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.dancing.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.exerciseClass.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.bootCamp.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.guidedBreathing.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.paragliding.toDto(),
                throwsA(isA<ArgumentError>()),
              );
              expect(
                () => ExerciseType.wheelchair.toDto(),
                throwsA(isA<ArgumentError>()),
              );
            },
          );
        },
      );

      group(
        'ExerciseTypeDtoToDomain',
        () {
          parameterizedTest(
            'converts ExerciseTypeDto to ExerciseType',
            [
              // Cardio & Walking/Running
              [ExerciseTypeDto.running, ExerciseType.running],
              [ExerciseTypeDto.walking, ExerciseType.walking],
              [ExerciseTypeDto.cycling, ExerciseType.cycling],
              [ExerciseTypeDto.hiking, ExerciseType.hiking],
              // Water Sports
              [ExerciseTypeDto.swimming, ExerciseType.swimming],
              [ExerciseTypeDto.surfing, ExerciseType.surfing],
              [ExerciseTypeDto.waterPolo, ExerciseType.waterPolo],
              [ExerciseTypeDto.waterFitness, ExerciseType.waterFitness],
              [ExerciseTypeDto.waterSports, ExerciseType.waterSports],
              [ExerciseTypeDto.rowing, ExerciseType.rowing],
              [ExerciseTypeDto.sailing, ExerciseType.sailing],
              [ExerciseTypeDto.paddling, ExerciseType.paddling],
              [ExerciseTypeDto.diving, ExerciseType.diving],
              // Strength Training
              [ExerciseTypeDto.strengthTraining, ExerciseType.strengthTraining],
              // Team Sports
              [ExerciseTypeDto.basketball, ExerciseType.basketball],
              [ExerciseTypeDto.soccer, ExerciseType.soccer],
              [ExerciseTypeDto.americanFootball, ExerciseType.americanFootball],
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
              [ExerciseTypeDto.hockey, ExerciseType.hockey],
              [ExerciseTypeDto.lacrosse, ExerciseType.lacrosse],
              [ExerciseTypeDto.discSports, ExerciseType.discSports],
              // Racquet Sports
              [ExerciseTypeDto.tennis, ExerciseType.tennis],
              [ExerciseTypeDto.tableTennis, ExerciseType.tableTennis],
              [ExerciseTypeDto.badminton, ExerciseType.badminton],
              [ExerciseTypeDto.squash, ExerciseType.squash],
              [ExerciseTypeDto.racquetball, ExerciseType.racquetball],
              [ExerciseTypeDto.pickleball, ExerciseType.pickleball],
              // Winter Sports
              [ExerciseTypeDto.snowboarding, ExerciseType.snowboarding],
              [ExerciseTypeDto.skating, ExerciseType.skating],
              [
                ExerciseTypeDto.crossCountrySkiing,
                ExerciseType.crossCountrySkiing,
              ],
              [ExerciseTypeDto.curling, ExerciseType.curling],
              [ExerciseTypeDto.downhillSkiing, ExerciseType.downhillSkiing],
              [ExerciseTypeDto.snowSports, ExerciseType.snowSports],
              // Martial Arts & Combat Sports
              [ExerciseTypeDto.boxing, ExerciseType.boxing],
              [ExerciseTypeDto.kickboxing, ExerciseType.kickboxing],
              [ExerciseTypeDto.martialArts, ExerciseType.martialArts],
              [ExerciseTypeDto.wrestling, ExerciseType.wrestling],
              [ExerciseTypeDto.fencing, ExerciseType.fencing],
              [ExerciseTypeDto.taiChi, ExerciseType.taiChi],
              // Dance & Gymnastics
              [ExerciseTypeDto.gymnastics, ExerciseType.gymnastics],
              [ExerciseTypeDto.barre, ExerciseType.barre],
              [ExerciseTypeDto.cardioDance, ExerciseType.cardioDance],
              [ExerciseTypeDto.socialDance, ExerciseType.socialDance],
              // Fitness & Conditioning
              [ExerciseTypeDto.yoga, ExerciseType.yoga],
              [ExerciseTypeDto.pilates, ExerciseType.pilates],
              [
                ExerciseTypeDto.highIntensityIntervalTraining,
                ExerciseType.highIntensityIntervalTraining,
              ],
              [ExerciseTypeDto.elliptical, ExerciseType.elliptical],
              [ExerciseTypeDto.stairClimbing, ExerciseType.stairClimbing],
              [ExerciseTypeDto.crossTraining, ExerciseType.crossTraining],
              [ExerciseTypeDto.jumpRope, ExerciseType.jumpRope],
              [ExerciseTypeDto.stepTraining, ExerciseType.stepTraining],
              [ExerciseTypeDto.fitnessGaming, ExerciseType.fitnessGaming],
              [ExerciseTypeDto.coreTraining, ExerciseType.coreTraining],
              [ExerciseTypeDto.flexibility, ExerciseType.flexibility],
              [ExerciseTypeDto.cooldown, ExerciseType.cooldown],
              [ExerciseTypeDto.mixedCardio, ExerciseType.mixedCardio],
              [ExerciseTypeDto.handCycling, ExerciseType.handCycling],
              [ExerciseTypeDto.trackAndField, ExerciseType.trackAndField],
              [ExerciseTypeDto.mindAndBody, ExerciseType.mindAndBody],
              [
                ExerciseTypeDto.preparationAndRecovery,
                ExerciseType.preparationAndRecovery,
              ],
              // Golf & Precision Sports
              [ExerciseTypeDto.golf, ExerciseType.golf],
              [ExerciseTypeDto.archery, ExerciseType.archery],
              [ExerciseTypeDto.bowling, ExerciseType.bowling],
              // Outdoor & Adventure
              [ExerciseTypeDto.climbing, ExerciseType.climbing],
              [ExerciseTypeDto.equestrianSports, ExerciseType.equestrianSports],
              [ExerciseTypeDto.fishing, ExerciseType.fishing],
              [ExerciseTypeDto.hunting, ExerciseType.hunting],
              [ExerciseTypeDto.play, ExerciseType.play],
              // Wheelchair Activities
              [
                ExerciseTypeDto.wheelchairWalkPace,
                ExerciseType.wheelchairWalkPace,
              ],
              [
                ExerciseTypeDto.wheelchairRunPace,
                ExerciseType.wheelchairRunPace,
              ],
              // Multisport
              [ExerciseTypeDto.transition, ExerciseType.transition],
              [ExerciseTypeDto.swimBikeRun, ExerciseType.swimBikeRun],
              // Other fallback
              [ExerciseTypeDto.other, ExerciseType.other],
            ],
            (ExerciseTypeDto dto, ExerciseType domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
