import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'WalkingHeartRateAverageDataType',
    () {
      const dataType = HealthDataType.walkingHeartRateAverage;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('walking_heart_rate_average'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<WalkingHeartRateAverageDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<ReadableByIdHealthDataType>());
          expect(dataType, isA<ReadableInTimeRangeHealthDataType>());
          expect(dataType, isA<AvgAggregatableHealthDataType>());
          expect(dataType, isA<MinAggregatableHealthDataType>());
          expect(dataType, isA<MaxAggregatableHealthDataType>());

          // Not writeable - read-only data type
          expect(dataType, isNot(isA<WriteableHealthDataType>()));
          // Not deletable - read-only data type
          expect(dataType, isNot(isA<DeletableHealthDataType>()));
        },
      );

      test(
        'supported platforms are correctly defined',
        () {
          expect(
            dataType.supportedHealthPlatforms,
            contains(HealthPlatform.appleHealth),
          );
          // Not supported on Health Connect (iOS only)
          expect(
            dataType.supportedHealthPlatforms,
            isNot(contains(HealthPlatform.healthConnect)),
          );
        },
      );

      test(
        'permissions are correctly defined',
        () {
          // Read-only, so only read permission
          expect(dataType.permissions, hasLength(1));
          expect(
            dataType.permissions,
            contains(
              const HealthDataPermission(
                dataType: dataType,
                accessType: HealthDataPermissionAccessType.read,
              ),
            ),
          );
          // Should NOT have write permission
          expect(
            dataType.permissions,
            isNot(
              contains(
                const HealthDataPermission(
                  dataType: dataType,
                  accessType: HealthDataPermissionAccessType.write,
                ),
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

      test(
        'category is correctly defined',
        () {
          expect(
            dataType.category,
            equals(HealthDataTypeCategory.vitals),
          );
        },
      );
    },
  );
}
