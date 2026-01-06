import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthConnectorException;
import 'package:health_connector_hk_ios/src/mappers/exception_mappers/health_connector_error_code_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthConnectorExceptionDto;
import 'package:meta/meta.dart' show internal;

/// Extension to convert [HealthConnectorExceptionDto] to
/// [HealthConnectorException].
@internal
extension HealthConnectorExceptionDtoToDomain on HealthConnectorExceptionDto {
  HealthConnectorException toDomain({
    required final Map<String, dynamic>? context,
    required final String? stackTrace,
  }) {
    final errorCode = code.toDomain();

    return HealthConnectorException.fromCode(
      errorCode,
      message,
      cause: PlatformException(
        code: errorCode.code,
        message: cause != null ? '$message. Cause: $cause' : message,
        details: context,
        stacktrace: stackTrace,
      ),
    );
  }
}
