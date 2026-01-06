import 'package:flutter/services.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/exception_mappers/health_connector_exception_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HealthConnectorExceptionMapper',
    () {
      group(
        'HealthConnectorExceptionDtoToDomain',
        () {
          parameterizedTest(
            'converts DTO to correct exception type for each error code',
            [
              [
                HealthConnectorErrorCodeDto.healthPlatformUnavailable,
                HealthPlatformUnavailableException,
              ],
              [
                HealthConnectorErrorCodeDto.unsupportedOperation,
                UnsupportedOperationException,
              ],
              [
                HealthConnectorErrorCodeDto.invalidConfiguration,
                InvalidConfigurationException,
              ],
              [
                HealthConnectorErrorCodeDto.invalidArgument,
                InvalidArgumentException,
              ],
              [
                HealthConnectorErrorCodeDto.notAuthorized,
                NotAuthorizedException,
              ],
              [
                HealthConnectorErrorCodeDto.remoteError,
                RemoteErrorException,
              ],
              [
                HealthConnectorErrorCodeDto.unknown,
                UnknownException,
              ],
            ],
            (
              HealthConnectorErrorCodeDto code,
              Type expectedExceptionType,
            ) {
              final context = <String, dynamic>{'key': 'value'};
              const stackTrace = 'Test stack trace';
              final dto = HealthConnectorExceptionDto(
                code: code,
                message: 'Test message',
              );

              final exception = dto.toDomain(
                context: context,
                stackTrace: stackTrace,
              );

              expect(exception, isA<HealthConnectorException>());
              expect(exception.runtimeType, expectedExceptionType);
              expect(exception.message, 'Test message');
            },
          );

          test(
            'creates PlatformException as cause when DTO cause is null',
            () {
              final context = <String, dynamic>{
                'operation': 'write_record',
                'dataType': 'steps',
              };
              const stackTrace = 'at line 1\nat line 2';
              final dto = HealthConnectorExceptionDto(
                code: HealthConnectorErrorCodeDto.invalidArgument,
                message: 'Invalid argument provided',
              );

              final exception = dto.toDomain(
                context: context,
                stackTrace: stackTrace,
              );

              expect(exception.cause, isA<PlatformException>());

              final platformException = exception.cause! as PlatformException;
              expect(platformException.code, 'INVALID_ARGUMENT');
              expect(platformException.message, 'Invalid argument provided');
              expect(platformException.details, context);
              expect(platformException.stacktrace, stackTrace);
            },
          );

          test(
            'uses provided cause when DTO cause is not null',
            () {
              final context = <String, dynamic>{'info': 'test'};
              const stackTrace = 'stack trace';
              final dto = HealthConnectorExceptionDto(
                code: HealthConnectorErrorCodeDto.remoteError,
                message: 'Network error',
                cause: 'SocketException: Connection refused',
              );

              final exception = dto.toDomain(
                context: context,
                stackTrace: stackTrace,
              );

              expect(exception.cause, 'SocketException: Connection refused');
            },
          );

          test(
            'handles null context parameter',
            () {
              final dto = HealthConnectorExceptionDto(
                code: HealthConnectorErrorCodeDto.unknown,
                message: 'Unknown error',
              );

              final exception = dto.toDomain(
                context: null,
                stackTrace: 'trace',
              );

              expect(exception, isA<UnknownException>());
              expect(exception.cause, isA<PlatformException>());
              final platformException = exception.cause! as PlatformException;
              expect(platformException.details, isNull);
            },
          );

          test(
            'handles null stackTrace parameter',
            () {
              final dto = HealthConnectorExceptionDto(
                code: HealthConnectorErrorCodeDto.notAuthorized,
                message: 'Not authorized',
              );

              final exception = dto.toDomain(
                context: <String, dynamic>{},
                stackTrace: null,
              );

              expect(exception, isA<NotAuthorizedException>());
              expect(exception.cause, isA<PlatformException>());
              final platformException = exception.cause! as PlatformException;
              expect(platformException.stacktrace, isNull);
            },
          );

          test(
            'handles both null context and stackTrace',
            () {
              final dto = HealthConnectorExceptionDto(
                code: HealthConnectorErrorCodeDto.invalidConfiguration,
                message: 'Configuration error',
              );

              final exception = dto.toDomain(
                context: null,
                stackTrace: null,
              );

              expect(
                exception,
                isA<InvalidConfigurationException>(),
              );
              expect(
                exception.cause,
                isA<PlatformException>(),
              );

              final platformException = exception.cause! as PlatformException;
              expect(platformException.details, isNull);
              expect(platformException.stacktrace, isNull);
            },
          );
        },
      );
    },
  );
}
