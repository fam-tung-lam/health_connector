import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'DietarySeleniumDataType',
    () {
      const dataType = HealthDataType.dietarySelenium;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('dietary_selenium'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<DietarySeleniumDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<WriteableHealthDataType>());
          expect(dataType, isA<DeletableByIdsHealthDataType>());
          expect(dataType, isA<DeletableInTimeRangeHealthDataType>());
          expect(dataType, isA<SumAggregatableHealthDataType>());
        },
      );

      test(
        'supported platforms are correctly defined',
        () {
          expect(
            dataType.supportedHealthPlatforms,
            isNot(contains(HealthPlatform.healthConnect)),
          );
          expect(
            dataType.supportedHealthPlatforms,
            contains(HealthPlatform.appleHealth),
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

      test(
        'category is correctly defined',
        () {
          expect(
            dataType.category,
            equals(HealthDataTypeCategory.nutrition),
          );
        },
      );
    },
  );
}
