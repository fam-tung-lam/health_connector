import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_sync_callback_dispatcher.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';
import 'package:health_connector_toolbox/src/features/console_logs/services/console_log_storage.dart';
import 'package:health_connector_toolbox/src/health_connector_toolbox_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Registers the background isolate entry point with the platform scheduler.
  await Workmanager().initialize(backgroundSyncCallbackDispatcher);

  final consoleLogStore = ConsoleLogStore(
    storage: SharedPreferencesConsoleLogStorage(SharedPreferencesAsync()),
    isolate: ConsoleLogIsolate.main,
  );

  runApp(HealthConnectorToolboxApp(consoleLogStore: consoleLogStore));
}
