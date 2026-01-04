import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/energy_burned/total_calories_burned_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'TotalCaloriesBurnedRecordMapper',
    () {
      group(
        'TotalCaloriesBurnedRecordToDto',
        () {
          test(
            'converts TotalCaloriesBurnedRecord to '
            'TotalCaloriesBurnedRecordDto',
            () {
              final record = TotalCaloriesBurnedRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                energy: const Energy.kilocalories(2100.0),
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
                FakeData.fakeStartTimeZoneOffsetSeconds,
              );
              expect(
                dto.endZoneOffsetSeconds,
                FakeData.fakeEndTimeZoneOffsetSeconds,
              );
              expect(dto.energy.kilocalories, 2100.0);
            },
          );
        },
      );

      group(
        'TotalCaloriesBurnedRecordDtoToDomain',
        () {
          test(
            'converts TotalCaloriesBurnedRecordDto to '
            'TotalCaloriesBurnedRecord',
            () {
              final dto = TotalCaloriesBurnedRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                energy: EnergyDto(kilocalories: 1800.0),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(record.energy.inKilocalories, 1800.0);
            },
          );

          test(
            'converts TotalCaloriesBurnedRecordDto with null id to '
            'domain with none id',
            () {
              final dto = TotalCaloriesBurnedRecordDto(
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
                energy: EnergyDto(kilocalories: 2000.0),
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
