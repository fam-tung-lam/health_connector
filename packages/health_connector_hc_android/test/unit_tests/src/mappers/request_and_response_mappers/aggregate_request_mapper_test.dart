import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/aggregate_request_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'AggregateRequestMapper',
    () {
      final startTime = DateTime(2025);
      final endTime = DateTime(2025, 1, 31, 23, 59);

      group(
        'AggregateRequestDtoMapper',
        () {
          test(
            'maps CommonAggregateRequest to CommonAggregateRequestDto',
            () {
              final request = HealthDataType.steps.aggregateSum(
                startTime: startTime,
                endTime: endTime,
              );

              final dto = request.toDto();

              expect(dto, isA<CommonAggregateRequestDto>());
              final commonDto = dto as CommonAggregateRequestDto;
              expect(commonDto.dataType, HealthDataTypeDto.steps);
              expect(commonDto.aggregationMetric, AggregationMetricDto.sum);
              expect(
                commonDto.startTime,
                startTime.millisecondsSinceEpoch,
              );
              expect(commonDto.endTime, endTime.millisecondsSinceEpoch);
            },
          );

          test(
            'maps BloodPressureAggregateRequest with systolic to '
            'BloodPressureAggregateRequestDto',
            () {
              final request = HealthDataType.bloodPressure.aggregateAverage(
                bloodPressureType: HealthDataType.systolicBloodPressure,
                startTime: startTime,
                endTime: endTime,
              );

              final dto = request.toDto();

              expect(dto, isA<BloodPressureAggregateRequestDto>());
              final bpDto = dto as BloodPressureAggregateRequestDto;
              expect(
                bpDto.bloodPressureDataType,
                BloodPressureDataTypeDto.systolic,
              );
              expect(bpDto.aggregationMetric, AggregationMetricDto.avg);
              expect(bpDto.startTime, startTime.millisecondsSinceEpoch);
              expect(bpDto.endTime, endTime.millisecondsSinceEpoch);
            },
          );

          test(
            'maps BloodPressureAggregateRequest with diastolic to '
            'BloodPressureAggregateRequestDto',
            () {
              final request = HealthDataType.bloodPressure.aggregateMin(
                bloodPressureType: HealthDataType.diastolicBloodPressure,
                startTime: startTime,
                endTime: endTime,
              );

              final dto = request.toDto();

              expect(dto, isA<BloodPressureAggregateRequestDto>());
              final bpDto = dto as BloodPressureAggregateRequestDto;
              expect(
                bpDto.bloodPressureDataType,
                BloodPressureDataTypeDto.diastolic,
              );
              expect(bpDto.aggregationMetric, AggregationMetricDto.min);
              expect(bpDto.startTime, startTime.millisecondsSinceEpoch);
              expect(bpDto.endTime, endTime.millisecondsSinceEpoch);
            },
          );
        },
      );
    },
  );
}
