import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/speed/speed_measurement_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

void main() {
  group(
    'SpeedMeasurementMapper',
    () {
      group(
        'SpeedMeasurementToDto',
        () {
          // Should
          test(
            'converts SpeedMeasurement to SpeedMeasurementDto',
            () {
              // Given
              final time = DateTime(2025, 1, 15, 10).toUtc();
              final measurement = SpeedMeasurement(
                time: time,
                speed: const Velocity.metersPerSecond(2.5),
              );

              // When
              final dto = measurement.toDto();

              // Then
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.speed.metersPerSecond, 2.5);
            },
          );
        },
      );

      group(
        'SpeedMeasurementDtoToDomain',
        () {
          // Should
          test(
            'converts SpeedMeasurementDto to SpeedMeasurement',
            () {
              // Given
              final time = DateTime(2025, 1, 15, 10).toUtc();
              final dto = SpeedMeasurementDto(
                time: time.millisecondsSinceEpoch,
                speed: VelocityDto(metersPerSecond: 3.0),
              );

              // When
              final measurement = dto.toDomain();

              // Then
              expect(measurement.time, time);
              expect(measurement.speed.inMetersPerSecond, 3.0);
            },
          );
        },
      );
    },
  );
}
