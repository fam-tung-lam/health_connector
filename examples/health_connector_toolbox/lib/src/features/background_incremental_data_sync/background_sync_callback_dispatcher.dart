import 'package:health_connector/health_connector_internal.dart'
    show
        DeveloperLogProcessor,
        HealthConnector,
        HealthConnectorConfig,
        HealthConnectorLogger,
        HealthConnectorLoggerConfig;
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_sync_worker.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_scheduler.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_storage.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_processor.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';
import 'package:health_connector_toolbox/src/features/console_logs/services/console_log_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

/// Entry point of the headless background isolate started by the scheduler.
///
/// The function must stay top-level and keep the `vm:entry-point` pragma so
/// the platform can look it up by callback handle when the app is not
/// running. It runs in a separate isolate: nothing created in `main()` exists
/// here, so the console log store, storage, and connector are rebuilt.
@pragma('vm:entry-point')
void backgroundSyncCallbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName != WorkmanagerBackgroundSyncScheduler.taskIdentifier) {
      // Unknown work is reported as done so the scheduler drops it.
      return true;
    }

    final preferences = SharedPreferencesAsync();
    final consoleLogStore = ConsoleLogStore(
      storage: SharedPreferencesConsoleLogStorage(preferences),
      isolate: ConsoleLogIsolate.background,
    );
    // Persisting replaces this isolate's stored list, so load the entries of
    // earlier background runs first or each run would erase the previous one.
    await consoleLogStore.reload();
    // Register the processors before the connector exists so the task
    // lifecycle logs below are captured as well.
    final processors = [
      const DeveloperLogProcessor(),
      ConsoleLogProcessor(consoleLogStore),
    ];
    processors.forEach(HealthConnectorLogger.addProcessor);

    HealthConnectorLogger.info(
      _tag,
      operation: 'executeTask',
      message: 'Background task started',
      context: {'task_name': taskName},
    );

    final worker = BackgroundSyncWorker(
      createHealthConnector: () => HealthConnector.create(
        const HealthConnectorConfig(
          loggerConfig: HealthConnectorLoggerConfig(enableNativeLogging: true),
        ),
      ),
      storage: SharedPreferencesBackgroundSyncStorage(preferences),
    );

    try {
      final result = await worker.run();
      HealthConnectorLogger.info(
        _tag,
        operation: 'executeTask',
        message: 'Background task finished',
        context: {
          'outcome': result.report.outcome.id,
          'should_retry': result.shouldRetry,
        },
      );
      // Returning false asks Android WorkManager to retry with backoff. iOS
      // has no automatic retry; the next periodic run picks the work up.
      return !result.shouldRetry;
    } finally {
      // The isolate is torn down right after the task completes, so the
      // debounced write must be forced before returning.
      await consoleLogStore.flush();
      processors.forEach(HealthConnectorLogger.removeProcessor);
    }
  });
}

const String _tag = 'BackgroundSyncCallbackDispatcher';
