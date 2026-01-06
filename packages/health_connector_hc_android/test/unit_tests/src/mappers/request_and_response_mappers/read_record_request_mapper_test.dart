import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/read_record_request_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'ReadRecordRequestMapper',
    () {
      group(
        'ReadRecordRequestDtoMapper',
        () {
          test(
            'maps ReadRecordByIdRequest to ReadRecordRequestDto',
            () {
              final recordId = HealthRecordId('record-123');
              final request = HealthDataType.steps.readById(recordId);

              final dto = request.toDto();

              expect(dto.recordId, 'record-123');
              expect(dto.dataType, HealthDataTypeDto.steps);
            },
          );

          test(
            'maps ReadRecordByIdRequest with different data type',
            () {
              final recordId = HealthRecordId('weight-456');
              final request = HealthDataType.weight.readById(recordId);

              final dto = request.toDto();

              expect(dto.recordId, 'weight-456');
              expect(dto.dataType, HealthDataTypeDto.weight);
            },
          );
        },
      );
    },
  );
}
