import 'package:health_connector/health_connector_internal.dart'
    show HealthConnectorLog, HealthConnectorLogProcessor;
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';

/// Log processor that forwards every SDK log event into a [ConsoleLogStore].
///
/// Register it through `HealthConnectorLoggerConfig.logProcessors` so Dart
/// logs and native logs relayed by the SDK end up in the same console.
final class ConsoleLogProcessor extends HealthConnectorLogProcessor {
  const ConsoleLogProcessor(this._store, {super.levels});

  final ConsoleLogStore _store;

  @override
  Future<void> process(HealthConnectorLog log) async {
    _store.add(
      ConsoleLogEntry.fromHealthConnectorLog(log, isolate: _store.isolate),
    );
  }
}
