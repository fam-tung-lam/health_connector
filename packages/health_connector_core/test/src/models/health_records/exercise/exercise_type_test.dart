import 'package:health_connector_core/health_connector_core.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

const _universalSegments = [
  ExerciseSegmentType.otherWorkout,
  ExerciseSegmentType.pause,
  ExerciseSegmentType.rest,
  ExerciseSegmentType.stretching,
  ExerciseSegmentType.unknown,
];

void main() {
  group('ExerciseType', () {
    group('platform support', () {
      parameterizedTest(
        'getExerciseTypesForPlatform returns only valid exercise types',
        [
          [HealthPlatform.appleHealth],
          [HealthPlatform.healthConnect],
        ],
        (HealthPlatform platform) {
          final types = ExerciseType.other.getExerciseTypesForPlatform(
            platform,
          );
          for (final type in types) {
            expect(ExerciseType.values.contains(type), isTrue);
          }
          expect(
            types.length,
            equals(types.toSet().length),
            reason: 'Platform list should have no duplicates',
          );
        },
      );

      parameterizedTest(
        'each ExerciseType is in at most one platform-only list',
        ExerciseType.values.map((e) => [e]).toList(),
        (ExerciseType type) {
          final appleOnly = ExerciseType.other.getExerciseTypesForPlatform(
            HealthPlatform.appleHealth,
          );
          final androidOnly = ExerciseType.other.getExerciseTypesForPlatform(
            HealthPlatform.healthConnect,
          );
          expect(
            appleOnly.contains(type) && androidOnly.contains(type),
            isFalse,
            reason: 'Type $type must not be in both platform-only lists',
          );
        },
      );

      test('platform-only lists are disjoint', () {
        final appleOnly = ExerciseType.other.getExerciseTypesForPlatform(
          HealthPlatform.appleHealth,
        );
        final androidOnly = ExerciseType.other.getExerciseTypesForPlatform(
          HealthPlatform.healthConnect,
        );
        final intersection = appleOnly.toSet().intersection(
          androidOnly.toSet(),
        );
        expect(intersection, isEmpty);
      });

      test('every ExerciseType is in at most one platform-only list', () {
        final appleOnly = ExerciseType.other.getExerciseTypesForPlatform(
          HealthPlatform.appleHealth,
        );
        final androidOnly = ExerciseType.other.getExerciseTypesForPlatform(
          HealthPlatform.healthConnect,
        );
        for (final type in ExerciseType.values) {
          final inApple = appleOnly.contains(type);
          final inAndroid = androidOnly.contains(type);
          expect(
            inApple && inAndroid,
            isFalse,
            reason: 'Type $type must not be in both lists',
          );
        }
      });
    });

    group('segment-type compatibility', () {
      parameterizedTest(
        'supportedSegmentTypes is non-empty for every ExerciseType',
        ExerciseType.values.map((e) => [e]).toList(),
        (ExerciseType type) {
          expect(type.supportedSegmentTypes.isNotEmpty, isTrue);
        },
      );

      parameterizedTest(
        'universal session type returns all segment types',
        [
          [ExerciseType.bootCamp],
          [ExerciseType.highIntensityIntervalTraining],
          [ExerciseType.other],
        ],
        (ExerciseType type) {
          expect(
            type.supportedSegmentTypes.length,
            equals(ExerciseSegmentType.values.length),
          );
        },
      );

      parameterizedTest(
        'supportedSegmentTypes contains universal segments for '
        'every ExerciseType',
        ExerciseType.values.map((e) => [e]).toList(),
        (ExerciseType type) {
          final supported = type.supportedSegmentTypes;
          for (final seg in _universalSegments) {
            expect(
              supported.contains(seg),
              isTrue,
              reason: 'Type $type should contain universal segment $seg',
            );
          }
        },
      );

      // Session types with known mapping (matches _sessionToSegments)
      const sessionToExpectedSegments = [
        [
          ExerciseType.cycling,
          [ExerciseSegmentType.biking],
        ],
        [
          ExerciseType.cyclingStationary,
          [ExerciseSegmentType.bikingStationary],
        ],
        [
          ExerciseType.calisthenics,
          [
            ExerciseSegmentType.armCurl,
            ExerciseSegmentType.squat,
            ExerciseSegmentType.benchPress,
          ],
        ],
        [
          ExerciseType.elliptical,
          [ExerciseSegmentType.elliptical],
        ],
        [
          ExerciseType.exerciseClass,
          [
            ExerciseSegmentType.yoga,
            ExerciseSegmentType.bikingStationary,
            ExerciseSegmentType.pilates,
            ExerciseSegmentType.highIntensityIntervalTraining,
          ],
        ],
        [
          ExerciseType.gymnastics,
          [
            ExerciseSegmentType.plank,
            ExerciseSegmentType.pullUp,
          ],
        ],
        [
          ExerciseType.hiking,
          [
            ExerciseSegmentType.walking,
            ExerciseSegmentType.wheelchair,
          ],
        ],
        [
          ExerciseType.pilates,
          [ExerciseSegmentType.pilates],
        ],
        [
          ExerciseType.running,
          [
            ExerciseSegmentType.running,
            ExerciseSegmentType.walking,
          ],
        ],
        [
          ExerciseType.runningTreadmill,
          [ExerciseSegmentType.runningTreadmill],
        ],
        [
          ExerciseType.strengthTraining,
          [
            ExerciseSegmentType.deadlift,
            ExerciseSegmentType.lunge,
          ],
        ],
        [
          ExerciseType.stairClimbing,
          [ExerciseSegmentType.stairClimbing],
        ],
        [
          ExerciseType.swimmingOpenWater,
          [
            ExerciseSegmentType.swimmingOpenWater,
            ExerciseSegmentType.swimmingFreestyle,
            ExerciseSegmentType.swimmingBackstroke,
          ],
        ],
        [
          ExerciseType.swimmingPool,
          [
            ExerciseSegmentType.swimmingPool,
            ExerciseSegmentType.swimmingFreestyle,
            ExerciseSegmentType.swimmingButterfly,
          ],
        ],
        [
          ExerciseType.walking,
          [ExerciseSegmentType.walking],
        ],
        [
          ExerciseType.wheelchair,
          [ExerciseSegmentType.wheelchair],
        ],
        [
          ExerciseType.weightlifting,
          [
            ExerciseSegmentType.weightlifting,
            ExerciseSegmentType.benchPress,
          ],
        ],
        [
          ExerciseType.yoga,
          [ExerciseSegmentType.yoga],
        ],
      ];

      parameterizedTest(
        'session type includes expected segments from mapping',
        sessionToExpectedSegments,
        (ExerciseType type, List<ExerciseSegmentType> expectedSegments) {
          final supported = type.supportedSegmentTypes;
          for (final seg in expectedSegments) {
            expect(
              supported.contains(seg),
              isTrue,
              reason: 'Type $type should contain segment $seg',
            );
          }
        },
      );
    });
  });
}
