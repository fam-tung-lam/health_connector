import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers/permission_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'PermissionMapper',
    () {
      group(
        'PermissionToDto',
        () {
          test(
            'maps HealthDataPermission with read access to '
            'HealthDataPermissionRequestDto',
            () {
              const permission = HealthDataPermission(
                dataType: HealthDataType.steps,
                accessType: HealthDataPermissionAccessType.read,
              );

              final dto = permission.toDto();

              expect(dto, isA<HealthDataPermissionRequestDto>());
              final healthDataDto = dto as HealthDataPermissionRequestDto;
              expect(healthDataDto.healthDataType, HealthDataTypeDto.steps);
              expect(healthDataDto.accessType, PermissionAccessTypeDto.read);
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

              final dto = permission.toDto();

              expect(dto, isA<HealthDataPermissionRequestDto>());
              final healthDataDto = dto as HealthDataPermissionRequestDto;
              expect(healthDataDto.healthDataType, HealthDataTypeDto.weight);
              expect(healthDataDto.accessType, PermissionAccessTypeDto.write);
            },
          );

          test(
            'maps HealthPlatformFeaturePermission to '
            'HealthPlatformFeaturePermissionRequest',
            () {
              const permission = HealthPlatformFeaturePermission(
                HealthPlatformFeature.readHealthDataInBackground,
              );

              final dto = permission.toDto();

              expect(dto, isA<HealthPlatformFeaturePermissionRequest>());
              final featureDto = dto as HealthPlatformFeaturePermissionRequest;
              expect(
                featureDto.feature,
                HealthPlatformFeatureDto.readHealthDataInBackground,
              );
            },
          );
        },
      );
    },
  );
}
