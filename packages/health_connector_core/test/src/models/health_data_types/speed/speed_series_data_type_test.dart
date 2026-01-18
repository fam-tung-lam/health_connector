import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'SpeedSeriesDataType',
    () {
      const dataType = HealthDataType.speedSeries;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('speed_series'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<SpeedSeriesDataType>());
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
          expect(
            dataType.supportedHealthPlatforms,
            contains(HealthPlatform.healthConnect),
          );
          expect(
            dataType.supportedHealthPlatforms,
            isNot(contains(HealthPlatform.appleHealth)),
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
