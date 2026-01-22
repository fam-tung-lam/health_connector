import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/heart_rate_recovery_one_minute_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'HeartRateRecoveryOneMinuteRecordMapper',
    () {
      group(
        'HeartRateRecoveryOneMinuteRecordDtoToDomain',
        () {
          test(
            'converts HeartRateRecoveryOneMinuteRecordDto to '
            'HeartRateRecoveryOneMinuteRecord',
            () {
              final startTime = FakeData.fakeTime;
              final endTime = FakeData.fakeTime.add(
                const Duration(minutes: 1), // It is 1 minute recovery
              );

              final dto = HeartRateRecoveryOneMinuteRecordDto(
                id: FakeData.fakeId,
                startTime: startTime.millisecondsSinceEpoch,
                endTime: endTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                heartRateCount: 18.0,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, startTime);
              expect(record.endTime, endTime);
              expect(record.heartRateCount.value, 18.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );
        },
      );

      group(
        'HeartRateRecoveryOneMinuteRecordToDto',
        () {
          test(
            'converts HeartRateRecoveryOneMinuteRecord to '
            'HeartRateRecoveryOneMinuteRecordDto',
            () {
              final startTime = FakeData.fakeTime;
              final endTime = FakeData.fakeTime.add(
                const Duration(minutes: 1),
              );

              final record = HeartRateRecoveryOneMinuteRecord.internal(
                id: HealthRecordId(FakeData.fakeId),
                startTime: startTime,
                endTime: endTime,
                heartRateCount: const Number(22.0),
                metadata: Metadata.internal(
                  recordingMethod: RecordingMethod.manualEntry,
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                ),
                startZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.startTime, startTime.millisecondsSinceEpoch);
              expect(dto.endTime, endTime.millisecondsSinceEpoch);
              expect(dto.heartRateCount, 22.0);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );
    },
  );
}
