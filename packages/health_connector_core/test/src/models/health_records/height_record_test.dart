import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('HeightRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validHeight = Length.meters(1.75);

    test('can be instantiated with valid parameters', () {
      final record = HeightRecord(
        time: now,
        height: validHeight,
        metadata: metadata,
      );

      expect(record.time, now);
      expect(record.height, equals(validHeight));
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when height is below minHeight', () {
      expect(
        () => HeightRecord(
          time: now,
          height: Length.zero,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when height is above maxHeight', () {
      expect(
        () => HeightRecord(
          time: now,
          height: const Length.meters(3.1), // Typically max is around 3m
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = HeightRecord(
        time: now,
        height: validHeight,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newHeight = Length.meters(1.80);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        height: newHeight,
        metadata: newMetadata,
      );

      expect(updated.time, newTime);
      expect(updated.height, newHeight);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = HeightRecord(
        time: now,
        height: validHeight,
        metadata: metadata,
      );

      final record2 = HeightRecord(
        time: now,
        height: validHeight,
        metadata: metadata,
      );

      final record3 = HeightRecord(
        time: now,
        height: const Length.meters(1.80),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
