import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ActivityIntensityDataType',
    () {
      const dataType = HealthDataType.activityIntensity;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('activity_intensity'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<ActivityIntensityDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<ReadableByIdHealthDataType>());
          expect(dataType, isA<ReadableInTimeRangeHealthDataType>());
          expect(dataType, isA<WriteableHealthDataType>());
          expect(dataType, isA<DeletableByIdsHealthDataType>());
          expect(dataType, isA<DeletableInTimeRangeHealthDataType>());

          // Should be aggregatable with custom aggregation implementation
          expect(dataType, isA<AggregatableHealthDataType>());

          // Should NOT be min/max/avg aggregatable (it's duration based sum)
          expect(dataType, isNot(isA<MinAggregatableHealthDataType>()));
          expect(dataType, isNot(isA<MaxAggregatableHealthDataType>()));
          expect(dataType, isNot(isA<AvgAggregatableHealthDataType>()));
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
            containsAll([
              const HealthDataPermission(
                dataType: dataType,
                accessType: HealthDataPermissionAccessType.read,
              ),
              const HealthDataPermission(
                dataType: dataType,
                accessType: HealthDataPermissionAccessType.write,
              ),
            ]),
          );
        },
      );

      test(
        'aggregation metrics are correctly defined',
        () {
          expect(dataType.supportedAggregationMetrics, hasLength(1));
          expect(
            dataType.supportedAggregationMetrics,
            contains(AggregationMetric.sum),
          );
        },
      );

      test(
        'category is correctly defined',
        () {
          expect(
            dataType.category,
            equals(HealthDataTypeCategory.activity),
          );
        },
      );
    },
  );
}
