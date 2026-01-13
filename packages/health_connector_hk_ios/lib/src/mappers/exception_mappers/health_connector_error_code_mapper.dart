import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthConnectorErrorCode, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthConnectorErrorCodeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PlatformException.code] string to [HealthConnectorErrorCode].
@sinceV1_0_0
@internal
extension HealthConnectorErrorCodeDtoToDomain on HealthConnectorErrorCodeDto {
  HealthConnectorErrorCode toDomain() {
    return switch (this) {
      // Authorization errors
      HealthConnectorErrorCodeDto.authorizationDenied =>
        HealthConnectorErrorCode.authorizationDenied,
      HealthConnectorErrorCodeDto.authorizationNotDetermined =>
        HealthConnectorErrorCode.authorizationNotDetermined,

      // Configuration errors
      HealthConnectorErrorCodeDto.permissionNotDeclared =>
        HealthConnectorErrorCode.permissionNotDeclared,
      // Invalid argument
      HealthConnectorErrorCodeDto.invalidArgument =>
        HealthConnectorErrorCode.invalidArgument,
      // Health service unavailable
      HealthConnectorErrorCodeDto.healthServiceUnavailable =>
        HealthConnectorErrorCode.healthServiceUnavailable,
      HealthConnectorErrorCodeDto.healthServiceRestricted =>
        HealthConnectorErrorCode.healthServiceRestricted,
      // Health service errors
      HealthConnectorErrorCodeDto.healthServiceDatabaseInaccessible =>
        HealthConnectorErrorCode.healthServiceDatabaseInaccessible,
      HealthConnectorErrorCodeDto.ioError => HealthConnectorErrorCode.ioError,
      HealthConnectorErrorCodeDto.remoteError =>
        HealthConnectorErrorCode.remoteError,
      HealthConnectorErrorCodeDto.rateLimitExceeded =>
        HealthConnectorErrorCode.rateLimitExceeded,
      HealthConnectorErrorCodeDto.dataSyncInProgress =>
        HealthConnectorErrorCode.dataSyncInProgress,
      // Unsupported operation
      HealthConnectorErrorCodeDto.unsupportedOperation =>
        HealthConnectorErrorCode.unsupportedOperation,
      // Unknown
      HealthConnectorErrorCodeDto.unknownError =>
        HealthConnectorErrorCode.unknownError,
    };
  }
}
