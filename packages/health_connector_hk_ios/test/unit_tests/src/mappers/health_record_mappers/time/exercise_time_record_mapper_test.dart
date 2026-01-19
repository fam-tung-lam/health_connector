import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/time/exercise_time_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'ExerciseTimeRecordMapper',
    () {
      group(
        'ExerciseTimeRecordDtoToDomain',
        () {
          test(
            'converts ExerciseTimeRecordDto to ExerciseTimeRecord',
            () {
              final dto = ExerciseTimeRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                seconds: 1800, // 30 minutes
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(record.exerciseTime.inMinutes, 30);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );
        },
      );
    },
  );
}
