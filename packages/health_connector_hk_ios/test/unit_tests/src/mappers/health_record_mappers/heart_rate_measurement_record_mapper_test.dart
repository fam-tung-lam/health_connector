import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate_measurement_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'HeartRateMeasurementRecordMapper',
    () {
      group(
        'HeartRateMeasurementRecordToDto',
        () {
          test(
            'converts HeartRateMeasurementRecord to '
            'HeartRateMeasurementRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = HeartRateMeasurementRecord(
                id: HealthRecordId(FakeData.fakeId),
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                measurement: HeartRateMeasurement(
                  time: time,
                  beatsPerMinute: const Number(72.0),
                ),
              );

              final dto = record.toDto();

              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.measurement.beatsPerMinute.value, 72.0);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'HeartRateMeasurementRecordDtoToDomain',
        () {
          test(
            'converts HeartRateMeasurementRecordDto to '
            'HeartRateMeasurementRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = HeartRateMeasurementRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                measurement: HeartRateMeasurementDto(
                  time: time.millisecondsSinceEpoch,
                  beatsPerMinute: NumberDto(value: 68.0),
                ),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.measurement.time, time);
              expect(record.measurement.beatsPerMinute.value, 68.0);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts HeartRateMeasurementRecordDto with null id to '
            'domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = HeartRateMeasurementRecordDto(
                time: time.millisecondsSinceEpoch,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                measurement: HeartRateMeasurementDto(
                  time: time.millisecondsSinceEpoch,
                  beatsPerMinute: NumberDto(value: 75.0),
                ),
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
