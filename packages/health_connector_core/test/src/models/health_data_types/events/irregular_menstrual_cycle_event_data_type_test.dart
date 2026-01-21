import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group('IrregularMenstrualCycleEventDataType', () {
    const dataType = HealthDataType.irregularMenstrualCycleEvent;

    test('has correct id', () {
      expect(dataType.id, 'irregular_menstrual_cycle_event');
    });
    test(
      'type and capabilities are correctly defined',
      () {
        expect(dataType, isA<IrregularMenstrualCycleEventDataType>());
        expect(dataType, isA<ReadableInTimeRangeHealthDataType>());
        expect(dataType, isA<ReadableByIdHealthDataType>());

        // Verify it is NOT writeable or deletable
        expect(dataType, isNot(isA<WriteableHealthDataType>()));
        expect(dataType, isNot(isA<DeletableHealthDataType>()));

        // Verify it does NOT support aggregation
        expect(dataType, isNot(isA<AggregatableHealthDataType>()));
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
      'aggregation metrics are empty',
      () {
        expect(
          dataType.supportedAggregationMetrics,
          isEmpty,
        );
      },
    );

    test(
      'category is correctly defined',
      () {
        expect(
          dataType.category,
          equals(HealthDataTypeCategory.reproductiveHealth),
        );
      },
    );
  });
}
