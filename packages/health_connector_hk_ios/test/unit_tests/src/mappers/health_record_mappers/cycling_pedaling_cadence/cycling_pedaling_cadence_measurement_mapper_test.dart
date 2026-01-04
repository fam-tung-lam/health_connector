import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/cycling_pedaling_cadence/cycling_pedaling_cadence_measurement_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

void main() {
  group(
    'CyclingPedalingCadenceMeasurementMapper',
    () {
      group(
        'CyclingPedalingCadenceMeasurementToDto',
        () {
          test(
            'converts CyclingPedalingCadenceMeasurement to '
            'CyclingPedalingCadenceMeasurementDto',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();

              final measurement = CyclingPedalingCadenceMeasurement(
                time: time,
                revolutionsPerMinute: const Number(90.5),
              );

              final dto = measurement.toDto();

              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.revolutionsPerMinute.value, 90.5);
            },
          );
        },
      );

      group(
        'CyclingPedalingCadenceMeasurementDtoToDomain',
        () {
          test(
            'converts CyclingPedalingCadenceMeasurementDto to '
            'CyclingPedalingCadenceMeasurement',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();

              final dto = CyclingPedalingCadenceMeasurementDto(
                time: time.millisecondsSinceEpoch,
                revolutionsPerMinute: NumberDto(value: 85.0),
              );

              final measurement = dto.toDomain();

              expect(measurement.time, time);
              expect(measurement.revolutionsPerMinute.value, 85.0);
            },
          );
        },
      );
    },
  );
}
