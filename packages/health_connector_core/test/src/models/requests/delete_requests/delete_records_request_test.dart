import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/requests/delete_requests/delete_records_request.dart';
import 'package:test/test.dart';

void main() {
  group('DeleteRecordsInTimeRangeRequest', () {
    final now = DateTime(2026, 1, 18);
    final startTime = now.subtract(const Duration(days: 7));
    final endTime = now;

    test('can be instantiated with valid parameters', () {
      final request = DeleteRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: endTime,
      );

      expect(request.dataType, HealthDataType.steps);
      expect(request.startTime, startTime);
      expect(request.endTime, endTime);
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => DeleteRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: endTime,
          endTime: startTime,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when endTime equals startTime', () {
      expect(
        () => DeleteRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: startTime,
          endTime: startTime,
        ),
        throwsArgumentError,
      );
    });

    test('equality works correctly', () {
      final request1 = DeleteRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: endTime,
      );

      final request2 = DeleteRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: endTime,
      );

      final differentEndTime = endTime.add(const Duration(days: 1));
      final request3 = DeleteRecordsInTimeRangeRequest(
        dataType: HealthDataType.steps,
        startTime: startTime,
        endTime: differentEndTime,
      );

      expect(request1 == request2, isTrue);
      expect(request1 == request3, isFalse);
      expect(request1.hashCode == request2.hashCode, isTrue);
    });

    test('accepts deletable data type', () {
      // Steps is DeletableHealthDataType
      expect(
        () => DeleteRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: startTime,
          endTime: endTime,
        ),
        returnsNormally,
      );
    });
  });

  group('DeleteRecordsByIdsRequest', () {
    test('can be instantiated with valid parameters', () {
      final recordIds = [
        HealthRecordId('id-1'),
        HealthRecordId('id-2'),
        HealthRecordId('id-3'),
      ];

      final request = DeleteRecordsByIdsRequest(
        dataType: HealthDataType.steps,
        recordIds: recordIds,
      );

      expect(request.dataType, HealthDataType.steps);
      expect(request.recordIds, recordIds);
    });

    test('can be instantiated with single record ID', () {
      final recordIds = [HealthRecordId('single-id')];

      final request = DeleteRecordsByIdsRequest(
        dataType: HealthDataType.steps,
        recordIds: recordIds,
      );

      expect(request.recordIds, recordIds);
      expect(request.recordIds.length, 1);
    });

    test('throws ArgumentError when any recordId is HealthRecordId.none', () {
      final recordIds = [
        HealthRecordId('id-1'),
        HealthRecordId.none,
        HealthRecordId('id-3'),
      ];

      expect(
        () => DeleteRecordsByIdsRequest(
          dataType: HealthDataType.steps,
          recordIds: recordIds,
        ),
        throwsArgumentError,
      );
    });

    test(
      'throws ArgumentError when all recordIds are HealthRecordId.none',
      () {
        final recordIds = [
          HealthRecordId.none,
          HealthRecordId.none,
        ];

        expect(
          () => DeleteRecordsByIdsRequest(
            dataType: HealthDataType.steps,
            recordIds: recordIds,
          ),
          throwsArgumentError,
        );
      },
    );

    test(
      'throws ArgumentError when single recordId is HealthRecordId.none',
      () {
        final recordIds = [HealthRecordId.none];

        expect(
          () => DeleteRecordsByIdsRequest(
            dataType: HealthDataType.steps,
            recordIds: recordIds,
          ),
          throwsArgumentError,
        );
      },
    );

    test('equality works correctly', () {
      final recordIds1 = [
        HealthRecordId('id-1'),
        HealthRecordId('id-2'),
      ];

      final recordIds3 = [
        HealthRecordId('id-1'),
        HealthRecordId('id-3'),
      ];

      final request1 = DeleteRecordsByIdsRequest(
        dataType: HealthDataType.steps,
        recordIds: recordIds1,
      );

      final request2 = DeleteRecordsByIdsRequest(
        dataType: HealthDataType.steps,
        recordIds: recordIds1, // Use same list instance
      );

      final request3 = DeleteRecordsByIdsRequest(
        dataType: HealthDataType.steps,
        recordIds: recordIds3,
      );

      expect(request1 == request2, isTrue);
      expect(request1 == request3, isFalse);
    });

    test('accepts deletable data type', () {
      final recordIds = [HealthRecordId('id-1')];
      // Steps is DeletableHealthDataType
      expect(
        () => DeleteRecordsByIdsRequest(
          dataType: HealthDataType.steps,
          recordIds: recordIds,
        ),
        returnsNormally,
      );
    });
  });
}
