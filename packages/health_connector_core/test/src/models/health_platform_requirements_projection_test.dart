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
        final expected = dataType.healthPlatformRequirements
            .map((requirement) => requirement.healthPlatform)
            .toList(growable: false);

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
        final expected = feature.healthPlatformRequirements
            .map((requirement) => requirement.healthPlatform)
            .toList(growable: false);

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
        final expected = event.healthPlatformRequirements
            .map((requirement) => requirement.healthPlatform)
            .toList(growable: false);

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
      final expected = HealthDataType.steps.healthPlatformRequirements
          .map((requirement) => requirement.healthPlatform)
          .toList(growable: false);

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
}
