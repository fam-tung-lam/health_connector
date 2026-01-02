import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/time_duration_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
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
              const timeDuration = TimeDuration.seconds(3_600.0);
              final dto = timeDuration.toDto();

              expect(dto.value, 3_600.0);
              expect(dto.unit, TimeDurationUnitDto.seconds);
            },
          );

          test(
            'converts TimeDuration from hours to seconds',
            () {
              const timeDuration = TimeDuration.hours(1.0);
              final dto = timeDuration.toDto();

              expect(dto.unit, TimeDurationUnitDto.seconds);
              expect(dto.value, 3_600.0);
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
              [TimeDurationUnitDto.seconds, 3_600.0],
              [TimeDurationUnitDto.minutes, 60.0],
              [TimeDurationUnitDto.hours, 1.0],
            ],
            (TimeDurationUnitDto unit, double value) {
              final dto = TimeDurationDto(value: value, unit: unit);
              final timeDuration = dto.toDomain();

              switch (unit) {
                case TimeDurationUnitDto.seconds:
                  expect(timeDuration.inSeconds, value);
                case TimeDurationUnitDto.minutes:
                  expect(timeDuration.inMinutes, value);
                case TimeDurationUnitDto.hours:
                  expect(timeDuration.inHours, value);
              }
            },
          );
        },
      );
    },
  );
}
