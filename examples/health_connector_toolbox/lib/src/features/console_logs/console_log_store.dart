import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';
import 'package:health_connector_toolbox/src/features/console_logs/services/console_log_storage.dart';

/// Central, observable buffer of SDK log entries for one isolate.
///
/// Entries added in this isolate are kept in memory, exposed through
/// [entries], and persisted after a short debounce so other isolates can read
/// them. [reload] merges the entries persisted by every isolate, which is how
/// the UI observes logs written by the background sync task.
final class ConsoleLogStore extends ChangeNotifier {
  ConsoleLogStore({
    required ConsoleLogStorage storage,
    required this.isolate,
    this.maxEntries = 500,
    this.maxPersistedEntries = 200,
    this.persistDelay = const Duration(milliseconds: 300),
  }) : _storage = storage;

  final ConsoleLogStorage _storage;

  /// Isolate whose entries this store owns.
  final ConsoleLogIsolate isolate;

  /// Upper bound of entries kept in memory.
  final int maxEntries;

  /// Upper bound of own entries written to storage.
  final int maxPersistedEntries;

  /// Debounce applied between an [add] and the persisted write.
  final Duration persistDelay;

  final List<ConsoleLogEntry> _entries = [];
  Timer? _persistTimer;
  Future<void>? _pendingPersist;

  /// Entries captured or reloaded so far, oldest first.
  UnmodifiableListView<ConsoleLogEntry> get entries =>
      UnmodifiableListView(_entries);

  /// Records [entry], notifies listeners, and schedules a persisted write.
  void add(ConsoleLogEntry entry) {
    _entries.add(entry);
    _trim();
    notifyListeners();
    _schedulePersist();
  }

  /// Writes the pending own entries to storage immediately.
  ///
  /// Call this before a background task returns so nothing stays in memory.
  Future<void> flush() async {
    _persistTimer?.cancel();
    _persistTimer = null;
    await _persist();
  }

  /// Merges the entries persisted by every isolate into [entries].
  Future<void> reload() async {
    final persisted = await _storage.readAll();
    final merged = <String, ConsoleLogEntry>{
      for (final entry in persisted) entry.id: entry,
      for (final entry in _entries) entry.id: entry,
    };
    _entries
      ..clear()
      ..addAll(merged.values)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    _trim();
    notifyListeners();
  }

  /// Removes every entry from memory and storage.
  Future<void> clear() async {
    _persistTimer?.cancel();
    _persistTimer = null;
    _entries.clear();
    await _storage.clear();
    notifyListeners();
  }

  void _trim() {
    if (_entries.length > maxEntries) {
      _entries.removeRange(0, _entries.length - maxEntries);
    }
  }

  void _schedulePersist() {
    _persistTimer?.cancel();
    _persistTimer = Timer(persistDelay, () => unawaited(_persist()));
  }

  Future<void> _persist() async {
    // Serialize writes so an in-flight write never races a newer one.
    final previous = _pendingPersist;
    final current = () async {
      await previous;
      final own = _entries.where((entry) => entry.isolate == isolate).toList();
      final start = own.length > maxPersistedEntries
          ? own.length - maxPersistedEntries
          : 0;
      await _storage.write(isolate, own.sublist(start));
    }();
    _pendingPersist = current;
    await current;
  }

  @override
  void dispose() {
    _persistTimer?.cancel();
    super.dispose();
  }
}
