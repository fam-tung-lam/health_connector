import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthConnectorErrorCode, HealthConnectorException;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HealthConnectorErrorCodeDto, HealthConnectorExceptionDto;
import 'package:meta/meta.dart' show internal;

/// Extension to convert [HealthConnectorExceptionDto] to
/// [HealthConnectorException].
@internal
extension HealthConnectorExceptionDtoToDomain on HealthConnectorExceptionDto {
  HealthConnectorException toDomain({
    required final Map<String, dynamic>? context,
    required final String? stackTrace,
  }) {
    final errorCode = _mapDtoErrorCodeToDomain(code);

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

  HealthConnectorErrorCode _mapDtoErrorCodeToDomain(
    HealthConnectorErrorCodeDto dtoCode,
  ) {
    switch (dtoCode) {
      case HealthConnectorErrorCodeDto
          .healthPlatformNotInstalledOrUpdateRequired:
        return HealthConnectorErrorCode
            .healthPlatformNotInstalledOrUpdateRequired;
      case HealthConnectorErrorCodeDto.healthPlatformUnavailable:
        return HealthConnectorErrorCode.healthPlatformUnavailable;
      case HealthConnectorErrorCodeDto.invalidConfiguration:
        return HealthConnectorErrorCode.invalidConfiguration;
      case HealthConnectorErrorCodeDto.invalidArgument:
        return HealthConnectorErrorCode.invalidArgument;
      case HealthConnectorErrorCodeDto.unsupportedOperation:
        return HealthConnectorErrorCode.unsupportedOperation;
      case HealthConnectorErrorCodeDto.unknown:
        return HealthConnectorErrorCode.unknown;
      case HealthConnectorErrorCodeDto.notAuthorized:
        return HealthConnectorErrorCode.notAuthorized;
      case HealthConnectorErrorCodeDto.remoteError:
        return HealthConnectorErrorCode.remoteError;
    }
  }
}
