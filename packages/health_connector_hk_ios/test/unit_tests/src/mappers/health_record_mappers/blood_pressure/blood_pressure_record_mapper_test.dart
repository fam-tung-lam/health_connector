import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'BloodPressureRecordMapper',
    () {
      group(
        'BloodPressureRecordToDto',
        () {
          test(
            'converts BloodPressureRecord to BloodPressureRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = BloodPressureRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                systolic: const Pressure.millimetersOfMercury(120.0),
                diastolic: const Pressure.millimetersOfMercury(80.0),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.systolicInMillimetersOfMercury, 120.0);
              expect(dto.diastolicInMillimetersOfMercury, 80.0);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'BloodPressureRecordDtoToDomain',
        () {
          test(
            'converts BloodPressureRecordDto to BloodPressureRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = BloodPressureRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                systolicInMillimetersOfMercury: 125.0,
                diastolicInMillimetersOfMercury: 85.0,
                measurementLocation: MeasurementLocationDto.unknown,
                bodyPosition: BodyPositionDto.unknown,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.systolic.inMillimetersOfMercury, 125.0);
              expect(record.diastolic.inMillimetersOfMercury, 85.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts BloodPressureRecordDto with null id to '
            'domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = BloodPressureRecordDto(
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                systolicInMillimetersOfMercury: 115.0,
                diastolicInMillimetersOfMercury: 75.0,
                measurementLocation: MeasurementLocationDto.unknown,
                bodyPosition: BodyPositionDto.unknown,
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
