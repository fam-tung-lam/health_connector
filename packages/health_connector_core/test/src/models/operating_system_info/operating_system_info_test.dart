import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group('AndroidSDKExtensionVersion', () {
    test('accepts the same track at or above the required version', () {
      const requirement = AndroidSDKExtensionVersion(
        androidApiLevel: 34,
        extensionVersion: 21,
      );

      expect(
        requirement.isSatisfiedBy(
          const AndroidSDKExtensionVersion(
            androidApiLevel: 34,
            extensionVersion: 22,
          ),
        ),
        isTrue,
      );
      expect(
        requirement.isSatisfiedBy(
          const AndroidSDKExtensionVersion(
            androidApiLevel: 35,
            extensionVersion: 22,
          ),
        ),
        isFalse,
      );
    });

    test('equal values have equal hash codes', () {
      const first = AndroidSDKExtensionVersion(
        androidApiLevel: 34,
        extensionVersion: 21,
      );
      const second = AndroidSDKExtensionVersion(
        androidApiLevel: 34,
        extensionVersion: 21,
      );

      expect(first, second);
      expect(first.hashCode, second.hashCode);
    });
  });

  group('AndroidOperatingSystemInfo', () {
    test(
      'returns a present extension version and zero for an absent track',
      () {
        const info = AndroidOperatingSystemInfo(
          apiLevel: 35,
          sdkExtensionVersions: [
            AndroidSDKExtensionVersion(
              androidApiLevel: 34,
              extensionVersion: 21,
            ),
          ],
        );

        expect(info.extensionVersionOf(34), 21);
        expect(info.extensionVersionOf(35), 0);
      },
    );
  });

  group('IOSVersion', () {
    test('compares major, minor, and patch components in order', () {
      expect(const IOSVersion(18), greaterThan(const IOSVersion(17, 9, 9)));
      expect(const IOSVersion(18, 2), greaterThan(const IOSVersion(18, 1, 9)));
      expect(
        const IOSVersion(18, 2, 1),
        greaterThan(const IOSVersion(18, 2)),
      );
    });

    test('formats all semantic version components', () {
      expect(const IOSVersion(18, 2, 1).toString(), '18.2.1');
    });
  });
}
