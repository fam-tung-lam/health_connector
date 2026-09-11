import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  const androidInfo = AndroidOperatingSystemInfo(
    apiLevel: 34,
    sdkExtensionVersions: [
      AndroidSDKExtensionVersion(
        androidApiLevel: 34,
        extensionVersion: 20,
      ),
    ],
  );
  const iosInfo = IOSOperatingSystemInfo(version: IOSVersion(17, 4));

  group('resolveHealthPlatformSupportStatus', () {
    test(
      'returns healthPlatform when the current platform has no requirement',
      () {
        const requirements = [
          AppleHealthRequirement.allVersions,
        ];

        final status = resolveHealthPlatformSupportStatus(
          requirements: requirements,
          healthPlatform: HealthPlatform.healthConnect,
          operatingSystemInfo: androidInfo,
        );

        expect(
          status,
          isA<HealthPlatformNotSupported>().having(
            (value) => value.reason,
            'reason',
            HealthPlatformNotSupportedReason.healthPlatform,
          ),
        );
      },
    );

    test(
      'returns operatingSystemVersion when the Android API level is too low',
      () {
        const requirement = HealthConnectRequirement(minApiLevel: 35);
        const requirements = [requirement];

        final status = resolveHealthPlatformSupportStatus(
          requirements: requirements,
          healthPlatform: HealthPlatform.healthConnect,
          operatingSystemInfo: androidInfo,
        );

        expect(
          status,
          isA<HealthPlatformNotSupported>()
              .having(
                (value) => value.reason,
                'reason',
                HealthPlatformNotSupportedReason.operatingSystemVersion,
              )
              .having((value) => value.requirement, 'requirement', requirement),
        );
      },
    );

    test('returns sdkExtensionVersion when the extension is too old', () {
      const requirements = [
        HealthConnectRequirement.sdkExtension21,
      ];

      final status = resolveHealthPlatformSupportStatus(
        requirements: requirements,
        healthPlatform: HealthPlatform.healthConnect,
        operatingSystemInfo: androidInfo,
      );

      expect(
        status,
        isA<HealthPlatformNotSupported>()
            .having(
              (value) => value.reason,
              'reason',
              HealthPlatformNotSupportedReason.sdkExtensionVersion,
            )
            .having(
              (value) => value.message,
              'message',
              contains('Extension 20'),
            ),
      );
    });

    test('returns operatingSystemVersion when the iOS version is too old', () {
      const requirements = [AppleHealthRequirement.ios18];

      final status = resolveHealthPlatformSupportStatus(
        requirements: requirements,
        healthPlatform: HealthPlatform.appleHealth,
        operatingSystemInfo: iosInfo,
      );

      expect(
        status,
        isA<HealthPlatformNotSupported>().having(
          (value) => value.reason,
          'reason',
          HealthPlatformNotSupportedReason.operatingSystemVersion,
        ),
      );
    });

    test('returns supported when every requirement is satisfied', () {
      const requirements = [AppleHealthRequirement.ios17];

      final status = resolveHealthPlatformSupportStatus(
        requirements: requirements,
        healthPlatform: HealthPlatform.appleHealth,
        operatingSystemInfo: iosInfo,
      );

      expect(status, isA<HealthPlatformSupported>());
      expect(status.isSupported, isTrue);
    });
  });
}
