import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/read_records_response_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'ReadRecordsResponseMapper',
    () {
      group(
        'ReadRecordsResponseDtoToDomain',
        () {
          test(
            'maps ReadRecordsResponseDto to ReadRecordsInTimeRangeResponse',
            () {
              // Given
              final originalRequest =
                  ReadRecordsInTimeRangeRequest<StepsRecord>(
                    dataType: HealthDataType.steps,
                    startTime: FakeData.fakeStartTime,
                    endTime: FakeData.fakeEndTime,
                  );

              final dto = ReadRecordsResponseDto(
                records: [
                  StepsRecordDto(
                    id: 'steps-1',
                    startTime: DateTime(2025, 1, 1, 10).millisecondsSinceEpoch,
                    endTime: DateTime(2025, 1, 1, 11).millisecondsSinceEpoch,
                    startZoneOffsetSeconds: 0,
                    endZoneOffsetSeconds: 0,
                    metadata: MetadataDto(
                      dataOrigin: FakeData.fakeDataOrigin,
                      recordingMethod: RecordingMethodDto.activelyRecorded,
                      clientRecordVersion: 1,
                      deviceType: DeviceTypeDto.phone,
                    ),
                    count: NumberDto(value: 1000),
                  ),
                  StepsRecordDto(
                    id: 'steps-2',
                    startTime: DateTime(2025, 1, 2, 10).millisecondsSinceEpoch,
                    endTime: DateTime(2025, 1, 2, 11).millisecondsSinceEpoch,
                    startZoneOffsetSeconds: 0,
                    endZoneOffsetSeconds: 0,
                    metadata: MetadataDto(
                      dataOrigin: FakeData.fakeDataOrigin,
                      recordingMethod: RecordingMethodDto.activelyRecorded,
                      clientRecordVersion: 1,
                      deviceType: DeviceTypeDto.phone,
                    ),
                    count: NumberDto(value: 2000),
                  ),
                ],
              );

              // When
              final response = dto.toDomain<StepsRecord>(originalRequest);

              // Then
              expect(response.records, hasLength(2));
              expect(response.records[0], isA<StepsRecord>());
              expect(response.records[0].id.value, 'steps-1');
              expect(response.records[1].id.value, 'steps-2');
              expect(response.nextPageRequest, isNull);
            },
          );

          test(
            'creates next page request when page token exists',
            () {
              // Given
              final originalRequest =
                  ReadRecordsInTimeRangeRequest<WeightRecord>(
                    dataType: HealthDataType.weight,
                    startTime: FakeData.fakeStartTime,
                    endTime: FakeData.fakeEndTime,
                    pageSize: 50,
                  );

              final dto = ReadRecordsResponseDto(
                records: [
                  WeightRecordDto(
                    id: 'weight-1',
                    time: DateTime(2025, 1, 1, 8).millisecondsSinceEpoch,
                    zoneOffsetSeconds: 0,
                    metadata: MetadataDto(
                      dataOrigin: FakeData.fakeDataOrigin,
                      recordingMethod: RecordingMethodDto.manualEntry,
                      clientRecordVersion: 1,
                      deviceType: DeviceTypeDto.phone,
                    ),
                    weight: MassDto(kilograms: 70.5),
                  ),
                ],
                nextPageToken: 'next-page-token-123',
              );

              // When
              final response = dto.toDomain<WeightRecord>(originalRequest);

              // Then
              expect(response.records, hasLength(1));
              expect(response.nextPageRequest, isNotNull);
              expect(
                response.nextPageRequest!.pageToken,
                'next-page-token-123',
              );
              expect(response.nextPageRequest!.dataType, HealthDataType.weight);
              expect(
                response.nextPageRequest!.startTime,
                FakeData.fakeStartTime,
              );
              expect(response.nextPageRequest!.endTime, FakeData.fakeEndTime);
              expect(response.nextPageRequest!.pageSize, 50);
            },
          );

          test(
            'does not create next page request when token is empty',
            () {
              // Given
              final originalRequest =
                  ReadRecordsInTimeRangeRequest<HeightRecord>(
                    dataType: HealthDataType.height,
                    startTime: FakeData.fakeStartTime,
                    endTime: FakeData.fakeEndTime,
                  );

              final dto = ReadRecordsResponseDto(
                records: [
                  HeightRecordDto(
                    id: 'height-1',
                    time: DateTime(2025, 1, 1, 8).millisecondsSinceEpoch,
                    zoneOffsetSeconds: 0,
                    metadata: MetadataDto(
                      dataOrigin: FakeData.fakeDataOrigin,
                      recordingMethod: RecordingMethodDto.manualEntry,
                      clientRecordVersion: 1,
                      deviceType: DeviceTypeDto.phone,
                    ),
                    height: LengthDto(meters: 175.0),
                  ),
                ],
                nextPageToken: '',
              );

              // When
              final response = dto.toDomain<HeightRecord>(originalRequest);

              // Then
              expect(response.records, hasLength(1));
              expect(response.nextPageRequest, isNull);
            },
          );
        },
      );
    },
  );
}
