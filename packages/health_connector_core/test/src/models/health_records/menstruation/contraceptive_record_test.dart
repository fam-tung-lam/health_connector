import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ContraceptiveRecord', () {
    final now = DateTime(2026, 1, 11);
    final endTime = now.add(const Duration(days: 30));
    final metadata = Metadata.manualEntry();
    const type = ContraceptiveType.oral;

    test('can be instantiated with valid parameters', () {
      final record = ContraceptiveRecord(
        startTime: now,
        endTime: endTime,
        contraceptiveType: type,
        metadata: metadata,
      );

      expect(record.startTime, now.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.contraceptiveType, type);
      expect(record.metadata, metadata);
    });

    test('throws ArgumentError when endTime is before startTime', () {
      expect(
        () => ContraceptiveRecord(
          startTime: endTime,
          endTime: now,
          contraceptiveType: type,
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = ContraceptiveRecord(
        startTime: now,
        endTime: endTime,
        contraceptiveType: type,
        metadata: metadata,
      );

      final newStartTime = now.add(const Duration(days: 1));
      final newEndTime = endTime.add(const Duration(days: 1));
      const newType = ContraceptiveType.implant;
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
        contraceptiveType: newType,
        metadata: newMetadata,
      );

      expect(updated.startTime, newStartTime.toUtc());
      expect(updated.endTime, newEndTime.toUtc());
      expect(updated.contraceptiveType, newType);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = ContraceptiveRecord(
        startTime: now,
        endTime: endTime,
        contraceptiveType: type,
        metadata: metadata,
      );
      final record2 = ContraceptiveRecord(
        startTime: now,
        endTime: endTime,
        contraceptiveType: type,
        metadata: metadata,
      );

      expect(record1, equals(record2));

      final record3 = ContraceptiveRecord(
        startTime: now,
        endTime: endTime,
        contraceptiveType: ContraceptiveType.implant,
        metadata: metadata,
      );

      expect(record1, isNot(equals(record3)));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
