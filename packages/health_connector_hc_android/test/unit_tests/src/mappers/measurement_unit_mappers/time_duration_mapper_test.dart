import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/time_duration_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

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

              expect(dto.seconds, 3_600.0);
            },
          );

          test(
            'converts TimeDuration from hours to seconds',
            () {
              const timeDuration = TimeDuration.hours(1.0);
              final dto = timeDuration.toDto();

              expect(dto.seconds, 3_600.0);
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
              final dto = TimeDurationDto(seconds: 3_600.0);
              final timeDuration = dto.toDomain();

              expect(timeDuration.inSeconds, 3_600.0);
            },
          );
        },
      );
    },
  );
}
