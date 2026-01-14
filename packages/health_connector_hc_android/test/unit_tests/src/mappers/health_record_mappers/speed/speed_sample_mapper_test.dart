import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/speed/speed_sample_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'SpeedSampleMapper',
    () {
      group(
        'SpeedSampleToDto',
        () {
          // Should
          test(
            'converts SpeedSample to SpeedSampleDto',
            () {
              // Given
              final time = DateTime(2025, 1, 15, 10).toUtc();
              final measurement = SpeedSample(
                time: time,
                speed: const Velocity.metersPerSecond(2.5),
              );

              // When
              final dto = measurement.toDto();

              // Then
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.metersPerSecond, 2.5);
            },
          );
        },
      );

      group(
        'SpeedSampleDtoToDomain',
        () {
          // Should
          test(
            'converts SpeedSampleDto to SpeedSample',
            () {
              // Given
              final time = DateTime(2025, 1, 15, 10).toUtc();
              final dto = SpeedSampleDto(
                time: time.millisecondsSinceEpoch,
                metersPerSecond: 3.0,
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
