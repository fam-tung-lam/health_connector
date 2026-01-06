import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/device_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'DeviceTypeMapper',
    () {
      group(
        'DeviceTypeDtoMapper',
        () {
          parameterizedTest(
            'maps DeviceType to DeviceTypeDto',
            [
              [DeviceType.unknown, DeviceTypeDto.unknown],
              [DeviceType.watch, DeviceTypeDto.watch],
              [DeviceType.phone, DeviceTypeDto.phone],
              [DeviceType.scale, DeviceTypeDto.scale],
              [DeviceType.ring, DeviceTypeDto.ring],
              [DeviceType.fitnessBand, DeviceTypeDto.fitnessBand],
              [DeviceType.chestStrap, DeviceTypeDto.chestStrap],
              [DeviceType.headMounted, DeviceTypeDto.headMounted],
              [DeviceType.smartDisplay, DeviceTypeDto.smartDisplay],
            ],
            (DeviceType domain, DeviceTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'DeviceTypeDtoToDomain',
        () {
          parameterizedTest(
            'maps DeviceTypeDto to DeviceType',
            [
              [DeviceTypeDto.unknown, DeviceType.unknown],
              [DeviceTypeDto.watch, DeviceType.watch],
              [DeviceTypeDto.phone, DeviceType.phone],
              [DeviceTypeDto.scale, DeviceType.scale],
              [DeviceTypeDto.ring, DeviceType.ring],
              [DeviceTypeDto.fitnessBand, DeviceType.fitnessBand],
              [DeviceTypeDto.chestStrap, DeviceType.chestStrap],
              [DeviceTypeDto.headMounted, DeviceType.headMounted],
              [DeviceTypeDto.smartDisplay, DeviceType.smartDisplay],
            ],
            (DeviceTypeDto dto, DeviceType domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
