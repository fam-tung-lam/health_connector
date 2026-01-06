import 'package:flutter/services.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_connector_log_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HealthConnectorLogMapper',
    () {
      group(
        'HealthConnectorLogDtoToDomain',
        () {
          test(
            'converts DTO with all required fields',
            () {
              final dto = HealthConnectorLogDto(
                level: HealthConnectorLogLevelDto.info,
                tag: 'HEALTH_CONNECTOR',
                millisecondsSinceEpoch: 1704542400000,
                message: 'Test message',
              );

              final log = dto.toDomain();

              expect(log.level, HealthConnectorLogLevel.info);
              expect(log.tag, 'HEALTH_CONNECTOR');
              expect(log.operation, isNull);
              expect(
                log.dateTime,
                DateTime.fromMillisecondsSinceEpoch(1704542400000),
              );
              expect(log.message, 'Test message');
              expect(log.context, isNull);
              expect(log.exception, isNull);
              expect(log.stackTrace, isNull);
              expect(log.structuredMessage, isNull);
            },
          );

          test(
            'converts DTO with all optional fields populated',
            () {
              final context = <String, dynamic>{
                'key1': 'value1',
                'key2': 42,
              };
              final exceptionDto = HealthConnectorExceptionDto(
                code: HealthConnectorErrorCodeDto.invalidArgument,
                message: 'Test error message',
              );
              const stackTraceString = 'Stack trace line 1\nStack trace line 2';

              final dto = HealthConnectorLogDto(
                level: HealthConnectorLogLevelDto.error,
                tag: 'HEALTH_CONNECTOR',
                millisecondsSinceEpoch: 1704542400000,
                message: 'Test message',
                operation: 'write_record',
                exception: exceptionDto,
                stackTrace: stackTraceString,
                context: context.cast<String?, Object?>(),
                structuredMessage: 'Structured test message',
              );

              final log = dto.toDomain();

              expect(log.level, HealthConnectorLogLevel.error);
              expect(log.tag, 'HEALTH_CONNECTOR');
              expect(log.operation, 'write_record');
              expect(
                log.dateTime,
                DateTime.fromMillisecondsSinceEpoch(1704542400000),
              );
              expect(log.message, 'Test message');
              expect(log.context, context);
              expect(log.exception, isA<HealthConnectorException>());

              final exception = log.exception! as HealthConnectorException;
              expect(exception.message, 'Test error message');
              expect(log.stackTrace, isNotNull);
              expect(log.stackTrace.toString(), stackTraceString);
              expect(log.structuredMessage, 'Structured test message');
            },
          );

          test(
            'converts DTO with null operation',
            () {
              final dto = HealthConnectorLogDto(
                level: HealthConnectorLogLevelDto.debug,
                tag: 'HEALTH_CONNECTOR',
                millisecondsSinceEpoch: 1704542400000,
                message: 'Configure message',
              );

              final log = dto.toDomain();

              expect(log.operation, isNull);
            },
          );

          test(
            'converts DTO with null exception',
            () {
              final dto = HealthConnectorLogDto(
                level: HealthConnectorLogLevelDto.warning,
                tag: 'HEALTH_CONNECTOR',
                millisecondsSinceEpoch: 1704542400000,
                message: 'Request permissions',
              );

              final log = dto.toDomain();

              expect(log.exception, isNull);
            },
          );

          test(
            'converts DTO with null stackTrace',
            () {
              final dto = HealthConnectorLogDto(
                level: HealthConnectorLogLevelDto.info,
                tag: 'HEALTH_CONNECTOR',
                millisecondsSinceEpoch: 1704542400000,
                message: 'Check status',
              );

              final log = dto.toDomain();

              expect(log.stackTrace, isNull);
            },
          );

          test(
            'converts DTO with null context',
            () {
              final dto = HealthConnectorLogDto(
                level: HealthConnectorLogLevelDto.info,
                tag: 'HEALTH_CONNECTOR',
                millisecondsSinceEpoch: 1704542400000,
                message: 'Aggregate',
              );

              final log = dto.toDomain();

              expect(log.context, isNull);
            },
          );

          test(
            'converts DTO with null structuredMessage',
            () {
              final dto = HealthConnectorLogDto(
                level: HealthConnectorLogLevelDto.info,
                tag: 'HEALTH_CONNECTOR',
                millisecondsSinceEpoch: 1704542400000,
                message: 'Delete records',
              );

              final log = dto.toDomain();

              expect(log.structuredMessage, isNull);
            },
          );

          test(
            'passes context and stackTrace to exception mapper',
            () {
              final context = <String, dynamic>{'errorKey': 'errorValue'};
              const stackTraceString = 'Error stack trace';
              final exceptionDto = HealthConnectorExceptionDto(
                code: HealthConnectorErrorCodeDto.remoteError,
                message: 'Remote error occurred',
                cause: 'IOException',
              );

              final dto = HealthConnectorLogDto(
                level: HealthConnectorLogLevelDto.error,
                tag: 'HEALTH_CONNECTOR',
                millisecondsSinceEpoch: 1704542400000,
                message: 'Remote call failed',
                operation: 'remote_call',
                exception: exceptionDto,
                stackTrace: stackTraceString,
                context: context.cast<String?, Object?>(),
              );

              final log = dto.toDomain();

              expect(log.exception, isA<HealthConnectorException>());
              final exception = log.exception! as HealthConnectorException;

              expect(exception.cause, isA<PlatformException>());
              final platformException = exception.cause! as PlatformException;
              expect(platformException.details, context);
              expect(platformException.stacktrace, stackTraceString);
            },
          );
        },
      );

      group(
        'HealthConnectorLogLevelDtoToDomain',
        () {
          parameterizedTest(
            'maps log level DTO to domain',
            [
              [HealthConnectorLogLevelDto.debug, HealthConnectorLogLevel.debug],
              [HealthConnectorLogLevelDto.info, HealthConnectorLogLevel.info],
              [
                HealthConnectorLogLevelDto.warning,
                HealthConnectorLogLevel.warning,
              ],
              [HealthConnectorLogLevelDto.error, HealthConnectorLogLevel.error],
            ],
            (HealthConnectorLogLevelDto dto, HealthConnectorLogLevel level) {
              expect(dto.toDomain(), level);
            },
          );
        },
      );
    },
  );
}
