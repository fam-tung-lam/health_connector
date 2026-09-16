import 'package:health_connector/health_connector_internal.dart'
    show HealthConnectorLogLevel;
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';
import 'package:health_connector_toolbox/src/features/console_logs/services/console_log_storage.dart';

/// In-memory [ConsoleLogStorage] double that records every write.
final class InMemoryConsoleLogStorage implements ConsoleLogStorage {
  final Map<ConsoleLogIsolate, List<ConsoleLogEntry>> lists = {};
  int writeCount = 0;

  @override
  Future<List<ConsoleLogEntry>> readAll() async {
    final entries = lists.values.expand((list) => list).toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return entries;
  }

  @override
  Future<void> write(
    ConsoleLogIsolate isolate,
    List<ConsoleLogEntry> entries,
  ) async {
    writeCount++;
    lists[isolate] = List.of(entries);
  }

  @override
  Future<void> clear() async {
    lists.clear();
  }
}

/// Builds a minimal entry for tests.
ConsoleLogEntry buildEntry({
  required String id,
  required DateTime timestamp,
  ConsoleLogIsolate isolate = ConsoleLogIsolate.main,
  HealthConnectorLogLevel level = HealthConnectorLogLevel.info,
  String message = 'message',
}) {
  return ConsoleLogEntry(
    id: id,
    timestamp: timestamp,
    level: level,
    tag: 'Tag',
    message: message,
    origin: ConsoleLogEntry.dartOrigin,
    isolate: isolate,
  );
}
