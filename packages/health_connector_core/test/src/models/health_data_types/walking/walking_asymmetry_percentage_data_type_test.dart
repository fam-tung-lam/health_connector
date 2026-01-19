import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'WalkingAsymmetryPercentageDataType',
    () {
      const dataType = HealthDataType.walkingAsymmetryPercentage;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('walking_asymmetry_percentage'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<WalkingAsymmetryPercentageDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<ReadableByIdHealthDataType>());
          expect(dataType, isA<ReadableInTimeRangeHealthDataType>());
          expect(dataType, isA<AvgAggregatableHealthDataType>());
          expect(dataType, isA<MinAggregatableHealthDataType>());
          expect(dataType, isA<MaxAggregatableHealthDataType>());

          // It is not writable and deletable
          expect(dataType, isNot(isA<WriteableHealthDataType>()));
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
          expect(
            dataType.supportedHealthPlatforms,
            isNot(contains(HealthPlatform.healthConnect)),
          );
        },
      );

      test(
        'permissions are correctly defined',
        () {
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
            equals(HealthDataTypeCategory.mobility),
          );
        },
      );
    },
  );
}
