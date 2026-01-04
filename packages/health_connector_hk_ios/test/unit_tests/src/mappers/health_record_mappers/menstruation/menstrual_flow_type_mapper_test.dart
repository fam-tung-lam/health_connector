import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/menstrual_flow_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'MenstrualFlowTypeMapper',
    () {
      group(
        'MenstrualFlowTypeToDto',
        () {
          parameterizedTest(
            'converts MenstrualFlowType to MenstrualFlowTypeDto',
            [
              [MenstrualFlowType.unknown, MenstrualFlowTypeDto.unknown],
              [MenstrualFlowType.light, MenstrualFlowTypeDto.light],
              [MenstrualFlowType.medium, MenstrualFlowTypeDto.medium],
              [MenstrualFlowType.heavy, MenstrualFlowTypeDto.heavy],
            ],
            (MenstrualFlowType domain, MenstrualFlowTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'MenstrualFlowTypeDtoToDomain',
        () {
          parameterizedTest(
            'converts MenstrualFlowTypeDto to MenstrualFlowType',
            [
              [MenstrualFlowTypeDto.unknown, MenstrualFlowType.unknown],
              [MenstrualFlowTypeDto.light, MenstrualFlowType.light],
              [MenstrualFlowTypeDto.medium, MenstrualFlowType.medium],
              [MenstrualFlowTypeDto.heavy, MenstrualFlowType.heavy],
            ],
            (MenstrualFlowTypeDto dto, MenstrualFlowType domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
