import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise/exercise_segment_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group('ExerciseSegmentTypeMapper', () {
    parameterizedTest(
      'converts ExerciseSegmentType to/from DTO',
      [
        [ExerciseSegmentType.unknown, ExerciseSegmentTypeDto.unknown],
        [ExerciseSegmentType.armCurl, ExerciseSegmentTypeDto.armCurl],
        [
          ExerciseSegmentType.backExtension,
          ExerciseSegmentTypeDto.backExtension,
        ],
        [ExerciseSegmentType.ballSlam, ExerciseSegmentTypeDto.ballSlam],
        [
          ExerciseSegmentType.barbellShoulderPress,
          ExerciseSegmentTypeDto.barbellShoulderPress,
        ],
        [ExerciseSegmentType.benchPress, ExerciseSegmentTypeDto.benchPress],
        [ExerciseSegmentType.benchSitUp, ExerciseSegmentTypeDto.benchSitUp],
        [ExerciseSegmentType.biking, ExerciseSegmentTypeDto.biking],
        [
          ExerciseSegmentType.bikingStationary,
          ExerciseSegmentTypeDto.bikingStationary,
        ],
        [ExerciseSegmentType.burpee, ExerciseSegmentTypeDto.burpee],
        [ExerciseSegmentType.crunch, ExerciseSegmentTypeDto.crunch],
        [ExerciseSegmentType.deadlift, ExerciseSegmentTypeDto.deadlift],
        [
          ExerciseSegmentType.doubleArmTricepsExtension,
          ExerciseSegmentTypeDto.doubleArmTricepsExtension,
        ],
        [
          ExerciseSegmentType.dumbbellCurlLeftArm,
          ExerciseSegmentTypeDto.dumbbellCurlLeftArm,
        ],
        [
          ExerciseSegmentType.dumbbellCurlRightArm,
          ExerciseSegmentTypeDto.dumbbellCurlRightArm,
        ],
        [
          ExerciseSegmentType.dumbbellFrontRaise,
          ExerciseSegmentTypeDto.dumbbellFrontRaise,
        ],
        [
          ExerciseSegmentType.dumbbellLateralRaise,
          ExerciseSegmentTypeDto.dumbbellLateralRaise,
        ],
        [ExerciseSegmentType.dumbbellRow, ExerciseSegmentTypeDto.dumbbellRow],
        [
          ExerciseSegmentType.dumbbellTricepsExtensionLeftArm,
          ExerciseSegmentTypeDto.dumbbellTricepsExtensionLeftArm,
        ],
        [
          ExerciseSegmentType.dumbbellTricepsExtensionRightArm,
          ExerciseSegmentTypeDto.dumbbellTricepsExtensionRightArm,
        ],
        [
          ExerciseSegmentType.dumbbellTricepsExtensionTwoArm,
          ExerciseSegmentTypeDto.dumbbellTricepsExtensionTwoArm,
        ],
        [ExerciseSegmentType.elliptical, ExerciseSegmentTypeDto.elliptical],
        [ExerciseSegmentType.forwardTwist, ExerciseSegmentTypeDto.forwardTwist],
        [ExerciseSegmentType.frontRaise, ExerciseSegmentTypeDto.frontRaise],
        [
          ExerciseSegmentType.highIntensityIntervalTraining,
          ExerciseSegmentTypeDto.highIntensityIntervalTraining,
        ],
        [ExerciseSegmentType.hipThrust, ExerciseSegmentTypeDto.hipThrust],
        [ExerciseSegmentType.hulaHoop, ExerciseSegmentTypeDto.hulaHoop],
        [ExerciseSegmentType.jumpingJack, ExerciseSegmentTypeDto.jumpingJack],
        [ExerciseSegmentType.jumpRope, ExerciseSegmentTypeDto.jumpRope],
        [
          ExerciseSegmentType.kettlebellSwing,
          ExerciseSegmentTypeDto.kettlebellSwing,
        ],
        [ExerciseSegmentType.lateralRaise, ExerciseSegmentTypeDto.lateralRaise],
        [ExerciseSegmentType.latPullDown, ExerciseSegmentTypeDto.latPullDown],
        [ExerciseSegmentType.legCurl, ExerciseSegmentTypeDto.legCurl],
        [ExerciseSegmentType.legExtension, ExerciseSegmentTypeDto.legExtension],
        [ExerciseSegmentType.legPress, ExerciseSegmentTypeDto.legPress],
        [ExerciseSegmentType.legRaise, ExerciseSegmentTypeDto.legRaise],
        [ExerciseSegmentType.lunge, ExerciseSegmentTypeDto.lunge],
        [
          ExerciseSegmentType.mountainClimber,
          ExerciseSegmentTypeDto.mountainClimber,
        ],
        [ExerciseSegmentType.otherWorkout, ExerciseSegmentTypeDto.otherWorkout],
        [ExerciseSegmentType.pause, ExerciseSegmentTypeDto.pause],
        [ExerciseSegmentType.pilates, ExerciseSegmentTypeDto.pilates],
        [ExerciseSegmentType.plank, ExerciseSegmentTypeDto.plank],
        [ExerciseSegmentType.pullUp, ExerciseSegmentTypeDto.pullUp],
        [ExerciseSegmentType.punch, ExerciseSegmentTypeDto.punch],
        [ExerciseSegmentType.rest, ExerciseSegmentTypeDto.rest],
        [
          ExerciseSegmentType.rowingMachine,
          ExerciseSegmentTypeDto.rowingMachine,
        ],
        [ExerciseSegmentType.running, ExerciseSegmentTypeDto.running],
        [
          ExerciseSegmentType.runningTreadmill,
          ExerciseSegmentTypeDto.runningTreadmill,
        ],
        [
          ExerciseSegmentType.shoulderPress,
          ExerciseSegmentTypeDto.shoulderPress,
        ],
        [
          ExerciseSegmentType.singleArmTricepsExtension,
          ExerciseSegmentTypeDto.singleArmTricepsExtension,
        ],
        [ExerciseSegmentType.sitUp, ExerciseSegmentTypeDto.sitUp],
        [ExerciseSegmentType.squat, ExerciseSegmentTypeDto.squat],
        [
          ExerciseSegmentType.stairClimbing,
          ExerciseSegmentTypeDto.stairClimbing,
        ],
        [
          ExerciseSegmentType.stairClimbingMachine,
          ExerciseSegmentTypeDto.stairClimbingMachine,
        ],
        [ExerciseSegmentType.stretching, ExerciseSegmentTypeDto.stretching],
        [
          ExerciseSegmentType.swimmingBackstroke,
          ExerciseSegmentTypeDto.swimmingBackstroke,
        ],
        [
          ExerciseSegmentType.swimmingBreaststroke,
          ExerciseSegmentTypeDto.swimmingBreaststroke,
        ],
        [
          ExerciseSegmentType.swimmingButterfly,
          ExerciseSegmentTypeDto.swimmingButterfly,
        ],
        [
          ExerciseSegmentType.swimmingFreestyle,
          ExerciseSegmentTypeDto.swimmingFreestyle,
        ],
        [
          ExerciseSegmentType.swimmingMixed,
          ExerciseSegmentTypeDto.swimmingMixed,
        ],
        [
          ExerciseSegmentType.swimmingOpenWater,
          ExerciseSegmentTypeDto.swimmingOpenWater,
        ],
        [
          ExerciseSegmentType.swimmingOther,
          ExerciseSegmentTypeDto.swimmingOther,
        ],
        [ExerciseSegmentType.swimmingPool, ExerciseSegmentTypeDto.swimmingPool],
        [ExerciseSegmentType.upperTwist, ExerciseSegmentTypeDto.upperTwist],
        [ExerciseSegmentType.walking, ExerciseSegmentTypeDto.walking],
        [
          ExerciseSegmentType.weightlifting,
          ExerciseSegmentTypeDto.weightlifting,
        ],
        [ExerciseSegmentType.wheelchair, ExerciseSegmentTypeDto.wheelchair],
        [ExerciseSegmentType.yoga, ExerciseSegmentTypeDto.yoga],
      ],
      (ExerciseSegmentType domain, ExerciseSegmentTypeDto dto) {
        expect(domain.toDto(), dto);
        expect(dto.toDomain(), domain);
      },
    );
  });
}
