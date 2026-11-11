import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  test('GIVEN missing and zero values WHEN compared THEN remain distinct', () {
    // Given
    final start = DateTime(2026);
    final end = DateTime(2026, 1, 2);
    final missing = DailyAggregateResult<Volume>(
      startTime: start,
      endTime: end,
      value: null,
    );
    final zero = DailyAggregateResult<Volume>(
      startTime: start,
      endTime: end,
      value: Volume.zero,
    );
    // When / Then
    expect(missing, isNot(zero));
    expect(
      zero,
      DailyAggregateResult<Volume>(
        startTime: start,
        endTime: end,
        value: Volume.zero,
      ),
    );
    expect(
      zero.hashCode,
      DailyAggregateResult<Volume>(
        startTime: start,
        endTime: end,
        value: Volume.zero,
      ).hashCode,
    );
    expect(zero.toString(), 'DailyAggregateResult(hasValue=true)');
  });
}
