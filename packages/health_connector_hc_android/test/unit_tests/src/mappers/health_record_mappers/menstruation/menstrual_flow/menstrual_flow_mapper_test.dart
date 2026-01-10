import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/menstrual_flow/menstrual_flow_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'MenstrualFlowMapper',
    () {
      group(
        'MenstrualFlowToDto',
        () {
          parameterizedTest(
            'converts MenstrualFlow to MenstrualFlowDto',
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
            'converts MenstrualFlowDto to MenstrualFlow',
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
