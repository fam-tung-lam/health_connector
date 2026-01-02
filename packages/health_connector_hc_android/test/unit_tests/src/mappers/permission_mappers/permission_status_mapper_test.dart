import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers/permission_status_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

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
            (PermissionStatusDto dto, PermissionStatus domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
