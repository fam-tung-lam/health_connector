import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/heart_rate_variability_sdnn_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'HeartRateVariabilitySdnnRecordMapper',
    () {
      group(
        'HeartRateVariabilitySdnnRecordToDto',
        () {
          test(
            'converts HeartRateVariabilitySdnnRecord to '
            'HeartRateVariabilitySDNNRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = HeartRateVariabilitySDNNRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                heartRateVariabilitySDNN: const Number(45.0),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
              expect(dto.heartRateVariabilitySDNN.value, 45.0);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'HeartRateVariabilitySdnnRecordDtoToDomain',
        () {
          test(
            'converts HeartRateVariabilitySDNNRecordDto to '
            'HeartRateVariabilitySdnnRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = HeartRateVariabilitySDNNRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                heartRateVariabilitySDNN: NumberDto(
                  value: 52.0,
                ),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.heartRateVariabilitySDNN.value, 52.0);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts HeartRateVariabilitySDNNRecordDto with null id '
            'to domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = HeartRateVariabilitySDNNRecordDto(
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                heartRateVariabilitySDNN: NumberDto(
                  value: 48.0,
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
