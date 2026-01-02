import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/aggregate_request_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'AggregateRequestMapper',
    () {
      group(
        'AggregateRequestDtoMapper',
        () {
          test(
            'maps AggregateRequest for sum to AggregateRequestDto',
            () {
              final request = HealthDataType.steps.aggregateSum(
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              final dto = request.toDto();

              expect(dto.dataType, HealthDataTypeDto.steps);
              expect(dto.aggregationMetric, AggregationMetricDto.sum);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
            },
          );

          test(
            'maps AggregateRequest for average to AggregateRequestDto',
            () {
              final request = HealthDataType.height.aggregateAvg(
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              final dto = request.toDto();

              expect(dto.dataType, HealthDataTypeDto.height);
              expect(dto.aggregationMetric, AggregationMetricDto.avg);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
            },
          );

          test(
            'maps AggregateRequest for min to AggregateRequestDto',
            () {
              final request = HealthDataType.weight.aggregateMin(
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              final dto = request.toDto();

              expect(dto.dataType, HealthDataTypeDto.weight);
              expect(dto.aggregationMetric, AggregationMetricDto.min);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
            },
          );

          test(
            'maps AggregateRequest for max to AggregateRequestDto',
            () {
              final request = HealthDataType.height.aggregateMax(
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              final dto = request.toDto();

              expect(dto.dataType, HealthDataTypeDto.height);
              expect(dto.aggregationMetric, AggregationMetricDto.max);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
            },
          );
        },
      );
    },
  );
}
