import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  final events = <ExerciseSessionEvent>[
    ExerciseSessionStateTransitionEvent(
      time: DateTime.utc(2026),
      type: ExerciseSessionStateTransitionType.pause,
    ),
    ExerciseSessionMarkerEvent(time: DateTime.utc(2026)),
    ExerciseSessionLapEvent(
      startTime: DateTime.utc(2026),
      endTime: DateTime.utc(2026, 1, 1, 0, 1),
    ),
    ExerciseSessionSegmentEvent(
      startTime: DateTime.utc(2026),
      endTime: DateTime.utc(2026, 1, 1, 0, 1),
      segmentType: ExerciseSegmentType.unknown,
    ),
  ];

  group('deprecated platform projections', () {
    test('every data type projects its requirements to the same platforms', () {
      for (final dataType in HealthDataType.values) {
        final expected =
            dataType.healthPlatformRequirements.supportedHealthPlatforms;

        expect(
          // ignore: deprecated_member_use_from_same_package
          dataType.supportedHealthPlatforms,
          expected,
          reason: dataType.toString(),
        );
      }
    });

    test('every feature projects its requirements to the same platforms', () {
      for (final feature in HealthPlatformFeature.values) {
        final expected =
            feature.healthPlatformRequirements.supportedHealthPlatforms;

        expect(
          // ignore: deprecated_member_use_from_same_package
          feature.supportedHealthPlatforms,
          expected,
          reason: feature.toString(),
        );
      }
    });

    test('every event projects its requirements to the same platforms', () {
      for (final event in events) {
        final expected =
            event.healthPlatformRequirements.supportedHealthPlatforms;

        expect(
          // ignore: deprecated_member_use_from_same_package
          event.supportedHealthPlatforms,
          expected,
          reason: event.runtimeType.toString(),
        );
      }
    });

    test('every exercise type retains its previous platform check', () {
      for (final exerciseType in ExerciseType.values) {
        for (final platform in HealthPlatform.values) {
          final expected = exerciseType.healthPlatformRequirements.any(
            (requirement) => requirement.healthPlatform == platform,
          );

          expect(
            // ignore: deprecated_member_use_from_same_package
            exerciseType.isSupportedOnPlatform(platform),
            expected,
            reason: '$exerciseType on $platform',
          );
        }
      }
    });

    test('record and permission getters delegate to their data type', () {
      final record = StepsRecord(
        startTime: DateTime.utc(2026),
        endTime: DateTime.utc(2026, 1, 1, 0, 1),
        count: const Number(1),
        metadata: Metadata.manualEntry(),
      );
      const permission = HealthDataPermission(
        dataType: HealthDataType.steps,
        accessType: HealthDataPermissionAccessType.read,
      );
      final expected = HealthDataType
          .steps
          .healthPlatformRequirements
          .supportedHealthPlatforms;

      // ignore: deprecated_member_use_from_same_package
      expect(record.supportedHealthPlatforms, expected);
      // ignore: deprecated_member_use_from_same_package
      expect(permission.supportedHealthPlatforms, expected);
    });
  });

  test('segment extended fields use SDK Extension 21', () {
    expect(
      ExerciseSessionSegmentEvent.extendedFieldsRequirements,
      [HealthConnectRequirement.sdkExtension21],
    );
  });

  test('version-gated data types expose their iOS floors', () {
    const expectedIOS16 = <HealthDataType>[
      HealthDataType.sleepingWristTemperature,
      HealthDataType.runningGroundContactTime,
      HealthDataType.atrialFibrillationBurden,
      HealthDataType.runningStrideLength,
      HealthDataType.runningPower,
      HealthDataType.heartRateRecoveryOneMinute,
      HealthDataType.irregularMenstrualCycleEvent,
      HealthDataType.prolongedMenstrualPeriodEvent,
      HealthDataType.persistentIntermenstrualBleedingEvent,
      HealthDataType.infrequentMenstrualCycleEvent,
      HealthDataType.walkingSpeed,
      HealthDataType.runningSpeed,
      HealthDataType.stairAscentSpeed,
      HealthDataType.stairDescentSpeed,
    ];
    const expectedIOS17 = <HealthDataType>[
      HealthDataType.cyclingPower,
      HealthDataType.cyclingPedalingCadence,
    ];
    const expectedIOS18 = <HealthDataType>[
      HealthDataType.rowingDistance,
      HealthDataType.crossCountrySkiingDistance,
      HealthDataType.skatingSportsDistance,
      HealthDataType.paddleSportsDistance,
    ];

    for (final dataType in expectedIOS16) {
      expect(
        dataType.healthPlatformRequirements,
        [AppleHealthRequirement.ios16],
        reason: dataType.toString(),
      );
    }
    for (final dataType in expectedIOS17) {
      expect(
        dataType.healthPlatformRequirements,
        [AppleHealthRequirement.ios17],
        reason: dataType.toString(),
      );
    }
    for (final dataType in expectedIOS18) {
      expect(
        dataType.healthPlatformRequirements,
        [AppleHealthRequirement.ios18],
        reason: dataType.toString(),
      );
    }
  });
}
