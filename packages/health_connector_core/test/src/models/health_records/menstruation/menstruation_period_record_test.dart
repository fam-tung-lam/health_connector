import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('MenstruationPeriodRecord', () {
    final startTime = DateTime(2026);
    final endTime = DateTime(2026, 1, 5);
    final metadata = Metadata.manualEntry();

    test('can be instantiated with valid parameters', () {
      final record = MenstruationPeriodRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
      );

      expect(record.startTime, startTime.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.metadata, metadata);
    });

    test('can be instantiated with maximum duration', () {
      final maxEndTime = startTime.add(MenstruationPeriodRecord.maxDuration);
      final record = MenstruationPeriodRecord(
        startTime: startTime,
        endTime: maxEndTime,
        metadata: metadata,
      );

      expect(record.duration, MenstruationPeriodRecord.maxDuration);
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => MenstruationPeriodRecord(
          startTime: endTime,
          endTime: startTime,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when duration exceeds maxDuration', () {
      final invalidEndTime = startTime
          .add(MenstruationPeriodRecord.maxDuration)
          .add(
            const Duration(seconds: 1),
          );

      expect(
        () => MenstruationPeriodRecord(
          startTime: startTime,
          endTime: invalidEndTime,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = MenstruationPeriodRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
      );

      final newStartTime = startTime.add(const Duration(days: 1));
      final newEndTime = endTime.add(const Duration(days: 1));
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = MenstruationPeriodRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
      );

      final record2 = MenstruationPeriodRecord(
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
      );

      final record3 = MenstruationPeriodRecord(
        startTime: startTime,
        endTime: endTime.add(const Duration(days: 1)),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
