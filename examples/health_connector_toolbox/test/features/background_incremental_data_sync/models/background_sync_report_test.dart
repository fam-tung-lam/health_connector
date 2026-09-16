import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';

import '../utils/in_memory_background_sync_storage.dart';

void main() {
  final start = DateTime.utc(2026, 9, 16, 8);
  final end = DateTime.utc(2026, 9, 16, 9);

  test('BackgroundSyncReport round-trips through JSON', () {
    // Given a fully populated failed report.
    final report = BackgroundSyncReport(
      outcome: BackgroundSyncOutcome.failed,
      startedAt: start,
      finishedAt: end,
      dataTypeIds: const ['steps'],
      pageCount: 2,
      upsertedRecordCount: 1,
      deletedRecordCount: 1,
      tokenBefore: SyncTokenSnapshot.fromToken(
        buildToken(value: 'before', dataTypeIds: const ['steps']),
      ),
      tokenReset: true,
      error: const BackgroundSyncError(
        code: 'rateLimitExceeded',
        message: 'Too many requests',
        willRetry: true,
      ),
    );

    // When serialized and restored.
    final restored = BackgroundSyncReport.fromJson(report.toJson());

    // Then the restored report equals the original.
    expect(restored, report);
    expect(restored.duration, const Duration(hours: 1));
    expect(restored.tokenAfter, isNull);
  });

  test('counts default to zero when missing from JSON', () {
    // Given a stored report without count fields.
    final restored = BackgroundSyncReport.fromJson({
      'outcome': 'skipped',
      'startedAt': start.toIso8601String(),
      'finishedAt': end.toIso8601String(),
      'dataTypeIds': const <String>[],
    });

    // Then both counts are zero.
    expect(restored.upsertedRecordCount, 0);
    expect(restored.deletedRecordCount, 0);
  });

  test('outcome id falls back safely', () {
    expect(BackgroundSyncOutcome.fromId(null), BackgroundSyncOutcome.failed);
  });
}
