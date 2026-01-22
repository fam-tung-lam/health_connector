import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('RunningGroundContactTimeRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(hours: 1));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validContactTime = TimeDuration.milliseconds(250.0);

    test('can be instantiated with valid parameters', () {
      final record = RunningGroundContactTimeRecord(
        startTime: startTime,
        endTime: endTime,
        groundContactTime: validContactTime,
        metadata: metadata,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.groundContactTime, equals(validContactTime));
      expect(record.metadata, metadata);
    });

    test(
      'throws ArgumentError when groundContactTime is below '
      'minGroundContactTime',
      () {
        expect(
          () => RunningGroundContactTimeRecord(
            startTime: startTime,
            endTime: endTime,
            groundContactTime: const TimeDuration.milliseconds(49.9),
            metadata: metadata,
          ),
          throwsArgumentError,
        );
      },
    );

    test(
      'throws ArgumentError when groundContactTime is above '
      'maxGroundContactTime',
      () {
        expect(
          () => RunningGroundContactTimeRecord(
            startTime: startTime,
            endTime: endTime,
            groundContactTime: const TimeDuration.milliseconds(500.1),
            metadata: metadata,
          ),
          throwsArgumentError,
        );
      },
    );

    test('copyWith updates all fields correctly', () {
      final record = RunningGroundContactTimeRecord(
        startTime: startTime,
        endTime: endTime,
        groundContactTime: validContactTime,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 10));
      const newContactTime = TimeDuration.milliseconds(300.0);
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        groundContactTime: newContactTime,
        metadata: newMetadata,
      );

      expect(updatedRecord.startTime, newStartTime);
      expect(updatedRecord.groundContactTime, newContactTime);
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.endTime, endTime); // Unchanged
    });

    test('equality works correctly', () {
      final record1 = RunningGroundContactTimeRecord(
        startTime: startTime,
        endTime: endTime,
        groundContactTime: validContactTime,
        metadata: metadata,
      );

      final record2 = RunningGroundContactTimeRecord(
        startTime: startTime,
        endTime: endTime,
        groundContactTime: validContactTime,
        metadata: metadata,
      );

      final record3 = RunningGroundContactTimeRecord(
        startTime: startTime,
        endTime: endTime,
        groundContactTime: const TimeDuration.milliseconds(260.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
