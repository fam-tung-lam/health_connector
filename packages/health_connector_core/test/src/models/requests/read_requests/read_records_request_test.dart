import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/config/health_connector_config_constants.dart';
import 'package:health_connector_core/src/models/requests/read_requests/read_records_request.dart';
import 'package:test/test.dart';

void main() {
  group('ReadRecordsInTimeRangeRequest', () {
    final now = DateTime(2026, 1, 18);
    final startTime = now.subtract(const Duration(days: 7));
    final endTime = now;

    test('can be instantiated with valid parameters', () {
      final request = ReadRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: endTime,
      );

      expect(request.dataType, HealthDataType.steps);
      expect(request.startTime, startTime);
      expect(request.endTime, endTime);
      expect(request.pageSize, HealthConnectorConfigConstants.defaultPageSize);
      expect(request.pageToken, isNull);
      expect(request.dataOrigins, isEmpty);
      expect(request.sortDescriptor, SortDescriptor.timeDescending);
    });

    test('can be instantiated with all optional parameters', () {
      final dataOrigins = [const DataOrigin('com.example.app')];
      const pageSize = 50;
      const pageToken = 'test-token';

      final request = ReadRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: endTime,
        pageSize: pageSize,
        pageToken: pageToken,
        dataOrigins: dataOrigins,
        sortDescriptor: SortDescriptor.timeAscending,
      );

      expect(request.pageSize, pageSize);
      expect(request.pageToken, pageToken);
      expect(request.dataOrigins, dataOrigins);
      expect(request.sortDescriptor, SortDescriptor.timeAscending);
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => ReadRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: endTime,
          endTime: startTime,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when endTime equals startTime', () {
      expect(
        () => ReadRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: startTime,
          endTime: startTime,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when pageSize is 0', () {
      expect(
        () => ReadRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: startTime,
          endTime: endTime,
          pageSize: 0,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when pageSize is negative', () {
      expect(
        () => ReadRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: startTime,
          endTime: endTime,
          pageSize: -1,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when pageSize exceeds maximum', () {
      expect(
        () => ReadRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: startTime,
          endTime: endTime,
          pageSize: HealthConnectorConfigConstants.maxPageSize + 1,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates pageToken and sortDescriptor', () {
      final request = ReadRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: endTime,
      );

      final updated = request.copyWith(
        pageToken: 'new-token',
        sortDescriptor: SortDescriptor.timeAscending,
      );

      expect(updated.pageToken, 'new-token');
      expect(updated.sortDescriptor, SortDescriptor.timeAscending);
      expect(updated.dataType, request.dataType);
      expect(updated.startTime, request.startTime);
      expect(updated.endTime, request.endTime);
    });

    test('equality works correctly', () {
      final request1 = ReadRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: endTime,
      );

      final request2 = ReadRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: endTime,
      );

      final request3 = ReadRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: endTime,
        pageSize: 50,
      );

      expect(request1 == request2, isTrue);
      expect(request1 == request3, isFalse);
      expect(request1.hashCode == request2.hashCode, isTrue);
    });

    test('accepts readable data type', () {
      // Steps is ReadableHealthDataType
      expect(
        () => ReadRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: startTime,
          endTime: endTime,
        ),
        returnsNormally,
      );
    });
  });

  group('ReadRecordByIdRequest', () {
    test('can be instantiated with valid parameters', () {
      final id = HealthRecordId('test-id');
      final request = ReadRecordByIdRequest(
        dataType: HealthDataType.steps,
        id: id,
      );

      expect(request.dataType, HealthDataType.steps);
      expect(request.id, id);
    });

    test('throws ArgumentError when id is HealthRecordId.none', () {
      expect(
        () => ReadRecordByIdRequest(
          dataType: HealthDataType.steps,
          id: HealthRecordId.none,
        ),
        throwsArgumentError,
      );
    });

    test('equality works correctly', () {
      final id = HealthRecordId('test-id');
      final request1 = ReadRecordByIdRequest(
        dataType: HealthDataType.steps,
        id: id,
      );

      final request2 = ReadRecordByIdRequest(
        dataType: HealthDataType.steps,
        id: id,
      );

      final request3 = ReadRecordByIdRequest(
        dataType: HealthDataType.steps,
        id: HealthRecordId('different-id'),
      );

      expect(request1 == request2, isTrue);
      expect(request1 == request3, isFalse);
      expect(request1.hashCode == request2.hashCode, isTrue);
    });

    test('accepts readable data type', () {
      final id = HealthRecordId('test-id');
      // Steps is ReadableHealthDataType
      expect(
        () => ReadRecordByIdRequest(
          dataType: HealthDataType.steps,
          id: id,
        ),
        returnsNormally,
      );
    });
  });
}
