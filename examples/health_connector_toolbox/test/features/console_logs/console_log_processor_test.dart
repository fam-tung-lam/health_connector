import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthConnectorDartLog, HealthConnectorLogLevel;
import 'package:health_connector_toolbox/src/features/console_logs/console_log_processor.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';

import 'utils/in_memory_console_log_storage.dart';

void main() {
  test('process adds an entry tagged with the store isolate', () async {
    // Given a processor bound to a background-isolate store.
    final store = ConsoleLogStore(
      storage: InMemoryConsoleLogStorage(),
      isolate: ConsoleLogIsolate.background,
    );
    final processor = ConsoleLogProcessor(store);
    final log = HealthConnectorDartLog(
      level: HealthConnectorLogLevel.info,
      tag: 'Worker',
      dateTime: DateTime(2026, 9, 16),
      message: 'Task started',
    );

    // When the SDK log is processed.
    expect(processor.shouldProcess(log), isTrue);
    await processor.process(log);

    // Then the store holds the converted entry.
    expect(store.entries, hasLength(1));
    expect(store.entries.single.isolate, ConsoleLogIsolate.background);
    expect(store.entries.single.message, 'Task started');
    store.dispose();
  });

  test('levels filter limits which logs are processed', () {
    // Given a processor restricted to errors.
    final store = ConsoleLogStore(
      storage: InMemoryConsoleLogStorage(),
      isolate: ConsoleLogIsolate.main,
    );
    final processor = ConsoleLogProcessor(
      store,
      levels: const [HealthConnectorLogLevel.error],
    );
    final debugLog = HealthConnectorDartLog(
      level: HealthConnectorLogLevel.debug,
      tag: 'Tag',
      dateTime: DateTime(2026, 9, 16),
      message: 'noise',
    );

    // When a debug log is offered.
    // Then it is rejected by the level filter.
    expect(processor.shouldProcess(debugLog), isFalse);
    store.dispose();
  });
}
