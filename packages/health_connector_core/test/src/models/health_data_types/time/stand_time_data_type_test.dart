import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'StandTimeDataType',
    () {
      const dataType = HealthDataType.standTime;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('apple_stand_time'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<StandTimeDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<ReadableByIdHealthDataType>());
          expect(dataType, isA<ReadableInTimeRangeHealthDataType>());
          expect(dataType, isA<SumAggregatableHealthDataType>());

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
