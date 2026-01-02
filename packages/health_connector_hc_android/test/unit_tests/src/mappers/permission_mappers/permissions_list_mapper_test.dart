import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers/permissions_list_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

void main() {
  group(
    'PermissionsListMapper',
    () {
      group(
        'PermissionsListToDto',
        () {
          test(
            'converts empty list to PermissionRequestsDto',
            () {
              const permissions = <Permission>[];

              final dto = permissions.toDto();

              expect(dto.permissionRequests, isEmpty);
            },
          );

          test(
            'converts single permission to PermissionRequestsDto',
            () {
              const permissions = [
                HealthDataPermission(
                  dataType: HealthDataType.steps,
                  accessType: HealthDataPermissionAccessType.read,
                ),
              ];

              final dto = permissions.toDto();

              expect(dto.permissionRequests, hasLength(1));
              expect(
                dto.permissionRequests[0],
                isA<HealthDataPermissionRequestDto>(),
              );
            },
          );

          test(
            'converts multiple mixed permissions to PermissionRequestsDto',
            () {
              final permissions = [
                const HealthDataPermission(
                  dataType: HealthDataType.steps,
                  accessType: HealthDataPermissionAccessType.read,
                ),
                const HealthDataPermission(
                  dataType: HealthDataType.weight,
                  accessType: HealthDataPermissionAccessType.write,
                ),
                HealthPlatformFeaturePermission(
                  HealthPlatformFeature.readHealthDataInBackground,
                ),
              ];

              final dto = permissions.toDto();

              expect(dto.permissionRequests, hasLength(3));
              expect(
                dto.permissionRequests[0],
                isA<HealthDataPermissionRequestDto>(),
              );
              expect(
                dto.permissionRequests[1],
                isA<HealthDataPermissionRequestDto>(),
              );
              expect(
                dto.permissionRequests[2],
                isA<HealthPlatformFeaturePermissionRequest>(),
              );

              final healthData0 =
                  dto.permissionRequests[0] as HealthDataPermissionRequestDto;
              expect(healthData0.healthDataType, HealthDataTypeDto.steps);
              expect(healthData0.accessType, PermissionAccessTypeDto.read);

              final healthData1 =
                  dto.permissionRequests[1] as HealthDataPermissionRequestDto;
              expect(healthData1.healthDataType, HealthDataTypeDto.weight);
              expect(healthData1.accessType, PermissionAccessTypeDto.write);

              final feature =
                  dto.permissionRequests[2]
                      as HealthPlatformFeaturePermissionRequest;
              expect(
                feature.feature,
                HealthPlatformFeatureDto.readHealthDataInBackground,
              );
            },
          );
        },
      );
    },
  );
}
