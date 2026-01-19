import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthConnectorErrorCode;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthConnectorErrorCodeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PlatformException.code] string to [HealthConnectorErrorCode].
@internal
extension HealthConnectorErrorCodeDtoToDomain on HealthConnectorErrorCodeDto {
  HealthConnectorErrorCode toDomain() {
    return switch (this) {
      HealthConnectorErrorCodeDto.permissionNotGranted =>
        HealthConnectorErrorCode.permissionNotGranted,
      HealthConnectorErrorCodeDto.permissionNotDeclared =>
        HealthConnectorErrorCode.permissionNotDeclared,
      HealthConnectorErrorCodeDto.invalidArgument =>
        HealthConnectorErrorCode.invalidArgument,
      HealthConnectorErrorCodeDto.healthServiceUnavailable =>
        HealthConnectorErrorCode.healthServiceUnavailable,
      HealthConnectorErrorCodeDto.healthServiceRestricted =>
        HealthConnectorErrorCode.healthServiceRestricted,
      HealthConnectorErrorCodeDto.healthServiceDatabaseInaccessible =>
        HealthConnectorErrorCode.healthServiceDatabaseInaccessible,
      HealthConnectorErrorCodeDto.unsupportedOperation =>
        HealthConnectorErrorCode.unsupportedOperation,
      HealthConnectorErrorCodeDto.unknownError =>
        HealthConnectorErrorCode.unknownError,
    };
  }
}
