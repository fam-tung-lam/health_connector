import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'SleepingWristTemperatureDataType',
    () {
      const dataType = HealthDataType.sleepingWristTemperature;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('sleeping_wrist_temperature'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<SleepingWristTemperatureDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<ReadableByIdHealthDataType>());
          expect(dataType, isA<ReadableInTimeRangeHealthDataType>());
          expect(dataType, isA<MinAggregatableHealthDataType>());
          expect(dataType, isA<MaxAggregatableHealthDataType>());
          expect(dataType, isA<AvgAggregatableHealthDataType>());

          // Should NOT be writeable or deletable
          expect(dataType, isNot(isA<WriteableHealthDataType>()));
          expect(dataType, isNot(isA<DeletableHealthDataType>()));
        },
      );

      test(
        'supported platforms are correctly defined',
        () {
          expect(dataType.supportedHealthPlatforms, hasLength(1));
          expect(
            dataType.supportedHealthPlatforms,
            contains(HealthPlatform.appleHealth),
          );
          expect(
            dataType.supportedHealthPlatforms,
            isNot(contains(HealthPlatform.healthConnect)),
          );
        },
      );

      test(
        'permissions are correctly defined',
        () {
          // Only read permission supported
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
        },
      );

      test(
        'aggregation metrics are correctly defined',
        () {
          expect(dataType.supportedAggregationMetrics, hasLength(3));
          expect(
            dataType.supportedAggregationMetrics,
            containsAll([
              AggregationMetric.min,
              AggregationMetric.max,
              AggregationMetric.avg,
            ]),
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
