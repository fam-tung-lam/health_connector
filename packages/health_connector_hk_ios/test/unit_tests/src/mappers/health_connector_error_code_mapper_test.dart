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
              const codeString = 'UNKNOWN';
              final errorCode = codeString.toErrorCode();

              expect(errorCode, HealthConnectorErrorCode.unknown);
            },
          );

          test(
            'converts HEALTH_PROVIDER_UNAVAILABLE to healthPlatformUnavailable',
            () {
              const codeString = 'HEALTH_PROVIDER_UNAVAILABLE';
              final errorCode = codeString.toErrorCode();

              expect(
                errorCode,
                HealthConnectorErrorCode.healthPlatformUnavailable,
              );
            },
          );

          test(
            'converts NOT_AUTHORIZED to notAuthorized',
            () {
              const codeString = 'NOT_AUTHORIZED';
              final errorCode = codeString.toErrorCode();

              expect(errorCode, HealthConnectorErrorCode.notAuthorized);
            },
          );

          test(
            'converts invalid error code string to unknown',
            () {
              const codeString = 'INVALID_ERROR_CODE';
              final errorCode = codeString.toErrorCode();

              expect(errorCode, HealthConnectorErrorCode.unknown);
            },
          );
        },
      );
    },
  );
}
