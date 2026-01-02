import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/active_calories_burned_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'ActiveCaloriesBurnedRecordMapper',
    () {
      group(
        'ActiveCaloriesBurnedRecordToDto',
        () {
          test(
            'converts ActiveCaloriesBurnedRecord to '
            'ActiveCaloriesBurnedRecordDto',
            () {
              // When
              final record = ActiveCaloriesBurnedRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
                ),
                energy: const Energy.kilocalories(250.5),
              );

              // Then
              final dto = record.toDto();

              // Should
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
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(
                dto.metadata.recordingMethod,
                RecordingMethodDto.activelyRecorded,
              );
              expect(dto.energy.value, 250.5);
              expect(dto.energy.unit, EnergyUnitDto.kilocalories);
            },
          );
        },
      );

      group(
        'ActiveCaloriesBurnedRecordDtoToDomain',
        () {
          test(
            'converts ActiveCaloriesBurnedRecordDto to '
            'ActiveCaloriesBurnedRecord',
            () {
              // When
              final dto = ActiveCaloriesBurnedRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 2,
                  deviceType: DeviceTypeDto.watch,
                ),
                energy: EnergyDto(
                  value: 300.0,
                  unit: EnergyUnitDto.kilocalories,
                ),
              );

              // Then
              final record = dto.toDomain();

              // Should
              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.startZoneOffsetSeconds,
                FakeData.fakeStartTimeZoneOffsetSeconds,
              );
              expect(
                record.endZoneOffsetSeconds,
                FakeData.fakeEndTimeZoneOffsetSeconds,
              );
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(
                record.metadata.recordingMethod,
                RecordingMethod.manualEntry,
              );
              expect(record.energy.inKilocalories, 300.0);
            },
          );

          test(
            'converts ActiveCaloriesBurnedRecordDto with null id to '
            'domain with none id',
            () {
              // When
              final dto = ActiveCaloriesBurnedRecordDto(
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                energy: EnergyDto(
                  value: 150.0,
                  unit: EnergyUnitDto.kilocalories,
                ),
              );

              // Then
              final record = dto.toDomain();

              // Should
              expect(record.id, HealthRecordId.none);
            },
          );
        },
      );
    },
  );
}
