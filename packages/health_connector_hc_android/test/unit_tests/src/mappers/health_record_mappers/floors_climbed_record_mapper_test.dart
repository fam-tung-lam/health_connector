import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/floors_climbed_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'FloorsClimbedRecordMapper',
    () {
      group(
        'FloorsClimbedRecordToDto',
        () {
          test(
            'converts FloorsClimbedRecord to FloorsClimbedRecordDto',
            () {
              final record = FloorsClimbedRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                count: const Number(15),
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
              expect(dto.floors.value, 15);
            },
          );
        },
      );

      group(
        'FloorsClimbedRecordDtoToDomain',
        () {
          test(
            'converts FloorsClimbedRecordDto to FloorsClimbedRecord',
            () {
              final dto = FloorsClimbedRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                floors: NumberDto(value: 20),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.startZoneOffsetSeconds,
                FakeData.fakeStartTime.timeZoneOffset.inSeconds,
              );
              expect(
                record.endZoneOffsetSeconds,
                FakeData.fakeEndTime.timeZoneOffset.inSeconds,
              );
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.count.value, 20);
            },
          );

          test(
            'converts FloorsClimbedRecordDto with null id to '
            'domain with none id',
            () {
              final dto = FloorsClimbedRecordDto(
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                floors: NumberDto(value: 10),
              );

              final record = dto.toDomain();

              expect(record.id, HealthRecordId.none);
            },
          );
        },
      );
    },
  );
}
