import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ElectrodermalActivityDataType',
    () {
      const dataType = HealthDataType.electrodermalActivity;

      test(
        'has correct id',
        () {
          expect(dataType.id, equals('electrodermal_activity'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<ElectrodermalActivityDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
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
          expect(dataType.supportedHealthPlatforms, hasLength(1));
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
          expect(dataType.supportedAggregationMetrics, hasLength(1));
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

      test(
        'readById creates correct request',
        () {
          final id = HealthRecordId('test-id');
          final request = dataType.readById(id);

          expect(request.dataType, dataType);
          expect(request.id, id);
        },
      );

      test(
        'readInTimeRange creates correct request',
        () {
          final startTime = DateTime(2026);
          final endTime = DateTime(2026, 1, 2);
          final request = dataType.readInTimeRange(
            startTime: startTime,
            endTime: endTime,
          );

          expect(request.dataType, dataType);
          expect(request.startTime, startTime);
          expect(request.endTime, endTime);
        },
      );

      test(
        'aggregateSum creates correct request',
        () {
          final startTime = DateTime(2026);
          final endTime = DateTime(2026, 1, 2);
          final request = dataType.aggregateSum(
            startTime: startTime,
            endTime: endTime,
          );

          expect(request.dataType, dataType);
          expect(request.aggregationMetric, AggregationMetric.sum);
          expect(request.startTime, startTime);
          expect(request.endTime, endTime);
        },
      );

      test(
        'deleteByIds creates correct request',
        () {
          final ids = [
            HealthRecordId('id-1'),
            HealthRecordId('id-2'),
          ];
          final request = dataType.deleteByIds(ids);

          expect(request.dataType, dataType);
          expect(request.recordIds, ids);
        },
      );

      test(
        'deleteInTimeRange creates correct request',
        () {
          final startTime = DateTime(2026);
          final endTime = DateTime(2026, 1, 2);
          final request = dataType.deleteInTimeRange(
            startTime: startTime,
            endTime: endTime,
          );

          expect(request.dataType, dataType);
          expect(request.startTime, startTime);
          expect(request.endTime, endTime);
        },
      );
    },
  );
}
