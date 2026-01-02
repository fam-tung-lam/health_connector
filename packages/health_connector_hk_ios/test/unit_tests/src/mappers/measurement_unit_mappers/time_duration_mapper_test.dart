import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/time_duration_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'TimeDurationMapper',
    () {
      group(
        'TimeDurationToDto',
        () {
          test(
            'converts TimeDuration to TimeDurationDto in seconds',
            () {
              const duration = TimeDuration.seconds(3600.0);
              final dto = duration.toDto();

              expect(dto.value, 3600.0);
              expect(dto.unit, TimeDurationUnitDto.seconds);
            },
          );

          test(
            'converts TimeDuration from minutes to seconds',
            () {
              const duration = TimeDuration.minutes(60.0);
              final dto = duration.toDto();

              expect(dto.unit, TimeDurationUnitDto.seconds);
              expect(dto.value, 3600.0);
            },
          );
        },
      );

      group(
        'TimeDurationDtoToDomain',
        () {
          parameterizedTest(
            'maps TimeDurationDto to TimeDuration',
            [
              [TimeDurationUnitDto.seconds, 3600.0],
              [TimeDurationUnitDto.minutes, 60.0],
              [TimeDurationUnitDto.hours, 1.0],
            ],
            (TimeDurationUnitDto unit, double value) {
              final dto = TimeDurationDto(value: value, unit: unit);
              final duration = dto.toDomain();

              switch (unit) {
                case TimeDurationUnitDto.seconds:
                  expect(duration.inSeconds, value);
                case TimeDurationUnitDto.minutes:
                  expect(duration.inMinutes, value);
                case TimeDurationUnitDto.hours:
                  expect(duration.inHours, value);
              }
            },
          );
        },
      );
    },
  );
}
