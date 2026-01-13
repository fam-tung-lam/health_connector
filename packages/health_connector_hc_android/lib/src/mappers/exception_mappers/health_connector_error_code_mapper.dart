import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthConnectorErrorCode, sinceV1_0_0;
import 'package:meta/meta.dart' show internal;

/// Converts [PlatformException.code] string to [HealthConnectorErrorCode].
@sinceV1_0_0
@internal
extension StringToErrorCode on String {
  HealthConnectorErrorCode toErrorCode() {
    // Backward compatibility: Map old error code strings to new ones
    final normalizedCode = switch (this) {
      'PERMISSION_NOT_GRANTED' => 'PERMISSION_NOT_GRANTED',
      'PERMISSION_NOT_DECLARED' => 'PERMISSION_NOT_DECLARED',
      'HEALTH_SERVICE_UNAVAILABLE' => 'HEALTH_SERVICE_UNAVAILABLE',
      'HEALTH_PROVIDER_NOT_INSTALLED_OR_UPDATE_REQUIRED' =>
        'HEALTH_SERVICE_NOT_INSTALLED_OR_UPDATE_REQUIRED',
      'UNKNOWN_ERROR' => 'UNKNOWN_ERROR',
      _ => this, // Use as-is if no mapping needed
    };

    try {
      return HealthConnectorErrorCode.values.firstWhere(
        (errorCode) => normalizedCode == errorCode.code,
      );
    } on StateError {
      return HealthConnectorErrorCode.unknownError;
    }
  }
}
