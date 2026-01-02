import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/health_data_permission_access_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HealthDataPermissionAccessTypeMapper',
    () {
      group(
        'HealthDataPermissionAccessTypeToDto',
        () {
          parameterizedTest(
            'maps HealthDataPermissionAccessType to PermissionAccessTypeDto',
            [
              [
                HealthDataPermissionAccessType.read,
                PermissionAccessTypeDto.read,
              ],
              [
                HealthDataPermissionAccessType.write,
                PermissionAccessTypeDto.write,
              ],
            ],
            (
              HealthDataPermissionAccessType accessType,
              PermissionAccessTypeDto expectedDto,
            ) {
              final dto = accessType.toDto();
              expect(dto, expectedDto);
            },
          );
        },
      );
    },
  );
}
