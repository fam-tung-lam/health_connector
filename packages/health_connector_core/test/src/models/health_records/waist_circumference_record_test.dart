import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WaistCircumferenceRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validCircumference = Length.centimeters(85.0);

    test('can be instantiated with valid parameters', () {
      final record = WaistCircumferenceRecord(
        time: now,
        circumference: validCircumference,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.circumference, validCircumference);
      expect(record.metadata, metadata);
    });

    test(
      'throws ArgumentError when circumference is below minCircumference',
      () {
        expect(
          () => WaistCircumferenceRecord(
            time: now,
            circumference: const Length.centimeters(19.9),
            metadata: metadata,
          ),
          throwsArgumentError,
        );
      },
    );

    test(
      'throws ArgumentError when circumference is above maxCircumference',
      () {
        expect(
          () => WaistCircumferenceRecord(
            time: now,
            circumference: const Length.centimeters(200.1),
            metadata: metadata,
          ),
          throwsArgumentError,
        );
      },
    );

    test('copyWith updates all fields correctly', () {
      final record = WaistCircumferenceRecord(
        time: now,
        circumference: validCircumference,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newCircumference = Length.centimeters(86.0);
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        circumference: newCircumference,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.circumference, newCircumference);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = WaistCircumferenceRecord(
        time: now,
        circumference: validCircumference,
        metadata: metadata,
      );

      final record2 = WaistCircumferenceRecord(
        time: now,
        circumference: validCircumference,
        metadata: metadata,
      );

      final record3 = WaistCircumferenceRecord(
        time: now,
        circumference: const Length.centimeters(85.1),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
