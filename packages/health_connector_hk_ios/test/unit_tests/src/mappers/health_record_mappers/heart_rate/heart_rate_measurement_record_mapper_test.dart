import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/heart_rate_measurement_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

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
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                time: time,
                beatsPerMinute: Frequency.perMinute(72.0),
              );

              final dto = record.toDto();

              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.beatsPerMinute.perMinute, 72.0);
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
                beatsPerMinute: FrequencyDto(perMinute: 68.0),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.beatsPerMinute.inPerMinute, 68.0);
              expect(
                record.metadata.dataOrigin?.packageName,
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
                beatsPerMinute: FrequencyDto(perMinute: 75.0),
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
