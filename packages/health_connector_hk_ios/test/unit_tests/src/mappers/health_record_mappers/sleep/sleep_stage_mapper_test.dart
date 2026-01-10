import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/sleep/sleep_stage_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'SleepStageMapper',
    () {
      group(
        'SleepStageDomainToDto',
        () {
          parameterizedTest(
            'converts SleepStageType to SleepStageDto',
            [
              [SleepStage.unknown, SleepStageDto.unknown],
              [SleepStage.awake, SleepStageDto.awake],
              [SleepStage.sleeping, SleepStageDto.sleeping],
              [SleepStage.outOfBed, SleepStageDto.outOfBed],
              [SleepStage.light, SleepStageDto.light],
              [SleepStage.deep, SleepStageDto.deep],
              [SleepStage.rem, SleepStageDto.rem],
              [SleepStage.inBed, SleepStageDto.inBed],
            ],
            (SleepStage domain, SleepStageDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'SleepStageDtoToDomain',
        () {
          parameterizedTest(
            'converts SleepStageDto to SleepStageType',
            [
              [SleepStageDto.unknown, SleepStage.unknown],
              [SleepStageDto.awake, SleepStage.awake],
              [SleepStageDto.sleeping, SleepStage.sleeping],
              [SleepStageDto.outOfBed, SleepStage.outOfBed],
              [SleepStageDto.light, SleepStage.light],
              [SleepStageDto.deep, SleepStage.deep],
              [SleepStageDto.rem, SleepStage.rem],
              [SleepStageDto.inBed, SleepStage.inBed],
            ],
            (SleepStageDto dto, SleepStage domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
