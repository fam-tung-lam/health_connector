import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/skin_temperature_delta_sample_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'SkinTemperatureDeltaSampleMapper',
    () {
      group(
        'SkinTemperatureDeltaToDto',
        () {
          test(
            'converts SkinTemperatureDeltaSample to SkinTemperatureDeltaSampleDto',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();
              final sample = SkinTemperatureDeltaSample(
                time: time,
                temperatureDelta: const Temperature.celsius(0.5),
              );

              final dto = sample.toDto();

              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.temperatureDeltaCelsius, 0.5);
            },
          );
        },
      );

      group(
        'SkinTemperatureDeltaDtoToDomain',
        () {
          test(
            'converts SkinTemperatureDeltaSampleDto to SkinTemperatureDeltaSample',
            () {
              final time = DateTime(2025, 1, 15, 10).toUtc();
              final dto = SkinTemperatureDeltaSampleDto(
                time: time.millisecondsSinceEpoch,
                temperatureDeltaCelsius: -0.2,
              );

              final sample = dto.toDomain();

              expect(sample.time, time);
              expect(sample.temperatureDelta.inCelsius, -0.2);
            },
          );
        },
      );
    },
  );
}
