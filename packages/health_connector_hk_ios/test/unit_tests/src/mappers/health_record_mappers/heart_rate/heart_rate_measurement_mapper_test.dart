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
            'converts HeartRateMeasurement to HeartRateMeasurementDto',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();

              final measurement = HeartRateMeasurement(
                time: time,
                beatsPerMinute: const Number(72),
              );

              final dto = measurement.toDto();

              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.beatsPerMinute.value, 72);
            },
          );
        },
      );

      group(
        'HeartRateMeasurementDtoToDomain',
        () {
          test(
            'converts HeartRateMeasurementDto to HeartRateMeasurement',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();

              final dto = HeartRateMeasurementDto(
                time: time.millisecondsSinceEpoch,
                beatsPerMinute: NumberDto(value: 68.0),
              );

              final measurement = dto.toDomain();

              expect(measurement.time, time);
              expect(measurement.beatsPerMinute.value, 68.0);
            },
          );
        },
      );
    },
  );
}
