import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('CervicalMucusRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const appearance = CervicalMucusAppearance.eggWhite;
    const sensation = CervicalMucusSensation.medium;

    test('can be instantiated with valid parameters', () {
      final record = CervicalMucusRecord(
        time: now,
        metadata: metadata,
        appearance: appearance,
        sensation: sensation,
      );

      expect(record.time, now);
      expect(record.metadata, metadata);
      expect(record.appearance, appearance);
      expect(record.sensation, sensation);
    });

    test('can be instantiated with default values', () {
      final record = CervicalMucusRecord(
        time: now,
        metadata: metadata,
      );

      expect(record.appearance, CervicalMucusAppearance.unknown);
      expect(record.sensation, CervicalMucusSensation.unknown);
    });

    test('copyWith updates fields correctly', () {
      final record = CervicalMucusRecord(
        time: now,
        metadata: metadata,
        appearance: appearance,
        sensation: sensation,
      );

      final newTime = now.subtract(const Duration(minutes: 10));
      const newAppearance = CervicalMucusAppearance.sticky;

      final updatedRecord = record.copyWith(
        time: newTime,
        appearance: newAppearance,
      );

      expect(updatedRecord.time, newTime);
      expect(updatedRecord.appearance, newAppearance);
      expect(updatedRecord.sensation, sensation); // Unchanged
    });

    test('equality works correctly', () {
      final record1 = CervicalMucusRecord(
        time: now,
        metadata: metadata,
        appearance: appearance,
        sensation: sensation,
      );

      final record2 = CervicalMucusRecord(
        time: now,
        metadata: metadata,
        appearance: appearance,
        sensation: sensation,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
