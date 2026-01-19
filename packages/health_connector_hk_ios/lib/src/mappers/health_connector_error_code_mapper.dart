import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthConnectorErrorCode;
import 'package:meta/meta.dart' show internal;

/// Converts [PlatformException.code] string to [HealthConnectorErrorCode].
@internal
extension StringToErrorCode on String {
  HealthConnectorErrorCode toErrorCode() {
    try {
      return HealthConnectorErrorCode.values.firstWhere(
        (errorCode) => this == errorCode.code,
      );
    } on StateError {
      return HealthConnectorErrorCode.unknownError;
    }
  }
}
