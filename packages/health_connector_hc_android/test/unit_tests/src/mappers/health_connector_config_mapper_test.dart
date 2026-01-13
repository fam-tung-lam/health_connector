import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_connector_config_mapper.dart';
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'ConfigMapper',
    () {
      group(
        'HealthConnectorConfigMappers',
        () {
          parameterizedTest(
            'maps HealthConnectorConfig to HealthConnectorConfigDto',
            [
              [true],
              [false],
            ],
            (bool isLoggerEnabled) {
              final config = HealthConnectorConfig(
                loggerConfig: HealthConnectorLoggerConfig(
                  enableNativeLogging: isLoggerEnabled,
                ),
              );
              final dto = config.toDto();
              expect(dto.isLoggerEnabled, isLoggerEnabled);
            },
          );
        },
      );
    },
  );
}
