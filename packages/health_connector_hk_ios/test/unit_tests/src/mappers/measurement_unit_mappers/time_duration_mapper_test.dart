import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/time_duration_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
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

              expect(dto.seconds, 3600.0);
            },
          );

          test(
            'converts TimeDuration from minutes to seconds',
            () {
              const duration = TimeDuration.minutes(60.0);
              final dto = duration.toDto();

              expect(dto.seconds, 3600.0);
            },
          );
        },
      );

      group(
        'TimeDurationDtoToDomain',
        () {
          test(
            'maps TimeDurationDto to TimeDuration',
            () {
              const value = 3600.0;
              final dto = TimeDurationDto(seconds: value);
              final duration = dto.toDomain();

              expect(duration.inSeconds, value);
            },
          );
        },
      );
    },
  );
}
