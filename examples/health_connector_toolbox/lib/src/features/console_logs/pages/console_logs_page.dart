import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:health_connector/health_connector_internal.dart'
    show HealthConnectorLogLevel;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/search_text_field.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';
import 'package:health_connector_toolbox/src/features/console_logs/widgets/console_log_entry_tile.dart';
import 'package:health_connector_toolbox/src/features/console_logs/widgets/console_log_view.dart';
import 'package:provider/provider.dart';

/// Central console showing every SDK log captured by the toolbox.
///
/// Entries come from the main isolate live and from the background isolate
/// through periodic reloads of the persisted log lists.
@immutable
final class ConsoleLogsPage extends StatefulWidget {
  const ConsoleLogsPage({super.key});

  /// How often persisted background entries are merged while visible.
  static const Duration reloadInterval = Duration(seconds: 5);

  @override
  State<ConsoleLogsPage> createState() => _ConsoleLogsPageState();
}

class _ConsoleLogsPageState extends State<ConsoleLogsPage>
    with WidgetsBindingObserver {
  late final ConsoleLogStore _store = context.read<ConsoleLogStore>();
  final Set<HealthConnectorLogLevel> _levels = {
    ...HealthConnectorLogLevel.values,
  };
  String _query = '';
  Timer? _reloadTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_store.reload());
    _reloadTimer = Timer.periodic(
      ConsoleLogsPage.reloadInterval,
      (_) => unawaited(_store.reload()),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_store.reload());
    }
  }

  @override
  void dispose() {
    _reloadTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<ConsoleLogEntry> _filter(List<ConsoleLogEntry> entries) {
    final query = _query.trim().toLowerCase();
    return entries.where((entry) {
      if (!_levels.contains(entry.level)) {
        return false;
      }
      if (query.isEmpty) {
        return true;
      }
      return entry.formattedLine.toLowerCase().contains(query) ||
          (entry.exception?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  Future<void> _copy(List<ConsoleLogEntry> entries) async {
    final text = entries.map((entry) => entry.formattedLine).join('\n');
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) {
      return;
    }
    showAppSnackBar(context, SnackBarType.success, AppTexts.logsCopied);
  }

  Future<void> _clear() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppTexts.clearLogsQuestion),
        content: const Text(AppTexts.clearLogsContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppTexts.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(AppTexts.clear),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await _store.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsoleLogStore>(
      builder: (context, store, _) {
        final entries = _filter(store.entries);

        return Scaffold(
          appBar: AppBar(
            title: const Text(AppTexts.sdkConsoleLogs),
            actions: [
              IconButton(
                icon: const Icon(AppIcons.refresh),
                tooltip: AppTexts.refreshLogs,
                onPressed: () => unawaited(store.reload()),
              ),
              IconButton(
                icon: const Icon(AppIcons.copyAll),
                tooltip: AppTexts.copyLogs,
                onPressed: entries.isEmpty ? null : () => _copy(entries),
              ),
              IconButton(
                icon: const Icon(AppIcons.deleteSweep),
                tooltip: AppTexts.clearLogs,
                onPressed: store.entries.isEmpty ? null : _clear,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SearchTextField(
                  hintText: AppTexts.searchLogs,
                  onChanged: (value) => setState(() => _query = value),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: HealthConnectorLogLevel.values.map((level) {
                    return FilterChip(
                      label: Text(level.name),
                      selected: _levels.contains(level),
                      selectedColor: ConsoleLogEntryTile.colorFor(
                        level,
                      ).withValues(alpha: 0.3),
                      onSelected: (selected) => setState(() {
                        if (selected) {
                          _levels.add(level);
                        } else {
                          _levels.remove(level);
                        }
                      }),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                Text(
                  '${entries.length} / ${store.entries.length} '
                  '${AppTexts.entries}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ConsoleLogView(
                    entries: entries,
                    emptyText: store.entries.isEmpty
                        ? AppTexts.noLogsYet
                        : AppTexts.noLogsMatchFilters,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
