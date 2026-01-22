import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_sync/health_data_sync_result_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'HealthDataSyncResultMapper',
    () {
      group(
        'HealthDataSyncResultFromDomainToDto',
        () {
          test(
            'converts HealthDataSyncResult to HealthDataSyncResultDto',
            () {
              final now = DateTime.now().toUtc();
              final result = HealthDataSyncResult.internal(
                upsertedRecords: [
                  StepsRecord(
                    count: const Number(1000),
                    startTime: FakeData.fakeStartTime,
                    endTime: FakeData.fakeEndTime,
                    metadata: Metadata.manualEntry(),
                  ),
                ],
                deletedRecordIds: [
                  HealthRecordId('deleted-id-1'),
                  HealthRecordId('deleted-id-2'),
                ],
                hasMore: true,
                nextSyncToken: HealthDataSyncToken.internal(
                  token: 'next-token',
                  dataTypes: const [HealthDataType.steps],
                  createdAt: now,
                ),
              );

              final dto = result.toDto();

              expect(dto.upsertedRecords, hasLength(1));
              expect(dto.deletedRecordIds, hasLength(2));
              expect(dto.deletedRecordIds[0], 'deleted-id-1');
              expect(dto.deletedRecordIds[1], 'deleted-id-2');
              expect(dto.hasMore, true);
              expect(dto.nextSyncToken?.token, 'next-token');
            },
          );

          test(
            'handles empty lists correctly',
            () {
              final result = HealthDataSyncResult.internal(
                upsertedRecords: const [],
                deletedRecordIds: const [],
                hasMore: false,
                nextSyncToken: null,
              );

              final dto = result.toDto();

              expect(dto.upsertedRecords, isEmpty);
              expect(dto.deletedRecordIds, isEmpty);
              expect(dto.hasMore, false);
              expect(dto.nextSyncToken, isNull);
            },
          );

          test(
            'throws ArgumentError when deletedRecordIds contains '
            'HealthRecordId.none',
            () {
              final result = HealthDataSyncResult.internal(
                upsertedRecords: const [],
                deletedRecordIds: [
                  HealthRecordId('valid-id'),
                  HealthRecordId.none,
                  HealthRecordId('another-valid-id'),
                ],
                hasMore: false,
                nextSyncToken: null,
              );

              expect(
                result.toDto,
                throwsA(
                  isA<ArgumentError>()
                      .having((e) => e.name, 'name', 'deletedRecordIds')
                      .having(
                        (e) => e.message,
                        'message',
                        contains(
                          '`HealthDataSyncResult.deletedRecordIds` list '
                          'cannot contain `HealthRecordId.none`.',
                        ),
                      ),
                ),
              );
            },
          );
        },
      );

      group(
        'HealthDataSyncResultFromDtoToDomain',
        () {
          test(
            'converts HealthDataSyncResultDto to HealthDataSyncResult',
            () {
              final now = DateTime.now().toUtc();
              final dto = HealthDataSyncResultDto(
                upsertedRecords: [
                  StepsRecordDto(
                    count: 5000,
                    id: 'record-123',
                    metadata: MetadataDto(
                      dataOrigin: FakeData.fakeDataOrigin,
                      recordingMethod: RecordingMethodDto.activelyRecorded,
                      clientRecordVersion: 1,
                      deviceType: DeviceTypeDto.phone,
                    ),
                    startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                    startZoneOffsetSeconds:
                        FakeData.fakeLocalStartTime.timeZoneOffset.inSeconds,
                    endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                    endZoneOffsetSeconds:
                        FakeData.fakeLocalEndTime.timeZoneOffset.inSeconds,
                  ),
                ],
                deletedRecordIds: ['deleted-id-1', 'deleted-id-2'],
                hasMore: true,
                nextSyncToken: HealthDataSyncTokenDto(
                  token: 'next-token',
                  dataTypes: [HealthDataTypeDto.steps],
                  createdAtMillis: now.millisecondsSinceEpoch,
                ),
              );

              final result = dto.toDomain();

              expect(result.upsertedRecords, hasLength(1));
              expect(result.upsertedRecords[0], isA<StepsRecord>());
              expect(result.deletedRecordIds, hasLength(2));
              expect(result.deletedRecordIds[0].value, 'deleted-id-1');
              expect(result.deletedRecordIds[1].value, 'deleted-id-2');
              expect(result.hasMore, true);
              expect(result.nextSyncToken?.token, 'next-token');
            },
          );
        },
      );
    },
  );
}
