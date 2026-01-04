import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/volume_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

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

              expect(dto.liters, 2.0);
            },
          );

          test(
            'converts Volume from milliliters to liters',
            () {
              const volume = Volume.milliliters(2000.0);
              final dto = volume.toDto();

              expect(dto.liters, 2.0);
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
              final dto = VolumeDto(liters: 2.0);
              final volume = dto.toDomain();

              expect(volume.inLiters, 2.0);
            },
          );
        },
      );
    },
  );
}
