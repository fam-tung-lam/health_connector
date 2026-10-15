import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/permission_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'PermissionMapper',
    () {
      group('PermissionToDto - UserCharacteristicPermission', () {
        parameterizedTest(
          'maps read-only characteristic permissions to native requests',
          [
            [
              UserCharacteristicType.birthDate,
              UserCharacteristicTypeDto.birthDate,
            ],
            [
              UserCharacteristicType.biologicalSex,
              UserCharacteristicTypeDto.biologicalSex,
            ],
          ],
          (
            UserCharacteristicType<Object> type,
            UserCharacteristicTypeDto expected,
          ) {
            // Given a read-only characteristic permission.
            final permission = type.readPermission;
            // When converting the permission for native authorization.
            final dto =
                permission.toDto() as UserCharacteristicPermissionRequestDto;
            // Then its characteristic identifier is preserved.
            expect(dto.characteristicType, expected);
          },
        );
      });

      group(
        'PermissionToDto - HealthDataPermission',
        () {
          test(
            'maps HealthDataPermission with read access to '
            'HealthDataPermissionRequestDto',
            () {
              const permission = HealthDataPermission(
                dataType: HealthDataType.steps,
                accessType: HealthDataPermissionAccessType.read,
              );

              final dto = permission.toDto() as HealthDataPermissionRequestDto;

              expect(dto.healthDataType, HealthDataTypeDto.steps);
              expect(dto.accessType, PermissionAccessTypeDto.read);
            },
          );

          test(
            'maps HealthDataPermission with write access to '
            'HealthDataPermissionRequestDto',
            () {
              const permission = HealthDataPermission(
                dataType: HealthDataType.weight,
                accessType: HealthDataPermissionAccessType.write,
              );

              final dto = permission.toDto() as HealthDataPermissionRequestDto;

              expect(dto.healthDataType, HealthDataTypeDto.weight);
              expect(dto.accessType, PermissionAccessTypeDto.write);
            },
          );
        },
      );

      group(
        'PermissionToDto - ExerciseRoutePermission',
        () {
          test(
            'maps ExerciseRoutePermission.read to '
            'ExerciseRoutePermissionRequestDto with read access',
            () {
              const permission = ExerciseRoutePermission.read;

              final dto =
                  permission.toDto() as ExerciseRoutePermissionRequestDto;

              expect(dto.accessType, PermissionAccessTypeDto.read);
            },
          );

          test(
            'maps ExerciseRoutePermission.write to '
            'ExerciseRoutePermissionRequestDto with write access',
            () {
              const permission = ExerciseRoutePermission.write;

              final dto =
                  permission.toDto() as ExerciseRoutePermissionRequestDto;

              expect(dto.accessType, PermissionAccessTypeDto.write);
            },
          );
        },
      );

      group(
        'PermissionToDto - HealthPlatformFeaturePermission',
        () {
          test(
            'throws InvalidArgumentException for '
            'HealthPlatformFeaturePermission',
            () {
              const permission = HealthPlatformFeaturePermission(
                HealthPlatformFeature.readHealthDataInBackground,
              );

              expect(
                () => permission.toDto(),
                throwsA(isA<InvalidArgumentException>()),
              );
            },
          );
        },
      );
    },
  );
}
