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
      // Authorization errors
      case HealthConnectorErrorCodeDto.authorizationDenied:
        return HealthConnectorErrorCode.authorizationDenied;
      case HealthConnectorErrorCodeDto.authorizationNotDetermined:
        return HealthConnectorErrorCode.authorizationNotDetermined;

      // Configuration errors
      case HealthConnectorErrorCodeDto.permissionNotDeclared:
        return HealthConnectorErrorCode.permissionNotDeclared;

      // Health Service Unavailable errors
      case HealthConnectorErrorCodeDto.healthServiceUnavailable:
        return HealthConnectorErrorCode.healthServiceUnavailable;
      case HealthConnectorErrorCodeDto.healthServiceRestricted:
        return HealthConnectorErrorCode.healthServiceRestricted;
      case HealthConnectorErrorCodeDto
          .healthServiceNotInstalledOrUpdateRequired:
        return HealthConnectorErrorCode
            .healthServiceNotInstalledOrUpdateRequired;

      // Health Service errors
      case HealthConnectorErrorCodeDto.healthServiceDatabaseInaccessible:
        return HealthConnectorErrorCode.healthServiceDatabaseInaccessible;
      case HealthConnectorErrorCodeDto.ioError:
        return HealthConnectorErrorCode.ioError;
      case HealthConnectorErrorCodeDto.remoteError:
        return HealthConnectorErrorCode.remoteError;
      case HealthConnectorErrorCodeDto.rateLimitExceeded:
        return HealthConnectorErrorCode.rateLimitExceeded;
      case HealthConnectorErrorCodeDto.dataSyncInProgress:
        return HealthConnectorErrorCode.dataSyncInProgress;

      // Invalid Argument error
      case HealthConnectorErrorCodeDto.invalidArgument:
        return HealthConnectorErrorCode.invalidArgument;

      // Unsupported Operation error
      case HealthConnectorErrorCodeDto.unsupportedOperation:
        return HealthConnectorErrorCode.unsupportedOperation;

      // Unknown error
      case HealthConnectorErrorCodeDto.unknownError:
        return HealthConnectorErrorCode.unknownError;
    }
  }
}
