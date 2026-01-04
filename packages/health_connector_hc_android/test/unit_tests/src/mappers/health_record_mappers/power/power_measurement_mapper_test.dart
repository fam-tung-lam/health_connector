import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/power/power_measurement_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  final fakeSampleTime = FakeData.fakeTime.add(const Duration(minutes: 30));

  group(
    'PowerMeasurementMapper',
    () {
      group(
        'PowerMeasurementToDto',
        () {
          test(
            'converts PowerMeasurement to PowerMeasurementDto',
            () {
              // Given
              final measurement = PowerMeasurement(
                time: fakeSampleTime,
                power: const Power.watts(200),
              );

              // When
              final dto = measurement.toDto();

              // Then
              expect(dto.time, fakeSampleTime.millisecondsSinceEpoch);
              expect(dto.power.watts, 200);
            },
          );
        },
      );

      group(
        'PowerMeasurementDtoToDomain',
        () {
          test(
            'converts PowerMeasurementDto to PowerMeasurement',
            () {
              // Given
              final dto = PowerMeasurementDto(
                time: fakeSampleTime.millisecondsSinceEpoch,
                power: PowerDto(watts: 200),
              );

              // When
              final measurement = dto.toDomain();

              // Then
              expect(measurement.time, fakeSampleTime);
              expect(measurement.power.inWatts, 200);
            },
          );
        },
      );
    },
  );
}
