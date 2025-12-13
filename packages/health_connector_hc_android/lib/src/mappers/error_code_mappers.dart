import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core.dart'
    show HealthConnectorErrorCode, sinceV1_0_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HealthConnectorErrorCodeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthConnectorErrorCodeDto] to [HealthConnectorErrorCode].
@sinceV1_0_0
@internal
extension HealthConnectorErrorCodeDtoToDomain on HealthConnectorErrorCodeDto {
  HealthConnectorErrorCode toDomain() {
    switch (this) {
      case HealthConnectorErrorCodeDto.unknown:
        return HealthConnectorErrorCode.unknown;
      case HealthConnectorErrorCodeDto.installationOrUpdateRequired:
        return HealthConnectorErrorCode.installationOrUpdateRequired;
      case HealthConnectorErrorCodeDto.healthPlatformUnavailable:
        return HealthConnectorErrorCode.healthPlatformUnavailable;
      case HealthConnectorErrorCodeDto.unsupportedHealthPlatformApi:
        return HealthConnectorErrorCode.unsupportedHealthPlatformApi;
      case HealthConnectorErrorCodeDto.invalidPlatformConfiguration:
        return HealthConnectorErrorCode.invalidPlatformConfiguration;
      case HealthConnectorErrorCodeDto.invalidArgument:
        return HealthConnectorErrorCode.invalidArgument;
      case HealthConnectorErrorCodeDto.securityError:
        return HealthConnectorErrorCode.securityError;
    }
  }
}

/// Converts [PlatformException.code] string to [HealthConnectorErrorCode].
@sinceV1_0_0
@internal
extension StringToHealthConnectorErrorCode on String {
  HealthConnectorErrorCode toHealthConnectorErrorCode() {
    try {
      return HealthConnectorErrorCode.values.firstWhere(
        (errorCode) => this == errorCode.code,
      );
    } on StateError {
      return HealthConnectorErrorCode.unknown;
    }
  }
}
