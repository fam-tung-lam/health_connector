import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/mindfulness_session_type_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

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
              [
                MindfulnessSessionType.music,
                MindfulnessSessionTypeDto.music,
              ],
              [
                MindfulnessSessionType.movement,
                MindfulnessSessionTypeDto.movement,
              ],
              [
                MindfulnessSessionType.unguided,
                MindfulnessSessionTypeDto.unguided,
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
              [
                MindfulnessSessionTypeDto.music,
                MindfulnessSessionType.music,
              ],
              [
                MindfulnessSessionTypeDto.movement,
                MindfulnessSessionType.movement,
              ],
              [
                MindfulnessSessionTypeDto.unguided,
                MindfulnessSessionType.unguided,
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
