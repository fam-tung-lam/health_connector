import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthConnectorConfig;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthConnectorConfigDto;

/// Extension for mapping [HealthConnectorConfig] to DTO.
extension HealthConnectorConfigMappers on HealthConnectorConfig {
  /// Converts this [HealthConnectorConfig] to a [HealthConnectorConfigDto].
  HealthConnectorConfigDto toDto() {
    return HealthConnectorConfigDto(
      isLoggerEnabled: loggerConfig.enableNativeLogging,
    );
  }
}
