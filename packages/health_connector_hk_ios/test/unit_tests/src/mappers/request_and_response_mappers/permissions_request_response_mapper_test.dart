import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/permissions_request_response_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

void main() {
  group(
    'PermissionsRequestResponseMapper',
    () {
      group(
        'PermissionsRequestResponseDtoToDomain',
        () {
          test(
            'maps PermissionsRequestResponseDto to list of '
            'PermissionRequestResult',
            () {
              // Given
              final dto = PermissionsRequestResponseDto(
                healthDataPermissionResults: [
                  HealthDataPermissionRequestResultDto(
                    permission: HealthDataPermissionDto(
                      healthDataType: HealthDataTypeDto.steps,
                      accessType: PermissionAccessTypeDto.read,
                    ),
                    status: PermissionStatusDto.granted,
                  ),
                  HealthDataPermissionRequestResultDto(
                    permission: HealthDataPermissionDto(
                      healthDataType: HealthDataTypeDto.weight,
                      accessType: PermissionAccessTypeDto.write,
                    ),
                    status: PermissionStatusDto.denied,
                  ),
                ],
              );

              // When
              final results = dto.toDomain();

              // Then
              expect(results, hasLength(2));

              final permission0 = results[0].permission as HealthDataPermission;
              final permission1 = results[1].permission as HealthDataPermission;

              expect(permission0.dataType, HealthDataType.steps);
              expect(
                permission0.accessType,
                HealthDataPermissionAccessType.read,
              );
              expect(results[0].status, PermissionStatus.granted);

              expect(permission1.dataType, HealthDataType.weight);
              expect(
                permission1.accessType,
                HealthDataPermissionAccessType.write,
              );
              expect(results[1].status, PermissionStatus.denied);
            },
          );

          test(
            'maps permission with read access type',
            () {
              // Given
              final dto = PermissionsRequestResponseDto(
                healthDataPermissionResults: [
                  HealthDataPermissionRequestResultDto(
                    permission: HealthDataPermissionDto(
                      healthDataType:
                          HealthDataTypeDto.heartRateVariabilitySDNN,
                      accessType: PermissionAccessTypeDto.read,
                    ),
                    status: PermissionStatusDto.granted,
                  ),
                ],
              );

              // When
              final results = dto.toDomain();

              // Then
              final permission = results[0].permission as HealthDataPermission;
              expect(
                permission.accessType,
                HealthDataPermissionAccessType.read,
              );
            },
          );

          test(
            'maps permission with write access type',
            () {
              // Given
              final dto = PermissionsRequestResponseDto(
                healthDataPermissionResults: [
                  HealthDataPermissionRequestResultDto(
                    permission: HealthDataPermissionDto(
                      healthDataType: HealthDataTypeDto.height,
                      accessType: PermissionAccessTypeDto.write,
                    ),
                    status: PermissionStatusDto.granted,
                  ),
                ],
              );

              // When
              final results = dto.toDomain();

              // Then
              final permission = results[0].permission as HealthDataPermission;
              expect(
                permission.accessType,
                HealthDataPermissionAccessType.write,
              );
            },
          );

          test(
            'maps empty permission results list',
            () {
              // Given
              final dto = PermissionsRequestResponseDto(
                healthDataPermissionResults: [],
              );

              // When
              final results = dto.toDomain();

              // Then
              expect(results, isEmpty);
            },
          );
        },
      );
    },
  );
}
