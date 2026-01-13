import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/exception_mappers/health_connector_error_code_mapper.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'HealthConnectorErrorCodeMapper',
    () {
      group(
        'StringToErrorCode',
        () {
          parameterizedTest(
            'maps valid error code string to HealthConnectorErrorCode',
            [
              [
                'HEALTH_PROVIDER_NOT_INSTALLED_OR_UPDATE_REQUIRED',
                HealthConnectorErrorCode
                    .healthServiceNotInstalledOrUpdateRequired,
              ],
              [
                'HEALTH_SERVICE_UNAVAILABLE',
                HealthConnectorErrorCode.healthServiceUnavailable,
              ],
              [
                'UNSUPPORTED_OPERATION',
                HealthConnectorErrorCode.unsupportedOperation,
              ],
              [
                'PERMISSION_NOT_DECLARED',
                HealthConnectorErrorCode.permissionNotDeclared,
              ],
              [
                'INVALID_ARGUMENT',
                HealthConnectorErrorCode.invalidArgument,
              ],
              [
                'PERMISSION_NOT_GRANTED',
                HealthConnectorErrorCode.permissionNotGranted,
              ],
              [
                'REMOTE_ERROR',
                HealthConnectorErrorCode.remoteError,
              ],
              [
                'UNKNOWN_ERROR',
                HealthConnectorErrorCode.unknownError,
              ],
            ],
            (String code, HealthConnectorErrorCode errorCode) {
              expect(code.toErrorCode(), errorCode);
            },
          );

          test(
            'maps unknown error code string to '
            'HealthConnectorErrorCode.unknownError',
            () {
              expect(
                'SOME_UNKNOWN_ERROR_CODE'.toErrorCode(),
                HealthConnectorErrorCode.unknownError,
              );
            },
          );

          test(
            'maps invalid error code string to '
            'HealthConnectorErrorCode.unknown',
            () {
              expect(
                'NOT_A_VALID_CODE'.toErrorCode(),
                HealthConnectorErrorCode.unknownError,
              );
            },
          );

          test(
            'maps empty string to HealthConnectorErrorCode.unknown',
            () {
              expect(
                ''.toErrorCode(),
                HealthConnectorErrorCode.unknownError,
              );
            },
          );
        },
      );
    },
  );
}
