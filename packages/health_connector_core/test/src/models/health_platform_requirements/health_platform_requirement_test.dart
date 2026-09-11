import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  test('all Health Connect requirement presets are static constants', () {
    const requirements = [
      HealthConnectRequirement.allVersions,
      HealthConnectRequirement.sdkExtension13,
      HealthConnectRequirement.sdkExtension15,
      HealthConnectRequirement.sdkExtension16,
      HealthConnectRequirement.sdkExtension19,
      HealthConnectRequirement.sdkExtension21,
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
      requirements.every(
        (requirement) =>
            requirement.healthPlatform == HealthPlatform.healthConnect,
      ),
      isTrue,
    );
  });

  test('all platform requirements use canonical unversioned constants', () {
    expect(
      HealthPlatformRequirement.allPlatforms,
      equals([
        AppleHealthRequirement.allVersions,
        HealthConnectRequirement.allVersions,
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
        AppleHealthRequirement.ios18,
      ].supportedHealthPlatforms,
      [HealthPlatform.appleHealth],
    );
  });
}
