import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/requests/aggregate_requests/aggregate_request.dart';
import 'package:test/test.dart';

void main() {
  group('StandardAggregateRequest', () {
    final now = DateTime(2026, 1, 18);
    final startTime = now.subtract(const Duration(days: 7));
    final endTime = now;

    test('can be instantiated with valid parameters', () {
      final request = StandardAggregateRequest(
        dataType: HealthDataType.bloodGlucose,
        aggregationMetric: AggregationMetric.avg,
        startTime: startTime,
        endTime: endTime,
      );

      expect(request.dataType, HealthDataType.bloodGlucose);
      expect(request.aggregationMetric, AggregationMetric.avg);
      expect(request.startTime, startTime);
      expect(request.endTime, endTime);
    });

    test('throws ArgumentError when dataType is not aggregatable', () {
      // sexualActivity has empty supportedAggregationMetrics
      expect(
        () => StandardAggregateRequest(
          dataType: HealthDataType.sexualActivity,
          aggregationMetric: AggregationMetric.sum,
          startTime: startTime,
          endTime: endTime,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when aggregationMetric is not '
        'supported by dataType', () {
      // BloodGlucose supports avg, min, max, not sum
      expect(
        () => StandardAggregateRequest(
          dataType: HealthDataType.bloodGlucose,
          aggregationMetric: AggregationMetric.sum,
          startTime: startTime,
          endTime: endTime,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => StandardAggregateRequest(
          dataType: HealthDataType.bloodGlucose,
          aggregationMetric: AggregationMetric.avg,
          startTime: endTime,
          endTime: startTime,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when endTime equals startTime', () {
      expect(
        () => StandardAggregateRequest(
          dataType: HealthDataType.bloodGlucose,
          aggregationMetric: AggregationMetric.avg,
          startTime: startTime,
          endTime: startTime,
        ),
        throwsArgumentError,
      );
    });

    test('equality works correctly', () {
      final request1 = StandardAggregateRequest(
        dataType: HealthDataType.bloodGlucose,
        aggregationMetric: AggregationMetric.avg,
        startTime: startTime,
        endTime: endTime,
      );

      final request2 = StandardAggregateRequest(
        dataType: HealthDataType.bloodGlucose,
        aggregationMetric: AggregationMetric.avg,
        startTime: startTime,
        endTime: endTime,
      );

      final differentEndTime = endTime.add(const Duration(days: 1));
      final request3 = StandardAggregateRequest(
        dataType: HealthDataType.bloodGlucose,
        aggregationMetric: AggregationMetric.avg,
        startTime: startTime,
        endTime: differentEndTime,
      );

      expect(request1 == request2, isTrue);
      expect(request1 == request3, isFalse);
      expect(request1.hashCode == request2.hashCode, isTrue);
    });

    test('throws ArgumentError when data type is not aggregatable', () {
      expect(
        () => StandardAggregateRequest(
          dataType: HealthDataType.nutrition,
          aggregationMetric: AggregationMetric.avg,
          startTime: endTime,
          endTime: startTime,
        ),
        throwsArgumentError,
      );
    });
  });

  group('BloodPressureAggregateRequest', () {
    final now = DateTime(2026, 1, 18);
    final startTime = now.subtract(const Duration(days: 7));
    final endTime = now;

    test('can be instantiated with systolic blood pressure', () {
      final request = BloodPressureAggregateRequest(
        dataType: HealthDataType.systolicBloodPressure,
        aggregationMetric: AggregationMetric.avg,
        startTime: startTime,
        endTime: endTime,
      );

      expect(request.dataType, HealthDataType.systolicBloodPressure);
      expect(request.aggregationMetric, AggregationMetric.avg);
      expect(request.startTime, startTime);
      expect(request.endTime, endTime);
    });

    test('can be instantiated with diastolic blood pressure', () {
      final request = BloodPressureAggregateRequest(
        dataType: HealthDataType.diastolicBloodPressure,
        aggregationMetric: AggregationMetric.avg,
        startTime: startTime,
        endTime: endTime,
      );

      expect(request.dataType, HealthDataType.diastolicBloodPressure);
    });

    test('equality works correctly', () {
      final request1 = BloodPressureAggregateRequest(
        dataType: HealthDataType.systolicBloodPressure,
        aggregationMetric: AggregationMetric.avg,
        startTime: startTime,
        endTime: endTime,
      );

      final request2 = BloodPressureAggregateRequest(
        dataType: HealthDataType.systolicBloodPressure,
        aggregationMetric: AggregationMetric.avg,
        startTime: startTime,
        endTime: endTime,
      );

      final request3 = BloodPressureAggregateRequest(
        dataType: HealthDataType.diastolicBloodPressure,
        aggregationMetric: AggregationMetric.avg,
        startTime: startTime,
        endTime: endTime,
      );

      expect(request1 == request2, isTrue);
      expect(request1 == request3, isFalse);
      expect(request1.hashCode == request2.hashCode, isTrue);
    });
  });
}
