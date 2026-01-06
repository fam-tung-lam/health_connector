import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/health_data_permission_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group(
    'HealthDataPermissionMapper',
    () {
      group(
        'HealthDataPermissionToDto',
        () {
          test(
            'maps HealthDataPermission with read access to '
            'HealthDataPermissionDto',
            () {
              const permission = HealthDataPermission(
                dataType: HealthDataType.steps,
                accessType: HealthDataPermissionAccessType.read,
              );

              final dto = permission.toDto();

              expect(dto.healthDataType, HealthDataTypeDto.steps);
              expect(dto.accessType, PermissionAccessTypeDto.read);
            },
          );

          test(
            'maps HealthDataPermission with write access to '
            'HealthDataPermissionDto',
            () {
              const permission = HealthDataPermission(
                dataType: HealthDataType.weight,
                accessType: HealthDataPermissionAccessType.write,
              );

              final dto = permission.toDto();

              expect(dto.healthDataType, HealthDataTypeDto.weight);
              expect(dto.accessType, PermissionAccessTypeDto.write);
            },
          );
        },
      );
    },
  );
}
