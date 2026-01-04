import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/length_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import 'package:test/test.dart';

void main() {
  group(
    'LengthMapper',
    () {
      group(
        'LengthToDto',
        () {
          test(
            'converts Length to LengthDto in meters',
            () {
              const length = Length.meters(1000.0);
              final dto = length.toDto();

              expect(dto.meters, 1000.0);
            },
          );

          test(
            'converts Length from kilometers to meters',
            () {
              const length = Length.kilometers(1.0);
              final dto = length.toDto();

              expect(dto.meters, 1000.0);
            },
          );
        },
      );

      group(
        'LengthDtoToDomain',
        () {
          test(
            'maps LengthDto to Length',
            () {
              final dto = LengthDto(meters: 1000.0);
              final length = dto.toDomain();

              expect(length.inMeters, 1000.0);
            },
          );
        },
      );
    },
  );
}
