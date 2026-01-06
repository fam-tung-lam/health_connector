import 'package:health_connector_hc_android/src/mappers/exception_mappers/health_connector_exception_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [HealthConnectorLogDto] to [HealthConnectorLog].
@internal
extension HealthConnectorLogDtoToDomain on HealthConnectorLogDto {
  HealthConnectorLog toDomain() {
    final details = context?.cast<String, dynamic>();

    return HealthConnectorLog(
      level: level.toDomain(),
      tag: tag,
      operation: operation,
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch,
      ),
      message: message,
      context: details,
      exception: exception?.toDomain(
        context: details,
        stackTrace: stackTrace,
      ),
      stackTrace: stackTrace != null
          ? StackTrace.fromString(stackTrace!)
          : null,
      structuredMessage: structuredMessage,
    );
  }
}

/// Extension to convert [HealthConnectorLogLevelDto] to
/// [HealthConnectorLogLevel].
@internal
extension HealthConnectorLogLevelDtoToDomain on HealthConnectorLogLevelDto {
  HealthConnectorLogLevel toDomain() {
    return switch (this) {
      HealthConnectorLogLevelDto.debug => HealthConnectorLogLevel.debug,
      HealthConnectorLogLevelDto.info => HealthConnectorLogLevel.info,
      HealthConnectorLogLevelDto.warning => HealthConnectorLogLevel.warning,
      HealthConnectorLogLevelDto.error => HealthConnectorLogLevel.error,
    };
  }
}
