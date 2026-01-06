import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/delete_records_request_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'DeleteRecordsRequestMapper',
    () {
      group(
        'DeleteRecordsRequestDtoMapper',
        () {
          test(
            'maps DeleteRecordsByIdsRequest to DeleteRecordsByIdsRequestDto',
            () {
              final request = HealthDataType.steps.deleteByIds([
                HealthRecordId('record-1'),
                HealthRecordId('record-2'),
                HealthRecordId('record-3'),
              ]);

              final dto = request.toDto();

              expect(dto, isA<DeleteRecordsByIdsRequestDto>());
              final idsDto = dto as DeleteRecordsByIdsRequestDto;
              expect(idsDto.dataType, HealthDataTypeDto.steps);
              expect(idsDto.recordIds, hasLength(3));
              expect(idsDto.recordIds[0], 'record-1');
              expect(idsDto.recordIds[1], 'record-2');
              expect(idsDto.recordIds[2], 'record-3');
            },
          );

          test(
            'maps DeleteRecordsInTimeRangeRequest to '
            'DeleteRecordsByTimeRangeRequestDto',
            () {
              final startTime = DateTime(2025);
              final endTime = DateTime(2025, 1, 31, 23, 59);
              final request = HealthDataType.weight.deleteInTimeRange(
                startTime: startTime,
                endTime: endTime,
              );

              final dto = request.toDto();

              expect(dto, isA<DeleteRecordsByTimeRangeRequestDto>());
              final timeRangeDto = dto as DeleteRecordsByTimeRangeRequestDto;
              expect(timeRangeDto.dataType, HealthDataTypeDto.weight);
              expect(
                timeRangeDto.startTime,
                startTime.millisecondsSinceEpoch,
              );
              expect(timeRangeDto.endTime, endTime.millisecondsSinceEpoch);
            },
          );
        },
      );
    },
  );
}
