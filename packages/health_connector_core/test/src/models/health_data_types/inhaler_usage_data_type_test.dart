import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'InhalerUsageDataType',
    () {
      const dataType = HealthDataType.inhalerUsage;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('inhaler_usage'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<InhalerUsageDataType>());
          expect(dataType, isA<ReadableByIdHealthDataType>());
          expect(dataType, isA<ReadableInTimeRangeHealthDataType>());
          expect(dataType, isA<WriteableHealthDataType>());
          expect(dataType, isA<SumAggregatableHealthDataType>());
          expect(dataType, isA<DeletableByIdsHealthDataType>());
          expect(dataType, isA<DeletableInTimeRangeHealthDataType>());
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
            equals(HealthDataTypeCategory.clinical),
          );
        },
      );

      test(
        'readById returns correct request',
        () {
          final id = HealthRecordId('test-id');
          final request = dataType.readById(id);
          expect(request.dataType, equals(dataType));
          expect(request.id, equals(id));
        },
      );

      test(
        'readInTimeRange returns correct request',
        () {
          final startTime = DateTime(2026);
          final endTime = DateTime(2026, 1, 2);
          final request = dataType.readInTimeRange(
            startTime: startTime,
            endTime: endTime,
          );
          expect(request.dataType, equals(dataType));
          expect(request.startTime, equals(startTime));
          expect(request.endTime, equals(endTime));
        },
      );

      test(
        'aggregateSum returns correct request',
        () {
          final startTime = DateTime(2026);
          final endTime = DateTime(2026, 1, 2);
          final request = dataType.aggregateSum(
            startTime: startTime,
            endTime: endTime,
          );
          expect(request.dataType, equals(dataType));
          expect(request.aggregationMetric, equals(AggregationMetric.sum));
          expect(request.startTime, equals(startTime));
          expect(request.endTime, equals(endTime));
        },
      );

      test(
        'deleteByIds returns correct request',
        () {
          final recordIds = [HealthRecordId('id1')];
          final request = dataType.deleteByIds(recordIds);
          expect(request.dataType, equals(dataType));
          expect(request.recordIds, equals(recordIds));
        },
      );

      test(
        'deleteInTimeRange returns correct request',
        () {
          final startTime = DateTime(2026);
          final endTime = DateTime(2026, 1, 2);
          final request = dataType.deleteInTimeRange(
            startTime: startTime,
            endTime: endTime,
          );
          expect(request.dataType, equals(dataType));
          expect(request.startTime, equals(startTime));
          expect(request.endTime, equals(endTime));
        },
      );
    },
  );
}
