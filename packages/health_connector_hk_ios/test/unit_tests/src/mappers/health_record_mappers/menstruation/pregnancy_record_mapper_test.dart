import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/pregnancy_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('PregnancyRecordMapper', () {
    group('toDto', () {
      test('converts PregnancyRecord to PregnancyRecordDto', () {
        final record = PregnancyRecord(
          id: HealthRecordId(FakeData.fakeId),
          startTime: FakeData.fakeStartTime,
          endTime: FakeData.fakeEndTime,
          startZoneOffsetSeconds:
              FakeData.fakeStartTime.timeZoneOffset.inSeconds,
          endZoneOffsetSeconds: FakeData.fakeEndTime.timeZoneOffset.inSeconds,
          metadata: Metadata.internal(
            dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
            recordingMethod: RecordingMethod.activelyRecorded,
            clientRecordVersion: 1,
            device: const Device(type: DeviceType.phone),
          ),
        );

        final dto = record.toDto();

        expect(dto.id, FakeData.fakeId);
        expect(
          dto.startTime,
          FakeData.fakeStartTime.millisecondsSinceEpoch,
        );
        expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
        expect(
          dto.startZoneOffsetSeconds,
          FakeData.fakeStartTime.timeZoneOffset.inSeconds,
        );
        expect(
          dto.endZoneOffsetSeconds,
          FakeData.fakeEndTime.timeZoneOffset.inSeconds,
        );
        expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
      });
    });

    group('toDomain', () {
      test('converts PregnancyRecordDto to PregnancyRecord', () {
        final dto = PregnancyRecordDto(
          id: FakeData.fakeId,
          startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
          endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
          startZoneOffsetSeconds: 0,
          endZoneOffsetSeconds: 0,
          metadata: MetadataDto(
            dataOrigin: FakeData.fakeDataOrigin,
            recordingMethod: RecordingMethodDto.manualEntry,
            clientRecordVersion: 1,
            deviceType: DeviceTypeDto.phone,
          ),
        );

        final record = dto.toDomain();

        expect(record.id.value, FakeData.fakeId);
        expect(record.startTime, FakeData.fakeStartTime);
        expect(record.endTime, FakeData.fakeEndTime);
        expect(
          record.metadata.dataOrigin?.packageName,
          FakeData.fakeDataOrigin,
        );
      });

      test(
        'converts PregnancyRecordDto with null id to domain with none id',
        () {
          final dto = PregnancyRecordDto(
            startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
            endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
            startZoneOffsetSeconds: 0,
            endZoneOffsetSeconds: 0,
            metadata: MetadataDto(
              dataOrigin: FakeData.fakeDataOrigin,
              recordingMethod: RecordingMethodDto.activelyRecorded,
              clientRecordVersion: 1,
              deviceType: DeviceTypeDto.watch,
            ),
          );

          final record = dto.toDomain();

          expect(record.id, HealthRecordId.none);
        },
      );
    });
  });
}
