import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_connector_config_mapper.dart';

void main() {
  group(
    'HealthConnectorConfigMappers',
    () {
      test(
        'converts HealthConnectorConfig with logging enabled to '
        'HealthConnectorConfigDto',
        () {
          const config = HealthConnectorConfig();
          final dto = config.toDto();

          expect(dto.isLoggerEnabled, true);
        },
      );

      test(
        'converts HealthConnectorConfig with logging disabled to '
        'HealthConnectorConfigDto',
        () {
          const config = HealthConnectorConfig(isLoggerEnabled: false);
          final dto = config.toDto();

          expect(dto.isLoggerEnabled, false);
        },
      );
    },
  );
}
