import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('PaddleSportsDistanceRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 45));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validValue = Length.meters(3000);

    test('can be instantiated with valid parameters', () {
      final record = PaddleSportsDistanceRecord(
        startTime: startTime,
        endTime: endTime,
        distance: validValue,
        metadata: metadata,
      );

      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.distance, equals(validValue));
      expect(record.metadata, metadata);
    });

    test('copyWith updates fields correctly', () {
      final record = PaddleSportsDistanceRecord(
        startTime: startTime,
        endTime: endTime,
        distance: validValue,
        metadata: metadata,
      );

      const newDist = Length.meters(4000.0);
      final updated = record.copyWith(distance: newDist);

      expect(updated.distance, newDist);
    });
  });
}
