import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/cycling_pedaling_cadence/cycling_pedaling_cadence_sample_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'CyclingPedalingCadenceSampleMapper',
    () {
      group(
        'CyclingPedalingCadenceSampleToDto',
        () {
          test(
            'converts CyclingPedalingCadenceSample to '
            'CyclingPedalingCadenceSampleDto',
            () {
              final time = DateTime(2025, 1, 15, 10, 30).toUtc();

              final measurement = CyclingPedalingCadenceSample(
                time: time,
                cadence: Frequency.perMinute(90),
              );

              final dto = measurement.toDto();

              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.revolutionsPerMinute, 90);
            },
          );
        },
      );

      group(
        'CyclingPedalingCadenceSampleDtoToDomain',
        () {
          test(
            'converts CyclingPedalingCadenceSampleDto to '
            'CyclingPedalingCadenceSample',
            () {
              final time = DateTime(2025, 1, 15, 10, 30).toUtc();

              final dto = CyclingPedalingCadenceSampleDto(
                time: time.millisecondsSinceEpoch,
                revolutionsPerMinute: 85,
              );

              final measurement = dto.toDomain();

              expect(measurement.time, time);
              expect(measurement.cadence.inPerMinute, 85);
            },
          );
        },
      );
    },
  );
}
