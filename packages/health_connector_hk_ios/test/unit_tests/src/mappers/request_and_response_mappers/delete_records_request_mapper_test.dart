import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/delete_records_request_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

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
              final request = DeleteRecordsByIdsRequest(
                dataType: HealthDataType.steps,
                recordIds: [
                  HealthRecordId('id-123'),
                  HealthRecordId('id-456'),
                ],
              );

              final dto = request.toDto();

              expect(dto, isA<DeleteRecordsByIdsRequestDto>());
              final idsDto = dto as DeleteRecordsByIdsRequestDto;
              expect(idsDto.dataType, HealthDataTypeDto.steps);
              expect(idsDto.recordIds, hasLength(2));
              expect(idsDto.recordIds[0], 'id-123');
              expect(idsDto.recordIds[1], 'id-456');
            },
          );

          test(
            'maps DeleteRecordsInTimeRangeRequest to '
            'DeleteRecordsByTimeRangeRequestDto',
            () {
              final request = DeleteRecordsInTimeRangeRequest(
                dataType: HealthDataType.weight,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              final dto = request.toDto();

              expect(dto, isA<DeleteRecordsByTimeRangeRequestDto>());
              final rangeDto = dto as DeleteRecordsByTimeRangeRequestDto;
              expect(rangeDto.dataType, HealthDataTypeDto.weight);
              expect(
                rangeDto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(
                rangeDto.endTime,
                FakeData.fakeEndTime.millisecondsSinceEpoch,
              );
            },
          );
        },
      );
    },
  );
}
