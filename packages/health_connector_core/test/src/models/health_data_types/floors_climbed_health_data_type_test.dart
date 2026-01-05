import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'FloorsClimbedHealthDataType',
    () {
      const dataType = HealthDataType.floorsClimbed;

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<FloorsClimbedHealthDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<WriteableHealthDataType>());
          expect(dataType, isA<DeletableHealthDataType>());
          expect(dataType, isA<SumAggregatableHealthDataType>());
        },
      );

      test(
        'supported platforms are correctly defined',
        () {
          expect(
            dataType.supportedHealthPlatforms,
            contains(HealthPlatform.appleHealth),
          );
          expect(
            dataType.supportedHealthPlatforms,
            contains(HealthPlatform.healthConnect),
          );
        },
      );

      test(
        'permissions are correctly defined',
        () {
          expect(dataType.permissions, hasLength(2));
          expect(
            dataType.permissions,
            contains(
              const HealthDataPermission(
                dataType: dataType,
                accessType: HealthDataPermissionAccessType.read,
              ),
            ),
          );
          expect(
            dataType.permissions,
            contains(
              const HealthDataPermission(
                dataType: dataType,
                accessType: HealthDataPermissionAccessType.write,
              ),
            ),
          );
        },
      );

      test(
        'aggregation metrics are correctly defined',
        () {
          expect(
            dataType.supportedAggregationMetrics,
            contains(AggregationMetric.sum),
          );
        },
      );
    },
  );
}
