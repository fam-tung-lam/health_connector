import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group('AppleStandHourDataType', () {
    const dataType = HealthDataType.appleStandHour;

    test('exposes its stable identity and platform support', () {
      // Given / When
      final supportedPlatforms =
          dataType.healthPlatformRequirements.supportedHealthPlatforms;

      // Then
      expect(dataType.id, equals('apple_stand_hour'));
      expect(dataType.category, equals(HealthDataTypeCategory.activity));
      expect(supportedPlatforms, contains(HealthPlatform.appleHealth));
      expect(supportedPlatforms, isNot(contains(HealthPlatform.healthConnect)));
    });

    test('supports reading and sum aggregation only', () {
      // Given / When / Then
      expect(dataType, isA<ReadableByIdHealthDataType>());
      expect(dataType, isA<ReadableInTimeRangeHealthDataType>());
      expect(dataType, isA<SumAggregatableHealthDataType<Number>>());
      expect(dataType, isNot(isA<WriteableHealthDataType>()));
      expect(dataType, isNot(isA<DeletableHealthDataType>()));
      expect(dataType.supportedAggregationMetrics, [AggregationMetric.sum]);
    });

    test('requests read permission only', () {
      // Given / When
      final permissions = dataType.permissions;

      // Then
      expect(permissions, [dataType.readPermission]);
    });

    test('creates a sum request for the requested time range', () {
      // Given
      final startTime = DateTime.utc(2026, 9, 10);
      final endTime = DateTime.utc(2026, 9, 11);

      // When
      final request = dataType.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      );

      // Then
      expect(request.dataType, same(dataType));
      expect(request.aggregationMetric, AggregationMetric.sum);
      expect(request.startTime, startTime);
      expect(request.endTime, endTime);
    });
  });
}
