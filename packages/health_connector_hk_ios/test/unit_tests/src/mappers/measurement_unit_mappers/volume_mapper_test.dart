import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/volume_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
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
              const volume = Volume.liters(1.5);
              final dto = volume.toDto();

              expect(dto.value, 1.5);
              expect(dto.unit, VolumeUnitDto.liters);
            },
          );

          test(
            'converts Volume from milliliters to liters',
            () {
              const volume = Volume.milliliters(1500.0);
              final dto = volume.toDto();

              expect(dto.unit, VolumeUnitDto.liters);
              expect(dto.value, 1.5);
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
              [VolumeUnitDto.liters, 1.5],
              [VolumeUnitDto.milliliters, 1500.0],
              [VolumeUnitDto.fluidOuncesUs, 50.72],
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
                  expect(volume.inFluidOuncesUs, closeTo(value, 0.1));
              }
            },
          );
        },
      );
    },
  );
}
