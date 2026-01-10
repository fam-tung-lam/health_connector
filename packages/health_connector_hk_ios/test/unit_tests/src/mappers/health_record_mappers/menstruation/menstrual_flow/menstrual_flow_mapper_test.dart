import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/menstrual_flow/menstrual_flow_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'MenstrualFlowTypeMapper',
    () {
      group(
        'MenstrualFlowToDto',
        () {
          parameterizedTest(
            'converts MenstrualFlowType to MenstrualFlowDto',
            [
              [MenstrualFlow.unknown, MenstrualFlowDto.unknown],
              [MenstrualFlow.light, MenstrualFlowDto.light],
              [MenstrualFlow.medium, MenstrualFlowDto.medium],
              [MenstrualFlow.heavy, MenstrualFlowDto.heavy],
            ],
            (MenstrualFlow domain, MenstrualFlowDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'MenstrualFlowDtoToDomain',
        () {
          parameterizedTest(
            'converts MenstrualFlowDto to MenstrualFlowType',
            [
              [MenstrualFlowDto.unknown, MenstrualFlow.unknown],
              [MenstrualFlowDto.light, MenstrualFlow.light],
              [MenstrualFlowDto.medium, MenstrualFlow.medium],
              [MenstrualFlowDto.heavy, MenstrualFlow.heavy],
            ],
            (MenstrualFlowDto dto, MenstrualFlow domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
