import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/heart_rate/heart_rate_sample_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'HeartRateSampleMapper',
    () {
      group(
        'HeartRateSampleToDto',
        () {
          test(
            'converts HeartRateSample to HeartRateSampleDto',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();
              final measurement = HeartRateSample(
                time: time,
                rate: Frequency.perMinute(75),
              );

              final dto = measurement.toDto();

              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.beatsPerMinute.perMinute, 75);
            },
          );
        },
      );

      group(
        'HeartRateSampleDtoToDomain',
        () {
          test(
            'converts HeartRateSampleDto to HeartRateSample',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();

              final dto = HeartRateSampleDto(
                time: time.millisecondsSinceEpoch,
                beatsPerMinute: FrequencyDto(perMinute: 80),
              );

              final measurement = dto.toDomain();

              expect(measurement.time, time);
              expect(measurement.rate.inPerMinute, 80);
            },
          );
        },
      );
    },
  );
}
