import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/exception_mappers/health_connector_error_code_mapper.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

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
                    .healthPlatformNotInstalledOrUpdateRequired,
              ],
              [
                'HEALTH_PROVIDER_UNAVAILABLE',
                HealthConnectorErrorCode.healthPlatformUnavailable,
              ],
              [
                'UNSUPPORTED_OPERATION',
                HealthConnectorErrorCode.unsupportedOperation,
              ],
              [
                'INVALID_CONFIGURATION',
                HealthConnectorErrorCode.invalidConfiguration,
              ],
              [
                'INVALID_ARGUMENT',
                HealthConnectorErrorCode.invalidArgument,
              ],
              [
                'NOT_AUTHORIZED',
                HealthConnectorErrorCode.notAuthorized,
              ],
              [
                'REMOTE_ERROR',
                HealthConnectorErrorCode.remoteError,
              ],
              [
                'UNKNOWN',
                HealthConnectorErrorCode.unknown,
              ],
            ],
            (String code, HealthConnectorErrorCode errorCode) {
              expect(code.toErrorCode(), errorCode);
            },
          );

          test(
            'maps unknown error code string to '
            'HealthConnectorErrorCode.unknown',
            () {
              expect(
                'SOME_UNKNOWN_ERROR_CODE'.toErrorCode(),
                HealthConnectorErrorCode.unknown,
              );
            },
          );

          test(
            'maps invalid error code string to '
            'HealthConnectorErrorCode.unknown',
            () {
              expect(
                'NOT_A_VALID_CODE'.toErrorCode(),
                HealthConnectorErrorCode.unknown,
              );
            },
          );

          test(
            'maps empty string to HealthConnectorErrorCode.unknown',
            () {
              expect(
                ''.toErrorCode(),
                HealthConnectorErrorCode.unknown,
              );
            },
          );
        },
      );
    },
  );
}
