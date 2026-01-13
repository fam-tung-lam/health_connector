import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_connector_error_code_mapper.dart';

void main() {
  group(
    'HealthConnectorErrorCodeMappers',
    () {
      group(
        'StringToErrorCode',
        () {
          test(
            'converts valid error code string to HealthConnectorErrorCode',
            () {
              const codeString = 'UNKNOWN_ERROR';
              final errorCode = codeString.toErrorCode();

              expect(errorCode, HealthConnectorErrorCode.unknownError);
            },
          );

          test(
            'converts HEALTH_SERVICE_UNAVAILABLE to healthPlatformUnavailable',
            () {
              const codeString = 'HEALTH_SERVICE_UNAVAILABLE';
              final errorCode = codeString.toErrorCode();

              expect(
                errorCode,
                HealthConnectorErrorCode.healthServiceUnavailable,
              );
            },
          );

          test(
            'converts PERMISSION_NOT_GRANTED to notAuthorized',
            () {
              const codeString = 'PERMISSION_NOT_GRANTED';
              final errorCode = codeString.toErrorCode();

              expect(
                errorCode,
                HealthConnectorErrorCode.permissionNotGranted,
              );
            },
          );

          test(
            'converts invalid error code string to unknown',
            () {
              const codeString = 'INVALID_ERROR_CODE';
              final errorCode = codeString.toErrorCode();

              expect(errorCode, HealthConnectorErrorCode.unknownError);
            },
          );
        },
      );
    },
  );
}
