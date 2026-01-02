import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sleep_stage_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'SleepStageMapper',
    () {
      group(
        'SleepStageTypeDomainToDto',
        () {
          parameterizedTest(
            'converts SleepStageType to SleepStageTypeDto',
            [
              [SleepStageType.unknown, SleepStageTypeDto.unknown],
              [SleepStageType.awake, SleepStageTypeDto.awake],
              [SleepStageType.sleeping, SleepStageTypeDto.sleeping],
              [SleepStageType.outOfBed, SleepStageTypeDto.outOfBed],
              [SleepStageType.light, SleepStageTypeDto.light],
              [SleepStageType.deep, SleepStageTypeDto.deep],
              [SleepStageType.rem, SleepStageTypeDto.rem],
              [SleepStageType.inBed, SleepStageTypeDto.inBed],
            ],
            (SleepStageType domain, SleepStageTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'SleepStageTypeDtoToDomain',
        () {
          parameterizedTest(
            'converts SleepStageTypeDto to SleepStageType',
            [
              [SleepStageTypeDto.unknown, SleepStageType.unknown],
              [SleepStageTypeDto.awake, SleepStageType.awake],
              [SleepStageTypeDto.sleeping, SleepStageType.sleeping],
              [SleepStageTypeDto.outOfBed, SleepStageType.outOfBed],
              [SleepStageTypeDto.light, SleepStageType.light],
              [SleepStageTypeDto.deep, SleepStageType.deep],
              [SleepStageTypeDto.rem, SleepStageType.rem],
              [SleepStageTypeDto.inBed, SleepStageType.inBed],
            ],
            (SleepStageTypeDto dto, SleepStageType domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );

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
