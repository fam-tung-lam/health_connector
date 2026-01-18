import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'PowerSeriesDataType',
    () {
      const dataType = HealthDataType.powerSeries;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('power_series'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<PowerSeriesDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<WriteableHealthDataType>());
          expect(dataType, isA<DeletableByIdsHealthDataType>());
          expect(dataType, isA<DeletableInTimeRangeHealthDataType>());
          expect(dataType, isA<AvgAggregatableHealthDataType>());
          expect(dataType, isA<MinAggregatableHealthDataType>());
          expect(dataType, isA<MaxAggregatableHealthDataType>());
        },
      );

      test(
        'supported platforms are correctly defined',
        () {
          expect(dataType.supportedHealthPlatforms, hasLength(1));
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
            contains(AggregationMetric.avg),
          );
          expect(
            dataType.supportedAggregationMetrics,
            contains(AggregationMetric.min),
          );
          expect(
            dataType.supportedAggregationMetrics,
            contains(AggregationMetric.max),
          );
        },
      );
    },
  );
}
