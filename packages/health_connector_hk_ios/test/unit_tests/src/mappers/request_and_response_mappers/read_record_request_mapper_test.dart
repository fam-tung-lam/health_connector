import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/read_record_request_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

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
              // Given
              final request = ReadRecordByIdRequest<StepsRecord>(
                dataType: HealthDataType.steps,
                id: HealthRecordId('test-id-123'),
              );

              // When
              final dto = request.toDto();

              // Then
              expect(dto.recordId, 'test-id-123');
              expect(dto.dataType, HealthDataTypeDto.steps);
            },
          );

          test(
            'maps ReadRecordByIdRequest with different data type',
            () {
              // Given
              final request = ReadRecordByIdRequest<WeightRecord>(
                dataType: HealthDataType.weight,
                id: HealthRecordId('weight-456'),
              );

              // When
              final dto = request.toDto();

              // Then
              expect(dto.recordId, 'weight-456');
              expect(dto.dataType, HealthDataTypeDto.weight);
            },
          );
        },
      );
    },
  );
}
