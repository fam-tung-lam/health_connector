import 'dart:convert';

import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists console log entries so logs captured in the background isolate
/// survive until the UI reads them.
///
/// Each [ConsoleLogIsolate] owns one list. An isolate only ever writes its
/// own list, so the main and background isolates cannot clobber each other.
abstract interface class ConsoleLogStorage {
  /// Reads the entries persisted by every isolate, oldest first.
  Future<List<ConsoleLogEntry>> readAll();

  /// Replaces the persisted entries owned by [isolate].
  Future<void> write(ConsoleLogIsolate isolate, List<ConsoleLogEntry> entries);

  /// Removes the persisted entries of every isolate.
  Future<void> clear();
}

/// [ConsoleLogStorage] backed by [SharedPreferencesAsync].
///
/// The async API has no per-isolate cache, so a value written by the
/// background isolate is visible to the next read from the main isolate.
final class SharedPreferencesConsoleLogStorage implements ConsoleLogStorage {
  const SharedPreferencesConsoleLogStorage(this._preferences);

  final SharedPreferencesAsync _preferences;

  static const String _keyPrefix = 'toolbox_console_logs.';

  static String _keyFor(ConsoleLogIsolate isolate) =>
      '$_keyPrefix${isolate.id}';

  @override
  Future<List<ConsoleLogEntry>> readAll() async {
    final entries = <ConsoleLogEntry>[];
    for (final isolate in ConsoleLogIsolate.values) {
      entries.addAll(await _read(isolate));
    }
    entries.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return entries;
  }

  @override
  Future<void> write(
    ConsoleLogIsolate isolate,
    List<ConsoleLogEntry> entries,
  ) async {
    final json = jsonEncode(entries.map((entry) => entry.toJson()).toList());
    await _preferences.setString(_keyFor(isolate), json);
  }

  @override
  Future<void> clear() async {
    for (final isolate in ConsoleLogIsolate.values) {
      await _preferences.remove(_keyFor(isolate));
    }
  }

  Future<List<ConsoleLogEntry>> _read(ConsoleLogIsolate isolate) async {
    final json = await _preferences.getString(_keyFor(isolate));
    if (json == null) {
      return const [];
    }

    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list
          .map((item) => ConsoleLogEntry.fromJson(item as Map<String, dynamic>))
          .toList();
    } on Exception {
      // The stored format changed or the payload is corrupted; drop it.
      await _preferences.remove(_keyFor(isolate));
      return const [];
    }
  }
}
