import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/systolic_blood_pressure_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'SystolicBloodPressureRecordMapper',
    () {
      group(
        'SystolicBloodPressureRecordToDto',
        () {
          test(
            'converts SystolicBloodPressureRecord to '
            'SystolicBloodPressureRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = SystolicBloodPressureRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                pressure: const Pressure.millimetersOfMercury(120.0),
                bodyPosition: BloodPressureBodyPosition.sittingDown,
                measurementLocation: BloodPressureMeasurementLocation.leftWrist,
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.pressure.millimetersOfMercury, 120.0);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'SystolicBloodPressureRecordDtoToDomain',
        () {
          test(
            'converts SystolicBloodPressureRecordDto to '
            'SystolicBloodPressureRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = SystolicBloodPressureRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                pressure: PressureDto(millimetersOfMercury: 115.0),
                bodyPosition: BodyPositionDto.standingUp,
                measurementLocation: MeasurementLocationDto.rightUpperArm,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.pressure.inMillimetersOfMercury, 115.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts SystolicBloodPressureRecordDto with null id to '
            'domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = SystolicBloodPressureRecordDto(
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                pressure: PressureDto(millimetersOfMercury: 110.0),
                bodyPosition: BodyPositionDto.sittingDown,
                measurementLocation: MeasurementLocationDto.leftUpperArm,
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
