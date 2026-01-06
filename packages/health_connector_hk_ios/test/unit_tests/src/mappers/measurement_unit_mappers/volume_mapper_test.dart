import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/volume_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

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

              expect(dto.liters, 1.5);
            },
          );

          test(
            'converts Volume from milliliters to liters',
            () {
              const volume = Volume.milliliters(1500.0);
              final dto = volume.toDto();

              expect(dto.liters, 1.5);
            },
          );
        },
      );

      group(
        'VolumeDtoToDomain',
        () {
          test(
            'maps VolumeDto to Volume',
            () {
              const value = 1.5;
              final dto = VolumeDto(liters: value);
              final volume = dto.toDomain();

              expect(volume.inLiters, value);
            },
          );
        },
      );
    },
  );
}
