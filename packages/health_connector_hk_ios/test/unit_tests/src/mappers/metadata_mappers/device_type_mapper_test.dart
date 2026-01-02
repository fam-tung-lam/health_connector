import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/device_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

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
            (DeviceType deviceType, DeviceTypeDto expectedDto) {
              final dto = deviceType.toDto();
              expect(dto, expectedDto);
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
            (DeviceTypeDto dto, DeviceType expectedDeviceType) {
              final deviceType = dto.toDomain();
              expect(deviceType, expectedDeviceType);
            },
          );
        },
      );
    },
  );
}
