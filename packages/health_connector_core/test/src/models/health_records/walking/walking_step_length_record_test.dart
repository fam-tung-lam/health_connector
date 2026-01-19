import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WalkingStepLengthRecord', () {
    final startTime = DateTime(2026, 1, 11, 10);
    final endTime = DateTime(2026, 1, 11, 10, 5);
    final metadata = Metadata.manualEntry();
    const validLength = Length.meters(0.75);

    test('equality works correctly', () {
      final record1 = WalkingStepLengthRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        length: validLength,
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.unknown,
      );

      final record2 = WalkingStepLengthRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        length: validLength,
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.unknown,
      );

      final record3 = WalkingStepLengthRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        length: const Length.meters(0.80),
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.unknown,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
