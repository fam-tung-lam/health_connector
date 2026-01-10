import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/heart_rate/heart_rate_variability_rmssd_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'HeartRateVariabilityRMSSDRecordMapper',
    () {
      group(
        'HeartRateVariabilityRMSSDRecordToDto',
        () {
          test(
            'converts HeartRateVariabilityRMSSDRecord to '
            'HeartRateVariabilityRMSSDRecordDto',
            () {
              final record = HeartRateVariabilityRMSSDRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                rmssd: const TimeDuration.milliseconds(
                  4500,
                ),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.heartRateVariabilityMillis, 4500);
            },
          );
        },
      );

      group(
        'HeartRateVariabilityRMSSDRecordDtoToDomain',
        () {
          test(
            'converts HeartRateVariabilityRMSSDRecordDto to '
            'HeartRateVariabilityRMSSDRecord',
            () {
              final dto = HeartRateVariabilityRMSSDRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                heartRateVariabilityMillis: 1000,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, FakeData.fakeTime);
              expect(
                record.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.rmssd, const TimeDuration.seconds(1));
            },
          );

          test(
            'converts HeartRateVariabilityRMSSDRecordDto with null id to '
            'domain with none id',
            () {
              final dto = HeartRateVariabilityRMSSDRecordDto(
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                heartRateVariabilityMillis: 0.040 / 1000,
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
