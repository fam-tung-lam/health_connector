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
      HealthConnectorErrorCodeDto.healthPlatformUnavailable =>
        HealthConnectorErrorCode.healthPlatformUnavailable,
      HealthConnectorErrorCodeDto.invalidConfiguration =>
        HealthConnectorErrorCode.invalidConfiguration,
      HealthConnectorErrorCodeDto.invalidArgument =>
        HealthConnectorErrorCode.invalidArgument,
      HealthConnectorErrorCodeDto.unsupportedOperation =>
        HealthConnectorErrorCode.unsupportedOperation,
      HealthConnectorErrorCodeDto.notAuthorized =>
        HealthConnectorErrorCode.notAuthorized,
      HealthConnectorErrorCodeDto.remoteError =>
        HealthConnectorErrorCode.remoteError,
      HealthConnectorErrorCodeDto.syncTokenExpired =>
        HealthConnectorErrorCode.syncTokenExpired,
      HealthConnectorErrorCodeDto.unknown => HealthConnectorErrorCode.unknown,
    };
  }
}
