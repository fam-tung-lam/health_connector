import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/progesterone_test_result/progesterone_test_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../../utils/fake_data.dart';

void main() {
  group('ProgesteroneTestRecordMapper', () {
    group('toDto', () {
      test('converts ProgesteroneTestRecord to ProgesteroneTestRecordDto', () {
        final record = ProgesteroneTestRecord(
          id: HealthRecordId(FakeData.fakeId),
          time: FakeData.fakeStartTime,
          zoneOffsetSeconds: FakeData.fakeStartTime.timeZoneOffset.inSeconds,
          metadata: Metadata.internal(
            dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
            recordingMethod: RecordingMethod.activelyRecorded,
            clientRecordVersion: 1,
            device: const Device(type: DeviceType.phone),
          ),
          result: ProgesteroneTestResult.positive,
        );

        final dto = record.toDto();

        expect(dto.id, FakeData.fakeId);
        expect(
          dto.time,
          FakeData.fakeStartTime.millisecondsSinceEpoch,
        );
        expect(
          dto.zoneOffsetSeconds,
          FakeData.fakeStartTime.timeZoneOffset.inSeconds,
        );
        expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
        expect(dto.result, ProgesteroneTestResultDto.positive);
      });
    });

    group('toDomain', () {
      test('converts ProgesteroneTestRecordDto to ProgesteroneTestRecord', () {
        final dto = ProgesteroneTestRecordDto(
          id: FakeData.fakeId,
          time: FakeData.fakeStartTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: 0,
          metadata: MetadataDto(
            dataOrigin: FakeData.fakeDataOrigin,
            recordingMethod: RecordingMethodDto.manualEntry,
            clientRecordVersion: 1,
            deviceType: DeviceTypeDto.phone,
          ),
          result: ProgesteroneTestResultDto.negative,
        );

        final record = dto.toDomain();

        expect(record.id.value, FakeData.fakeId);
        expect(record.time, FakeData.fakeStartTime);
        expect(
          record.metadata.dataOrigin?.packageName,
          FakeData.fakeDataOrigin,
        );
        expect(record.result, ProgesteroneTestResult.negative);
      });

      test(
        'converts ProgesteroneTestRecordDto with null id to '
        'domain with none id',
        () {
          final dto = ProgesteroneTestRecordDto(
            time: FakeData.fakeStartTime.millisecondsSinceEpoch,
            zoneOffsetSeconds: 0,
            metadata: MetadataDto(
              dataOrigin: FakeData.fakeDataOrigin,
              recordingMethod: RecordingMethodDto.activelyRecorded,
              clientRecordVersion: 1,
              deviceType: DeviceTypeDto.watch,
            ),
            result: ProgesteroneTestResultDto.inconclusive,
          );

          final record = dto.toDomain();

          expect(record.id, HealthRecordId.none);
          expect(record.result, ProgesteroneTestResult.inconclusive);
        },
      );
    });
  });
}
