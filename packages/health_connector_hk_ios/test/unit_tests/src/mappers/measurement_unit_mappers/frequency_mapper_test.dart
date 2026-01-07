import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/frequency_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

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
              final frequency = Frequency.perMinute(72);
              final dto = frequency.toDto();

              expect(dto.perMinute, 72);
            },
          );

          test(
            'converts Frequency created from perSecond to FrequencyDto',
            () {
              final frequency = Frequency.perSecond(1.5);
              final dto = frequency.toDto();

              expect(dto.perMinute, 90);
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
              final dto = FrequencyDto(perMinute: 68.0);
              final frequency = dto.toDomain();

              expect(frequency.inPerMinute, 68.0);
            },
          );

          test(
            'converts FrequencyDto with decimal value to Frequency',
            () {
              final dto = FrequencyDto(perMinute: 72.5);
              final frequency = dto.toDomain();

              expect(frequency.inPerMinute, 72.5);
              expect(frequency.inPerSecond, closeTo(1.208, 0.001));
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
