import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/permission_request_result_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'PermissionRequestResultMapper',
    () {
      group(
        'PermissionRequestResultDtoToDomain',
        () {
          test(
            'maps HealthDataPermissionRequestResultDto to '
            'PermissionRequestResult',
            () {
              final dto = [
                HealthDataPermissionRequestResultDto(
                  permission: HealthDataPermissionRequestDto(
                    healthDataType: HealthDataTypeDto.steps,
                    accessType: PermissionAccessTypeDto.read,
                  ),
                  status: PermissionStatusDto.granted,
                ),
                HealthDataPermissionRequestResultDto(
                  permission: HealthDataPermissionRequestDto(
                    healthDataType: HealthDataTypeDto.weight,
                    accessType: PermissionAccessTypeDto.write,
                  ),
                  status: PermissionStatusDto.denied,
                ),
              ];

              final results = dto.toDomain();

              expect(results, hasLength(2));

              expect(
                results[0].permission,
                isA<HealthDataPermission>(),
              );
              final permission0 = results[0].permission as HealthDataPermission;
              expect(permission0.dataType, HealthDataType.steps);
              expect(
                permission0.accessType,
                HealthDataPermissionAccessType.read,
              );
              expect(results[0].status, PermissionStatus.granted);

              expect(
                results[1].permission,
                isA<HealthDataPermission>(),
              );
              final permission1 = results[1].permission as HealthDataPermission;
              expect(permission1.dataType, HealthDataType.weight);
              expect(
                permission1.accessType,
                HealthDataPermissionAccessType.write,
              );
              expect(results[1].status, PermissionStatus.denied);
            },
          );

          test(
            'maps HealthPlatformFeaturePermissionRequestResultDto to '
            'PermissionRequestResult',
            () {
              final dto = [
                HealthPlatformFeaturePermissionRequestResultDto(
                  feature: HealthPlatformFeatureDto.readHealthDataInBackground,
                  status: PermissionStatusDto.granted,
                ),
              ];

              final results = dto.toDomain();

              expect(results, hasLength(1));
              expect(
                results[0].permission,
                isA<HealthPlatformFeaturePermission>(),
              );
              final permission =
                  results[0].permission as HealthPlatformFeaturePermission;
              expect(
                permission.feature,
                HealthPlatformFeature.readHealthDataInBackground,
              );
              expect(results[0].status, PermissionStatus.granted);
            },
          );

          test(
            'maps mixed permission result DTOs to '
            'PermissionRequestResult',
            () {
              final dto = [
                HealthDataPermissionRequestResultDto(
                  permission: HealthDataPermissionRequestDto(
                    healthDataType: HealthDataTypeDto.steps,
                    accessType: PermissionAccessTypeDto.read,
                  ),
                  status: PermissionStatusDto.granted,
                ),
                HealthPlatformFeaturePermissionRequestResultDto(
                  feature: HealthPlatformFeatureDto.readHealthDataInBackground,
                  status: PermissionStatusDto.denied,
                ),
              ];

              final results = dto.toDomain();

              expect(results, hasLength(2));
              expect(
                results[0].permission,
                isA<HealthDataPermission>(),
              );
              expect(
                results[1].permission,
                isA<HealthPlatformFeaturePermission>(),
              );
            },
          );
        },
      );
    },
  );
}
