import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/heart_rate_measurement_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group(
    'HeartRateMeasurementMapper',
    () {
      group(
        'HeartRateMeasurementToDto',
        () {
          test(
            'converts HeartRateSample to HeartRateMeasurementDto',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();

              final measurement = HeartRateSample(
                time: time,
                rate: Frequency.perMinute(72),
              );

              final dto = measurement.toDto();

              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.beatsPerMinute.perMinute, 72);
            },
          );
        },
      );

      group(
        'HeartRateMeasurementDtoToDomain',
        () {
          test(
            'converts HeartRateMeasurementDto to HeartRateSample',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();

              final dto = HeartRateMeasurementDto(
                time: time.millisecondsSinceEpoch,
                beatsPerMinute: FrequencyDto(perMinute: 68.0),
              );

              final measurement = dto.toDomain();

              expect(measurement.time, time);
              expect(measurement.rate.inPerMinute, 68.0);
            },
          );
        },
      );
    },
  );
}
