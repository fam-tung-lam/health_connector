import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/volume_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'VolumeMapper',
    () {
      group(
        'VolumeToDto',
        () {
          test(
            'converts Volume to VolumeDto in liters',
            () {
              const volume = Volume.liters(2.0);
              final dto = volume.toDto();

              expect(dto.value, 2.0);
              expect(dto.unit, VolumeUnitDto.liters);
            },
          );

          test(
            'converts Volume from milliliters to liters',
            () {
              const volume = Volume.milliliters(2000.0);
              final dto = volume.toDto();

              expect(dto.unit, VolumeUnitDto.liters);
              expect(dto.value, 2.0);
            },
          );
        },
      );

      group(
        'VolumeDtoToDomain',
        () {
          parameterizedTest(
            'maps VolumeDto to Volume',
            [
              [VolumeUnitDto.liters, 2.0],
              [VolumeUnitDto.milliliters, 2000.0],
              [VolumeUnitDto.fluidOuncesUs, 67.628],
            ],
            (VolumeUnitDto unit, double value) {
              final dto = VolumeDto(value: value, unit: unit);
              final volume = dto.toDomain();

              switch (unit) {
                case VolumeUnitDto.liters:
                  expect(volume.inLiters, value);
                case VolumeUnitDto.milliliters:
                  expect(volume.inMilliliters, value);
                case VolumeUnitDto.fluidOuncesUs:
                  expect(volume.inFluidOuncesUs, value);
              }
            },
          );
        },
      );
    },
  );
}
