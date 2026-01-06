import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_pressure/blood_pressure_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

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
              // Given
              final record = BloodPressureRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
                ),
                systolic: const Pressure.millimetersOfMercury(120),
                diastolic: const Pressure.millimetersOfMercury(80),
                bodyPosition: BloodPressureBodyPosition.sittingDown,
                measurementLocation:
                    BloodPressureMeasurementLocation.leftUpperArm,
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.id, FakeData.fakeId);
              expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.systolic.millimetersOfMercury, 120);
              expect(dto.diastolic.millimetersOfMercury, 80);
              expect(dto.bodyPosition, BodyPositionDto.sittingDown);
              expect(
                dto.measurementLocation,
                MeasurementLocationDto.leftUpperArm,
              );
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
              // Given
              final dto = BloodPressureRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                systolic: PressureDto(millimetersOfMercury: 130),
                diastolic: PressureDto(millimetersOfMercury: 85),
                bodyPosition: BodyPositionDto.standingUp,
                measurementLocation: MeasurementLocationDto.rightWrist,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id.value, FakeData.fakeId);
              expect(record.time, FakeData.fakeTime);
              expect(
                record.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.systolic.inMillimetersOfMercury, 130);
              expect(record.diastolic.inMillimetersOfMercury, 85);
              expect(record.bodyPosition, BloodPressureBodyPosition.standingUp);
              expect(
                record.measurementLocation,
                BloodPressureMeasurementLocation.rightWrist,
              );
            },
          );

          test(
            'converts BloodPressureRecordDto with null id to '
            'domain with none id',
            () {
              // Given
              final dto = BloodPressureRecordDto(
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                systolic: PressureDto(millimetersOfMercury: 115),
                diastolic: PressureDto(millimetersOfMercury: 75),
                bodyPosition: BodyPositionDto.unknown,
                measurementLocation: MeasurementLocationDto.unknown,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id, HealthRecordId.none);
            },
          );
        },
      );
    },
  );
}
