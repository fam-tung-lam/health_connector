import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/operating_system_info_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'OperatingSystemInfoDtoToDomain',
    () {
      test(
        'maps the API level and SDK Extension versions',
        () {
          final dto = OperatingSystemInfoDto(
            apiLevel: 34,
            sdkExtensionVersions: [
              AndroidSDKExtensionVersionDto(
                androidApiLevel: 30,
                extensionVersion: 13,
              ),
              AndroidSDKExtensionVersionDto(
                androidApiLevel: 34,
                extensionVersion: 21,
              ),
            ],
          );

          final result = dto.toDomain();

          expect(result.apiLevel, 34);
          expect(
            result.sdkExtensionVersions,
            const [
              AndroidSDKExtensionVersion(
                androidApiLevel: 30,
                extensionVersion: 13,
              ),
              AndroidSDKExtensionVersion(
                androidApiLevel: 34,
                extensionVersion: 21,
              ),
            ],
          );
        },
      );

      test(
        'maps an empty SDK Extension snapshot',
        () {
          final dto = OperatingSystemInfoDto(
            apiLevel: 29,
            sdkExtensionVersions: [],
          );

          final result = dto.toDomain();

          expect(result.apiLevel, 29);
          expect(result.sdkExtensionVersions, isEmpty);
        },
      );
    },
  );
}
