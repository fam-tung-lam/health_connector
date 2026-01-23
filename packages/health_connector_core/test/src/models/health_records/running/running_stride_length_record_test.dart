import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('RunningStrideLengthRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(hours: 1));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validStrideLength = Length.meters(1.2);

    test('can be instantiated with valid parameters', () {
      final record = RunningStrideLengthRecord(
        startTime: startTime,
        endTime: endTime,
        strideLength: validStrideLength,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.strideLength, equals(validStrideLength));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when strideLength is below minStrideLength', () {
      expect(
        () => RunningStrideLengthRecord(
          startTime: startTime,
          endTime: endTime,
          strideLength: const Length.meters(0.19),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when strideLength is above maxStrideLength', () {
      expect(
        () => RunningStrideLengthRecord(
          startTime: startTime,
          endTime: endTime,
          strideLength: const Length.meters(5.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = RunningStrideLengthRecord(
        startTime: startTime,
        endTime: endTime,
        strideLength: validStrideLength,
        metadata: metadata,
      );

      final newStartTime = startTime.subtract(const Duration(minutes: 10));
      const newStrideLength = Length.meters(1.5);
      final newMetadata = Metadata.manualEntry();

      final updatedRecord = record.copyWith(
        startTime: newStartTime,
        strideLength: newStrideLength,
        metadata: newMetadata,
      );

      expect(updatedRecord.startTime, newStartTime.toUtc());
      expect(updatedRecord.strideLength, newStrideLength);
      expect(updatedRecord.metadata, newMetadata);
      expect(updatedRecord.endTime, endTime.toUtc()); // Unchanged
    });

    test('equality works correctly', () {
      final record1 = RunningStrideLengthRecord(
        startTime: startTime,
        endTime: endTime,
        strideLength: validStrideLength,
        metadata: metadata,
      );

      final record2 = RunningStrideLengthRecord(
        startTime: startTime,
        endTime: endTime,
        strideLength: validStrideLength,
        metadata: metadata,
      );

      final record3 = RunningStrideLengthRecord(
        startTime: startTime,
        endTime: endTime,
        strideLength: const Length.meters(1.3),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
