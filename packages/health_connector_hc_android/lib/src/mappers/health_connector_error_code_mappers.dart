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
      case HealthConnectorErrorCodeDto
          .healthProviderNotInstalledOrUpdateRequired:
        return HealthConnectorErrorCode
            .healthProviderNotInstalledOrUpdateRequired;
      case HealthConnectorErrorCodeDto.healthProviderUnavailable:
        return HealthConnectorErrorCode.healthProviderUnavailable;
      case HealthConnectorErrorCodeDto.unsupportedOperation:
        return HealthConnectorErrorCode.unsupportedOperation;
      case HealthConnectorErrorCodeDto.invalidConfiguration:
        return HealthConnectorErrorCode.invalidConfiguration;
      case HealthConnectorErrorCodeDto.invalidArgument:
        return HealthConnectorErrorCode.invalidArgument;
      case HealthConnectorErrorCodeDto.notAuthorized:
        return HealthConnectorErrorCode.notAuthorized;
      case HealthConnectorErrorCodeDto.remoteError:
        return HealthConnectorErrorCode.remoteError;
      case HealthConnectorErrorCodeDto.userCancelled:
        return HealthConnectorErrorCode.userCancelled;
    }
  }
}

/// Converts [PlatformException.code] string to [HealthConnectorErrorCode].
@sinceV1_0_0
@internal
extension StringToErrorCode on String {
  HealthConnectorErrorCode toErrorCode() {
    try {
      return HealthConnectorErrorCode.values.firstWhere(
        (errorCode) => this == errorCode.code,
      );
    } on StateError {
      return HealthConnectorErrorCode.unknown;
    }
  }
}
