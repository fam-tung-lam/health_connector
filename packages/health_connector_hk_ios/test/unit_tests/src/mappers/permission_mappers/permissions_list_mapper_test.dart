import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/permissions_list_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group(
    'PermissionsListMapper',
    () {
      group(
        'PermissionsListToDto',
        () {
          test(
            'maps single HealthDataPermission to PermissionsRequestDto',
            () {
              const permissions = [
                HealthDataPermission(
                  dataType: HealthDataType.steps,
                  accessType: HealthDataPermissionAccessType.read,
                ),
              ];

              final dto = permissions.toDto();

              expect(dto.permissionRequests, hasLength(1));
              final request =
                  dto.permissionRequests[0] as HealthDataPermissionRequestDto;
              expect(
                request.healthDataType,
                HealthDataTypeDto.steps,
              );
              expect(
                request.accessType,
                PermissionAccessTypeDto.read,
              );
            },
          );

          test(
            'maps multiple HealthDataPermissions to PermissionsRequestDto',
            () {
              const permissions = [
                HealthDataPermission(
                  dataType: HealthDataType.steps,
                  accessType: HealthDataPermissionAccessType.read,
                ),
                HealthDataPermission(
                  dataType: HealthDataType.weight,
                  accessType: HealthDataPermissionAccessType.write,
                ),
              ];

              final dto = permissions.toDto();

              expect(dto.permissionRequests, hasLength(2));
              final request0 =
                  dto.permissionRequests[0] as HealthDataPermissionRequestDto;
              final request1 =
                  dto.permissionRequests[1] as HealthDataPermissionRequestDto;
              expect(
                request0.healthDataType,
                HealthDataTypeDto.steps,
              );
              expect(
                request1.healthDataType,
                HealthDataTypeDto.weight,
              );
            },
          );

          test(
            'expands nutrition permission to all nutrient types',
            () {
              const permissions = [
                HealthDataPermission(
                  dataType: HealthDataType.nutrition,
                  accessType: HealthDataPermissionAccessType.read,
                ),
              ];

              final dto = permissions.toDto();
              final healthDataRequests = dto.permissionRequests
                  .whereType<HealthDataPermissionRequestDto>();

              // Nutrition should expand to 30 nutrient types
              expect(
                healthDataRequests,
                hasLength(HealthDataType.nutrientTypes.length),
              );
              expect(
                healthDataRequests
                    .where(
                      (p) =>
                          p.accessType == PermissionAccessTypeDto.read &&
                          p.healthDataType ==
                              HealthDataTypeDto.dietaryEnergyConsumed,
                    )
                    .length,
                1,
              );
              expect(
                healthDataRequests
                    .where(
                      (p) =>
                          p.accessType == PermissionAccessTypeDto.read &&
                          p.healthDataType == HealthDataTypeDto.protein,
                    )
                    .length,
                1,
              );
            },
          );

          test(
            'combines regular and nutrition permissions',
            () {
              const permissions = [
                HealthDataPermission(
                  dataType: HealthDataType.steps,
                  accessType: HealthDataPermissionAccessType.read,
                ),
                HealthDataPermission(
                  dataType: HealthDataType.nutrition,
                  accessType: HealthDataPermissionAccessType.write,
                ),
              ];

              final dto = permissions.toDto();

              expect(
                dto.permissionRequests,
                hasLength(HealthDataType.nutrientTypes.length + 1),
              );
            },
          );
        },
      );
    },
  );
}
