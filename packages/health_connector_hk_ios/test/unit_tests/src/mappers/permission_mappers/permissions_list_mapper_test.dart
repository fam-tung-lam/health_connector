import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/permissions_list_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

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

              expect(dto.healthDataPermissions, hasLength(1));
              expect(
                dto.healthDataPermissions[0].healthDataType,
                HealthDataTypeDto.steps,
              );
              expect(
                dto.healthDataPermissions[0].accessType,
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

              expect(dto.healthDataPermissions, hasLength(2));
              expect(
                dto.healthDataPermissions[0].healthDataType,
                HealthDataTypeDto.steps,
              );
              expect(
                dto.healthDataPermissions[1].healthDataType,
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

              // Nutrition should expand to 30 nutrient types
              expect(
                dto.healthDataPermissions,
                hasLength(HealthDataType.nutrientTypes.length),
              );
              expect(
                dto.healthDataPermissions
                    .where(
                      (p) =>
                          p.accessType == PermissionAccessTypeDto.read &&
                          p.healthDataType == HealthDataTypeDto.energyNutrient,
                    )
                    .length,
                1,
              );
              expect(
                dto.healthDataPermissions
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
                dto.healthDataPermissions,
                hasLength(HealthDataType.nutrientTypes.length + 1),
              );
            },
          );
        },
      );
    },
  );
}
