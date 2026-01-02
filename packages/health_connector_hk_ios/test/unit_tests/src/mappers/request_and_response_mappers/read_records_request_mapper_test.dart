import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/read_records_request_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'ReadRecordsRequestMapper',
    () {
      group(
        'ReadRecordsRequestDtoMapper',
        () {
          test(
            'maps ReadRecordsInTimeRangeRequest to ReadRecordsRequestDto',
            () {
              // Given
              final request = ReadRecordsInTimeRangeRequest<StepsRecord>(
                dataType: HealthDataType.steps,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              // When
              final dto = request.toDto();

              // Then
              expect(dto.dataType, HealthDataTypeDto.steps);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(dto.pageSize, 100);
              expect(dto.pageToken, isNull);
              expect(dto.dataOriginPackageNames, isEmpty);
            },
          );

          test(
            'maps ReadRecordsInTimeRangeRequest with page token',
            () {
              // Given
              final request = ReadRecordsInTimeRangeRequest<WeightRecord>(
                dataType: HealthDataType.weight,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                pageSize: 50,
                pageToken: 'next-page-token-123',
              );

              // When
              final dto = request.toDto();

              // Then
              expect(dto.dataType, HealthDataTypeDto.weight);
              expect(dto.pageSize, 50);
              expect(dto.pageToken, 'next-page-token-123');
            },
          );

          test(
            'maps ReadRecordsInTimeRangeRequest with data origins',
            () {
              // Given
              final request = ReadRecordsInTimeRangeRequest<HeightRecord>(
                dataType: HealthDataType.height,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                dataOrigins: const [
                  DataOrigin('com.apple.health'),
                  DataOrigin('com.example.app'),
                ],
              );

              // When
              final dto = request.toDto();

              // Then
              expect(dto.dataType, HealthDataTypeDto.height);
              expect(dto.dataOriginPackageNames, hasLength(2));
              expect(dto.dataOriginPackageNames[0], 'com.apple.health');
              expect(dto.dataOriginPackageNames[1], 'com.example.app');
            },
          );
        },
      );
    },
  );
}
