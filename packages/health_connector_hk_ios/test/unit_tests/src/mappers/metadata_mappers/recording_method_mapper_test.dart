import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/recording_method_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'RecordingMethodMapper',
    () {
      group(
        'RecordingMethodDtoMapper',
        () {
          parameterizedTest(
            'maps RecordingMethod to RecordingMethodDto',
            [
              [RecordingMethod.unknown, RecordingMethodDto.unknown],
              [RecordingMethod.manualEntry, RecordingMethodDto.manualEntry],
              [
                RecordingMethod.automaticallyRecorded,
                RecordingMethodDto.automaticallyRecorded,
              ],
              [
                RecordingMethod.activelyRecorded,
                RecordingMethodDto.activelyRecorded,
              ],
            ],
            (RecordingMethod method, RecordingMethodDto expectedDto) {
              final dto = method.toDto();
              expect(dto, expectedDto);
            },
          );
        },
      );

      group(
        'RecordingMethodDtoToDomain',
        () {
          parameterizedTest(
            'maps RecordingMethodDto to RecordingMethod',
            [
              [RecordingMethodDto.unknown, RecordingMethod.unknown],
              [RecordingMethodDto.manualEntry, RecordingMethod.manualEntry],
              [
                RecordingMethodDto.automaticallyRecorded,
                RecordingMethod.automaticallyRecorded,
              ],
              [
                RecordingMethodDto.activelyRecorded,
                RecordingMethod.activelyRecorded,
              ],
            ],
            (RecordingMethodDto dto, RecordingMethod expectedMethod) {
              final method = dto.toDomain();
              expect(method, expectedMethod);
            },
          );
        },
      );
    },
  );
}
