import 'package:health_connector/health_connector_internal.dart'
    show
        HealthConnector,
        HealthConnectorErrorCode,
        HealthConnectorException,
        HealthConnectorLogger,
        HealthDataType,
        InvalidArgumentException;
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_storage.dart';

/// Creates the [HealthConnector] a sync run should use.
///
/// The background isolate creates a fresh connector; the UI reuses the one it
/// already holds.
typedef HealthConnectorFactory = Future<HealthConnector> Function();

/// Outcome of one [BackgroundSyncWorker.run].
final class BackgroundSyncRunResult {
  const BackgroundSyncRunResult({
    required this.report,
    required this.shouldRetry,
  });

  /// Report persisted for the toolbox UI.
  final BackgroundSyncReport report;

  /// Whether the scheduler should retry the task with backoff.
  ///
  /// True only for transient platform errors. Returning `false` from the
  /// Workmanager task handler maps to this flag.
  final bool shouldRetry;
}

/// Runs one incremental synchronization pass end to end.
///
/// The worker is platform-agnostic Dart so the same code path executes in the
/// headless background isolate and from the "Run now" button in the UI:
///
/// 1. Load the selected data types and the stored sync token.
/// 2. Discard the token when its data types no longer match the selection.
/// 3. Call `synchronize` until `hasMore` is false, collecting every change.
/// 4. On an expired token, start again from a new baseline once.
/// 5. Persist the new token and a [BackgroundSyncReport] of the run.
final class BackgroundSyncWorker {
  BackgroundSyncWorker({
    required HealthConnectorFactory createHealthConnector,
    required BackgroundSyncStorage storage,
    DateTime Function() clock = DateTime.now,
    this.maxPages = 50,
  }) : _createHealthConnector = createHealthConnector,
       _storage = storage,
       _clock = clock;

  static const String _tag = 'BackgroundSyncWorker';

  final HealthConnectorFactory _createHealthConnector;
  final BackgroundSyncStorage _storage;
  final DateTime Function() _clock;

  /// Safety cap on pagination so a misbehaving token cannot loop forever.
  final int maxPages;

  /// Error codes worth retrying with the scheduler's backoff policy.
  ///
  /// A locked iOS device reports `healthServiceDatabaseInaccessible`, and
  /// Health Connect reports `rateLimitExceeded` or `dataSyncInProgress` when
  /// it is busy. Permission and configuration errors need user action, so
  /// retrying them only wastes battery.
  static bool shouldRetryFor(HealthConnectorErrorCode code) {
    return switch (code) {
      HealthConnectorErrorCode.rateLimitExceeded ||
      HealthConnectorErrorCode.dataSyncInProgress ||
      HealthConnectorErrorCode.healthServiceDatabaseInaccessible ||
      HealthConnectorErrorCode.ioError ||
      HealthConnectorErrorCode.remoteError => true,
      _ => false,
    };
  }

  /// Executes one sync pass and returns the persisted report.
  ///
  /// No [Exception] escapes: every failure is captured in the report so the
  /// caller can map [BackgroundSyncRunResult.shouldRetry] to the scheduler's
  /// contract.
  Future<BackgroundSyncRunResult> run({
    required BackgroundSyncTrigger trigger,
  }) async {
    final startedAt = _clock();
    HealthConnectorLogger.info(
      _tag,
      operation: 'run',
      message: 'Background sync started',
      context: {'trigger': trigger.id},
    );

    var dataTypeIds = const <String>[];
    SyncTokenSnapshot? tokenBefore;
    var tokenReset = false;
    final upserted = <SyncedRecordSummary>[];
    final deleted = <String>[];
    var pageCount = 0;

    try {
      final settings = await _storage.loadSettings();
      final dataTypes = settings.dataTypes;
      dataTypeIds = settings.dataTypeIds;
      var token = await _storage.loadToken();
      tokenBefore = token == null ? null : SyncTokenSnapshot.fromToken(token);

      if (dataTypes.isEmpty) {
        HealthConnectorLogger.warning(
          _tag,
          operation: 'run',
          message: 'No data types selected, skipping background sync',
        );
        return await _finish(
          BackgroundSyncReport(
            trigger: trigger,
            outcome: BackgroundSyncOutcome.skipped,
            startedAt: startedAt,
            finishedAt: _clock(),
            dataTypeIds: dataTypeIds,
            tokenBefore: tokenBefore,
          ),
          shouldRetry: false,
        );
      }

      if (token != null && !_sameDataTypes(token.dataTypes, dataTypes)) {
        HealthConnectorLogger.warning(
          _tag,
          operation: 'run',
          message: 'Stored token covers different data types, starting over',
          context: {
            'token_data_types': token.dataTypes.map((t) => t.id).toList(),
            'selected_data_types': dataTypeIds,
          },
        );
        token = null;
        tokenReset = true;
      }

      final healthConnector = await _createHealthConnector();

      var hasMore = true;
      while (hasMore && pageCount < maxPages) {
        try {
          final result = await healthConnector.synchronize(
            dataTypes: dataTypes,
            syncToken: token,
          );
          pageCount++;
          upserted.addAll(
            result.upsertedRecords.map(SyncedRecordSummary.fromRecord),
          );
          deleted.addAll(result.deletedRecordIds.map((id) => id.value));
          token = result.nextSyncToken;
          hasMore = result.hasMore;
          HealthConnectorLogger.debug(
            _tag,
            operation: 'synchronize',
            message: 'Processed sync page',
            context: {
              'page': pageCount,
              'upserted': result.upsertedRecords.length,
              'deleted': result.deletedRecordIds.length,
              'has_more': result.hasMore,
            },
          );
        } on InvalidArgumentException catch (e) {
          if (token == null || tokenReset) {
            rethrow;
          }
          // The stored token expired (Android tokens expire after roughly 30
          // days). Start from a new baseline once; deletions in the gap are
          // lost, which the report flags through tokenReset.
          HealthConnectorLogger.warning(
            _tag,
            operation: 'synchronize',
            message: 'Sync token rejected, restarting from a new baseline',
            exception: e,
          );
          token = null;
          tokenReset = true;
        }
      }

      await _storage.saveToken(token);
      HealthConnectorLogger.info(
        _tag,
        operation: 'run',
        message: 'Background sync completed',
        context: {
          'pages': pageCount,
          'upserted': upserted.length,
          'deleted': deleted.length,
          'token_reset': tokenReset,
        },
      );

      return await _finish(
        BackgroundSyncReport(
          trigger: trigger,
          outcome: BackgroundSyncOutcome.succeeded,
          startedAt: startedAt,
          finishedAt: _clock(),
          dataTypeIds: dataTypeIds,
          pageCount: pageCount,
          upsertedRecords: upserted,
          deletedRecordIds: deleted,
          tokenBefore: tokenBefore,
          tokenAfter: token == null ? null : SyncTokenSnapshot.fromToken(token),
          tokenReset: tokenReset,
        ),
        shouldRetry: false,
      );
    } on HealthConnectorException catch (e, stackTrace) {
      final shouldRetry = shouldRetryFor(e.code);
      HealthConnectorLogger.error(
        _tag,
        operation: 'run',
        message: 'Background sync failed',
        context: {'error_code': e.code.name, 'will_retry': shouldRetry},
        exception: e,
        stackTrace: stackTrace,
      );
      return _finish(
        BackgroundSyncReport(
          trigger: trigger,
          outcome: BackgroundSyncOutcome.failed,
          startedAt: startedAt,
          finishedAt: _clock(),
          dataTypeIds: dataTypeIds,
          pageCount: pageCount,
          upsertedRecords: upserted,
          deletedRecordIds: deleted,
          tokenBefore: tokenBefore,
          tokenReset: tokenReset,
          error: BackgroundSyncError.fromException(e, willRetry: shouldRetry),
        ),
        shouldRetry: shouldRetry,
      );
    } on Exception catch (e, stackTrace) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'run',
        message: 'Background sync failed unexpectedly',
        exception: e,
        stackTrace: stackTrace,
      );
      return _finish(
        BackgroundSyncReport(
          trigger: trigger,
          outcome: BackgroundSyncOutcome.failed,
          startedAt: startedAt,
          finishedAt: _clock(),
          dataTypeIds: dataTypeIds,
          pageCount: pageCount,
          upsertedRecords: upserted,
          deletedRecordIds: deleted,
          tokenBefore: tokenBefore,
          tokenReset: tokenReset,
          error: BackgroundSyncError(
            code: e.runtimeType.toString(),
            message: e.toString(),
            willRetry: false,
          ),
        ),
        shouldRetry: false,
      );
    }
  }

  Future<BackgroundSyncRunResult> _finish(
    BackgroundSyncReport report, {
    required bool shouldRetry,
  }) async {
    await _storage.saveReport(report);
    return BackgroundSyncRunResult(report: report, shouldRetry: shouldRetry);
  }

  static bool _sameDataTypes(
    List<HealthDataType> tokenTypes,
    List<HealthDataType> selected,
  ) {
    final tokenIds = tokenTypes.map((type) => type.id).toSet();
    final selectedIds = selected.map((type) => type.id).toSet();
    return tokenIds.length == selectedIds.length &&
        tokenIds.containsAll(selectedIds);
  }
}
