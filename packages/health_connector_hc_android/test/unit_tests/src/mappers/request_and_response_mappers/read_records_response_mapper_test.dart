import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/read_records_response_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'ReadRecordsResponseMapper',
    () {
      group(
        'ReadRecordsResponseDtoToDomain',
        () {
          test(
            'maps ReadRecordsResponseDto to ReadRecordsInTimeRangeResponse '
            'with nextPageToken',
            () {
              final startTime = DateTime(2025);
              final endTime = DateTime(2025, 1, 31, 23, 59);
              final originalRequest = HealthDataType.steps.readInTimeRange(
                startTime: startTime,
                endTime: endTime,
              );

              final recordTime1 = DateTime(2025, 1, 5, 10);
              final recordTime2 = DateTime(2025, 1, 10, 15, 30);

              final dto = ReadRecordsResponseDto(
                records: [
                  StepsRecordDto(
                    id: 'record-1',
                    startTime: recordTime1.millisecondsSinceEpoch,
                    endTime: recordTime1
                        .add(const Duration(hours: 1))
                        .millisecondsSinceEpoch,
                    startZoneOffsetSeconds: 0,
                    endZoneOffsetSeconds: 0,
                    metadata: MetadataDto(
                      dataOrigin: FakeData.fakeDataOrigin,
                      recordingMethod: RecordingMethodDto.activelyRecorded,
                      clientRecordVersion: 1,
                      deviceType: DeviceTypeDto.phone,
                    ),
                    count: 1000,
                  ),
                  StepsRecordDto(
                    id: 'record-2',
                    startTime: recordTime2.millisecondsSinceEpoch,
                    endTime: recordTime2
                        .add(const Duration(hours: 2))
                        .millisecondsSinceEpoch,
                    startZoneOffsetSeconds: 0,
                    endZoneOffsetSeconds: 0,
                    metadata: MetadataDto(
                      dataOrigin: 'com.example.app2',
                      recordingMethod: RecordingMethodDto.manualEntry,
                      clientRecordVersion: 1,
                      deviceType: DeviceTypeDto.watch,
                    ),
                    count: 2000,
                  ),
                ],
                nextPageToken: 'next-page-token-456',
              );

              final response = dto.toDomain<StepsRecord>(originalRequest);

              expect(response.records, hasLength(2));
              expect(response.records[0], isA<StepsRecord>());
              expect(response.records[0].count.value, 1000);
              expect(response.records[1], isA<StepsRecord>());
              expect(response.records[1].count.value, 2000);

              expect(response.nextPageRequest, isNotNull);
              expect(
                response.nextPageRequest!.pageToken,
                'next-page-token-456',
              );
              expect(
                response.nextPageRequest!.dataType,
                originalRequest.dataType,
              );
              expect(
                response.nextPageRequest!.startTime,
                originalRequest.startTime,
              );
              expect(
                response.nextPageRequest!.endTime,
                originalRequest.endTime,
              );
              expect(
                response.nextPageRequest!.pageSize,
                originalRequest.pageSize,
              );
            },
          );

          test(
            'maps ReadRecordsResponseDto to ReadRecordsInTimeRangeResponse '
            'with null nextPageToken',
            () {
              final startTime = DateTime(2025);
              final endTime = DateTime(2025, 1, 31);
              final originalRequest = HealthDataType.weight.readInTimeRange(
                startTime: startTime,
                endTime: endTime,
                pageSize: 50,
              );

              final recordTime = DateTime(2025, 1, 15, 8);

              final dto = ReadRecordsResponseDto(
                records: [
                  WeightRecordDto(
                    id: 'weight-1',
                    time: recordTime.millisecondsSinceEpoch,
                    zoneOffsetSeconds: 0,
                    metadata: MetadataDto(
                      dataOrigin: 'com.example.healthapp',
                      recordingMethod: RecordingMethodDto.manualEntry,
                      clientRecordVersion: 1,
                      deviceType: DeviceTypeDto.phone,
                    ),
                    kilograms: 70.5,
                  ),
                ],
              );

              final response = dto.toDomain<WeightRecord>(originalRequest);

              expect(response.records, hasLength(1));
              expect(response.records[0], isA<WeightRecord>());
              expect(response.records[0].weight.inKilograms, 70.5);

              expect(response.nextPageRequest, isNull);
            },
          );

          test(
            'maps ReadRecordsResponseDto with empty nextPageToken to '
            'response without nextPageRequest',
            () {
              final startTime = DateTime(2025);
              final endTime = DateTime(2025, 1, 31);
              final originalRequest = HealthDataType.steps.readInTimeRange(
                startTime: startTime,
                endTime: endTime,
              );

              final dto = ReadRecordsResponseDto(
                records: [],
                nextPageToken: '',
              );

              final response = dto.toDomain<StepsRecord>(originalRequest);

              expect(response.records, isEmpty);
              expect(response.nextPageRequest, isNull);
            },
          );
        },
      );
    },
  );
}
