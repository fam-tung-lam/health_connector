import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/alcoholic_beverages_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group('AlcoholicBeveragesRecordMapper', () {
    group('toDto', () {
      test(
        'converts AlcoholicBeveragesRecord to AlcoholicBeveragesRecordDto',
        () {
          final record = AlcoholicBeveragesRecord(
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
            count: const Number(3),
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
          expect(dto.count, 3.0);
        },
      );
    });

    group('toDomain', () {
      test(
        'converts AlcoholicBeveragesRecordDto to AlcoholicBeveragesRecord',
        () {
          final dto = AlcoholicBeveragesRecordDto(
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
            count: 2.5,
          );

          final record = dto.toDomain();

          expect(record.id.value, FakeData.fakeId);
          expect(record.startTime, FakeData.fakeStartTime);
          expect(record.endTime, FakeData.fakeEndTime);
          expect(
            record.metadata.dataOrigin?.packageName,
            FakeData.fakeDataOrigin,
          );
          expect(record.count.value, 2.5);
        },
      );

      test(
        'converts AlcoholicBeveragesRecordDto with null id to '
        'domain with none id',
        () {
          final dto = AlcoholicBeveragesRecordDto(
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
            count: 1.0,
          );

          final record = dto.toDomain();

          expect(record.id, HealthRecordId.none);
        },
      );
    });
  });
}
