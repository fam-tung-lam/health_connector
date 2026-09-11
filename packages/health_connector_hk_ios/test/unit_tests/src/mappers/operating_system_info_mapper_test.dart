import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/operating_system_info_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group(
    'OperatingSystemInfoDtoToDomain',
    () {
      test(
        'maps the iOS version',
        () {
          final dto = OperatingSystemInfoDto(
            majorVersion: 18,
            minorVersion: 2,
            patchVersion: 1,
          );

          final result = dto.toDomain();

          expect(result.version, const IOSVersion(18, 2, 1));
        },
      );
    },
  );
}
