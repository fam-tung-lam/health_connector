import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sleep/sleep_stage_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'SleepStageMapper',
    () {
      group(
        'SleepStageDomainToDto',
        () {
          test(
            'converts SleepStage to SleepStageDto',
            () {
              final sleepStage = SleepStage(
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                stageType: SleepStageType.deep,
              );

              final dto = sleepStage.toDto();

              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(dto.stage, SleepStageTypeDto.deep);
            },
          );
        },
      );

      group(
        'SleepStageDtoToDomain',
        () {
          test(
            'converts SleepStageDto to SleepStage',
            () {
              final dto = SleepStageDto(
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                stage: SleepStageTypeDto.rem,
              );

              final sleepStage = dto.toDomain();

              expect(sleepStage.startTime, FakeData.fakeStartTime);
              expect(sleepStage.endTime, FakeData.fakeEndTime);
              expect(sleepStage.stageType, SleepStageType.rem);
            },
          );
        },
      );
    },
  );
}
