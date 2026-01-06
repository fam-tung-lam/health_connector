import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/mindfulness/mindfulness_session_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'MindfulnessSessionTypeMapper',
    () {
      group(
        'MindfulnessSessionTypeToDto',
        () {
          parameterizedTest(
            'converts MindfulnessSessionType to MindfulnessSessionTypeDto',
            [
              [
                MindfulnessSessionType.unknown,
                MindfulnessSessionTypeDto.unknown,
              ],
              [
                MindfulnessSessionType.meditation,
                MindfulnessSessionTypeDto.meditation,
              ],
              [
                MindfulnessSessionType.breathing,
                MindfulnessSessionTypeDto.breathing,
              ],
            ],
            (MindfulnessSessionType domain, MindfulnessSessionTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'MindfulnessSessionTypeDtoToDomain',
        () {
          parameterizedTest(
            'converts MindfulnessSessionTypeDto to MindfulnessSessionType',
            [
              [
                MindfulnessSessionTypeDto.unknown,
                MindfulnessSessionType.unknown,
              ],
              [
                MindfulnessSessionTypeDto.meditation,
                MindfulnessSessionType.meditation,
              ],
              [
                MindfulnessSessionTypeDto.breathing,
                MindfulnessSessionType.breathing,
              ],
            ],
            (MindfulnessSessionTypeDto dto, MindfulnessSessionType domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
