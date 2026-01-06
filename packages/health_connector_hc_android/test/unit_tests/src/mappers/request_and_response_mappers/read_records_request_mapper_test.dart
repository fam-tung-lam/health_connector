import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/read_records_request_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'ReadRecordsRequestMapper',
    () {
      group(
        'ReadRecordsRequestDtoMapper',
        () {
          test(
            'maps ReadRecordsInTimeRangeRequest to ReadRecordsRequestDto '
            'with all fields',
            () {
              final startTime = DateTime(2025);
              final endTime = DateTime(2025, 1, 31, 23, 59);
              final request = HealthDataType.steps.readInTimeRange(
                startTime: startTime,
                endTime: endTime,
                pageToken: 'page-token-123',
                dataOrigins: const [
                  DataOrigin('com.example.app1'),
                  DataOrigin('com.example.app2'),
                ],
              );

              final dto = request.toDto();

              expect(dto.dataType, HealthDataTypeDto.steps);
              expect(dto.startTime, startTime.millisecondsSinceEpoch);
              expect(dto.endTime, endTime.millisecondsSinceEpoch);
              expect(dto.pageSize, 100);
              expect(dto.pageToken, 'page-token-123');
              expect(dto.dataOriginPackageNames, hasLength(2));
              expect(dto.dataOriginPackageNames[0], 'com.example.app1');
              expect(dto.dataOriginPackageNames[1], 'com.example.app2');
            },
          );

          test(
            'maps ReadRecordsInTimeRangeRequest with null pageToken',
            () {
              final startTime = DateTime(2025, 6);
              final endTime = DateTime(2025, 6, 30);
              final request = HealthDataType.weight.readInTimeRange(
                startTime: startTime,
                endTime: endTime,
                pageSize: 50,
              );

              final dto = request.toDto();

              expect(dto.dataType, HealthDataTypeDto.weight);
              expect(dto.startTime, startTime.millisecondsSinceEpoch);
              expect(dto.endTime, endTime.millisecondsSinceEpoch);
              expect(dto.pageSize, 50);
              expect(dto.pageToken, null);
              expect(dto.dataOriginPackageNames, isEmpty);
            },
          );
        },
      );
    },
  );
}
