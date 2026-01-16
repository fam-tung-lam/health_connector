import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'BodyFatPercentageDataType',
    () {
      const dataType = HealthDataType.bodyFatPercentage;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('body_fat_percentage'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<BodyFatPercentageDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<WriteableHealthDataType>());
          expect(dataType, isA<DeletableHealthDataType>());
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
          expect(dataType.supportedAggregationMetrics, isEmpty);
        },
      );

      test(
        'category is correctly defined',
        () {
          expect(
            dataType.category,
            equals(HealthDataTypeCategory.bodyMeasurement),
          );
        },
      );
    },
  );
}
