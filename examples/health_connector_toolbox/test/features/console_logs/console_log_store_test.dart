import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';

import 'utils/in_memory_console_log_storage.dart';

void main() {
  late InMemoryConsoleLogStorage storage;
  final base = DateTime(2026, 9, 16, 12);

  setUp(() {
    storage = InMemoryConsoleLogStorage();
  });

  test('add appends, notifies listeners and trims to maxEntries', () {
    // Given a store bounded to two entries.
    final store = ConsoleLogStore(
      storage: storage,
      isolate: ConsoleLogIsolate.main,
      maxEntries: 2,
    );
    var notifications = 0;
    store.addListener(() => notifications++);

    // When three entries are added.
    for (var i = 0; i < 3; i++) {
      store.add(
        buildEntry(
          id: 'id-$i',
          timestamp: base.add(Duration(seconds: i)),
        ),
      );
    }

    // Then the oldest entry is dropped and every add notified.
    expect(store.entries.map((entry) => entry.id), ['id-1', 'id-2']);
    expect(notifications, 3);
    store.dispose();
  });

  test('add persists own entries after the debounce delay', () {
    fakeAsync((async) {
      // Given a store with a 300 ms debounce.
      final store = ConsoleLogStore(
        storage: storage,
        isolate: ConsoleLogIsolate.background,
      );

      // When two entries arrive within the debounce window.
      store.add(
        buildEntry(
          id: 'a',
          timestamp: base,
          isolate: ConsoleLogIsolate.background,
        ),
      );
      async.elapse(const Duration(milliseconds: 100));
      store.add(
        buildEntry(
          id: 'b',
          timestamp: base.add(const Duration(seconds: 1)),
          isolate: ConsoleLogIsolate.background,
        ),
      );
      expect(storage.writeCount, 0);
      async.elapse(const Duration(milliseconds: 300));

      // Then a single write persisted both entries under the own isolate.
      expect(storage.writeCount, 1);
      expect(
        storage.lists[ConsoleLogIsolate.background]!.map((e) => e.id),
        ['a', 'b'],
      );
      store.dispose();
    });
  });

  test('flush writes immediately and keeps only maxPersistedEntries', () async {
    // Given a store that persists at most two own entries.
    final store = ConsoleLogStore(
      storage: storage,
      isolate: ConsoleLogIsolate.main,
      maxPersistedEntries: 2,
    );
    for (var i = 0; i < 3; i++) {
      store.add(
        buildEntry(
          id: 'id-$i',
          timestamp: base.add(Duration(seconds: i)),
        ),
      );
    }

    // When the store is flushed.
    await store.flush();

    // Then the newest two entries are persisted.
    expect(
      storage.lists[ConsoleLogIsolate.main]!.map((e) => e.id),
      ['id-1', 'id-2'],
    );
    store.dispose();
  });

  test(
    'reload merges persisted entries from other isolates in time order',
    () async {
      // Given entries persisted by the background isolate and a live entry.
      storage.lists[ConsoleLogIsolate.background] = [
        buildEntry(
          id: 'bg-1',
          timestamp: base.add(const Duration(seconds: 1)),
          isolate: ConsoleLogIsolate.background,
        ),
      ];
      final store = ConsoleLogStore(
        storage: storage,
        isolate: ConsoleLogIsolate.main,
      );
      store.add(buildEntry(id: 'main-0', timestamp: base));
      store.add(
        buildEntry(
          id: 'main-2',
          timestamp: base.add(const Duration(seconds: 2)),
        ),
      );
      var notifications = 0;
      store.addListener(() => notifications++);

      // When the store reloads twice.
      await store.reload();
      await store.reload();

      // Then entries are merged once, sorted by time, and listeners notified.
      expect(
        store.entries.map((entry) => entry.id),
        ['main-0', 'bg-1', 'main-2'],
      );
      expect(notifications, 2);
      store.dispose();
    },
  );

  test('clear empties memory and storage', () async {
    // Given a store with a live entry and persisted entries.
    storage.lists[ConsoleLogIsolate.background] = [
      buildEntry(
        id: 'bg',
        timestamp: base,
        isolate: ConsoleLogIsolate.background,
      ),
    ];
    final store = ConsoleLogStore(
      storage: storage,
      isolate: ConsoleLogIsolate.main,
    );
    store.add(buildEntry(id: 'main', timestamp: base));

    // When the store is cleared.
    await store.clear();

    // Then nothing remains anywhere.
    expect(store.entries, isEmpty);
    expect(storage.lists, isEmpty);
    store.dispose();
  });
}
