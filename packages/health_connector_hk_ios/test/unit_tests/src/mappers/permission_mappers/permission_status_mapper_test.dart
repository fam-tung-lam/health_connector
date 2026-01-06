import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/permission_status_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'PermissionStatusMapper',
    () {
      group(
        'PermissionStatusDtoToDomain',
        () {
          parameterizedTest(
            'maps PermissionStatusDto to PermissionStatus',
            [
              [PermissionStatusDto.granted, PermissionStatus.granted],
              [PermissionStatusDto.denied, PermissionStatus.denied],
              [PermissionStatusDto.unknown, PermissionStatus.unknown],
            ],
            (PermissionStatusDto dto, PermissionStatus expectedStatus) {
              final status = dto.toDomain();
              expect(status, expectedStatus);
            },
          );
        },
      );
    },
  );
}
