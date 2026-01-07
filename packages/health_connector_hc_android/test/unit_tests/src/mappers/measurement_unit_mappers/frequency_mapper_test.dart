import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/frequency_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'FrequencyMapper',
    () {
      group(
        'FrequencyToDto',
        () {
          test(
            'converts Frequency to FrequencyDto',
            () {
              final frequency = Frequency.perMinute(75);
              final dto = frequency.toDto();

              expect(dto.perMinute, 75);
            },
          );

          test(
            'converts Frequency created from perSecond to FrequencyDto',
            () {
              final frequency = Frequency.perSecond(2.0);
              final dto = frequency.toDto();

              expect(dto.perMinute, 120);
            },
          );

          test(
            'converts zero frequency to FrequencyDto',
            () {
              final dto = Frequency.zero.toDto();

              expect(dto.perMinute, 0);
            },
          );
        },
      );

      group(
        'FrequencyDtoToDomain',
        () {
          test(
            'converts FrequencyDto to Frequency',
            () {
              final dto = FrequencyDto(perMinute: 80);
              final frequency = dto.toDomain();

              expect(frequency.inPerMinute, 80);
            },
          );

          test(
            'converts FrequencyDto with decimal value to Frequency',
            () {
              final dto = FrequencyDto(perMinute: 65.5);
              final frequency = dto.toDomain();

              expect(frequency.inPerMinute, 65.5);
              expect(frequency.inPerSecond, closeTo(1.092, 0.001));
            },
          );

          test(
            'converts zero FrequencyDto to Frequency',
            () {
              final dto = FrequencyDto(perMinute: 0);
              final frequency = dto.toDomain();

              expect(frequency.inPerMinute, 0);
            },
          );
        },
      );
    },
  );
}
