import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WalkingAsymmetryPercentageRecord', () {
    final startTime = DateTime(2026, 1, 11, 10);
    final endTime = DateTime(2026, 1, 11, 10, 5);
    final metadata = Metadata.manualEntry();
    const validPercentage = Percentage.fromWhole(5.2);

    test('equality works correctly', () {
      final record1 = WalkingAsymmetryPercentageRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: validPercentage,
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.unknown,
      );

      final record2 = WalkingAsymmetryPercentageRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: validPercentage,
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.unknown,
      );

      final record3 = WalkingAsymmetryPercentageRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: const Percentage.fromWhole(6.0),
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.unknown,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
