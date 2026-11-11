import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/aggregate_request_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'AggregateRequestMapper',
    () {
      group(
        'AggregateRequestDtoMapper',
        () {
          test('maps a workout with zero duration to an ID-only request', () {
            // Given
            final exerciseSession = ExerciseSessionRecord.internal(
              id: HealthRecordId(FakeData.fakeId),
              startTime: FakeData.fakeStartTime,
              endTime: FakeData.fakeStartTime,
              exerciseType: ExerciseType.running,
              metadata: Metadata.manualEntry(),
            );
            final request = HealthDataType.exerciseSession
                .aggregateActiveEnergyBurnedFor(
                  exerciseSession: exerciseSession,
                );

            // When
            final dto = request.toDto();
            const codec = HealthConnectorHKIOSApi.pigeonChannelCodec;
            final decoded = codec.decodeMessage(codec.encodeMessage(dto));

            // Then
            expect(
              (decoded! as ExerciseSessionActiveEnergyAggregateRequestDto)
                  .encode(),
              [FakeData.fakeId],
            );
          });

          test('maps a saved workout to an ID-only Pigeon request', () {
            // Given
            final AggregateRequest<Energy> request =
                ExerciseSessionActiveEnergyAggregateRequest(
                  exerciseSessionId: HealthRecordId(FakeData.fakeId),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                );

            // When
            final dto = request.toDto();
            const codec = HealthConnectorHKIOSApi.pigeonChannelCodec;
            final decoded = codec.decodeMessage(codec.encodeMessage(dto));

            // Then
            expect(
              decoded,
              isA<ExerciseSessionActiveEnergyAggregateRequestDto>(),
            );
            final workoutDto =
                decoded! as ExerciseSessionActiveEnergyAggregateRequestDto;
            expect(workoutDto.exerciseSessionId, FakeData.fakeId);
            expect(workoutDto.encode(), [FakeData.fakeId]);
          });

          test(
            'maps AggregateRequest for sum to StandardAggregateRequestDto',
            () {
              final request = HealthDataType.steps.aggregateSum(
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              final dto = request.toDto() as StandardAggregateRequestDto;

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
            'maps AggregateRequest for average to StandardAggregateRequestDto',
            () {
              final request = HealthDataType.height.aggregateAvg(
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              final dto = request.toDto() as StandardAggregateRequestDto;

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
            'maps AggregateRequest for min to StandardAggregateRequestDto',
            () {
              final request = HealthDataType.weight.aggregateMin(
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              final dto = request.toDto() as StandardAggregateRequestDto;

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
            'maps AggregateRequest for max to StandardAggregateRequestDto',
            () {
              final request = HealthDataType.height.aggregateMax(
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              final dto = request.toDto() as StandardAggregateRequestDto;

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
