import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  test('all Health Connect requirement presets are static constants', () {
    const requirements = [
      HealthConnectRequirement.none,
      HealthConnectRequirement.android14OrLaterWithSDKExtension13,
      HealthConnectRequirement.android14OrLaterWithSDKExtension15,
      HealthConnectRequirement.android14OrLaterWithSDKExtension16,
      HealthConnectRequirement.android14OrLaterWithSDKExtension19,
      HealthConnectRequirement.android14OrLaterWithSDKExtension21,
    ];

    expect(
      requirements
          .skip(1)
          .map(
            (requirement) =>
                requirement.minSDKExtensionVersion?.extensionVersion,
          ),
      [13, 15, 16, 19, 21],
    );
    expect(
      requirements
          .skip(1)
          .every(
            (requirement) => requirement.minApiLevel == 34,
          ),
      isTrue,
    );
    expect(
      requirements.every(
        (requirement) =>
            requirement.healthPlatform == HealthPlatform.healthConnect,
      ),
      isTrue,
    );
  });

  test('none presets add no version requirements', () {
    expect(HealthConnectRequirement.none.minApiLevel, isNull);
    expect(HealthConnectRequirement.none.minSDKExtensionVersion, isNull);
    expect(AppleHealthRequirement.none.minIOSVersion, isNull);
  });

  test('all platform requirements use canonical unversioned constants', () {
    expect(
      HealthPlatformRequirement.allPlatforms,
      equals([
        AppleHealthRequirement.none,
        HealthConnectRequirement.none,
      ]),
    );
  });

  test('requirement lists project their supported health platforms', () {
    expect(
      HealthPlatformRequirement.allPlatforms.supportedHealthPlatforms,
      [HealthPlatform.appleHealth, HealthPlatform.healthConnect],
    );
    expect(
      const [
        AppleHealthRequirement.ios18OrLater,
      ].supportedHealthPlatforms,
      [HealthPlatform.appleHealth],
    );
  });
}
