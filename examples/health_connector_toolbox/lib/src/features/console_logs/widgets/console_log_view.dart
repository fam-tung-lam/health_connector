import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';
import 'package:health_connector_toolbox/src/features/console_logs/widgets/console_log_entry_tile.dart';

/// Dark terminal panel that lists [ConsoleLogEntry] rows and follows the tail.
///
/// Give it a fixed [height] inside a scrolling page, or leave [height] null
/// when the parent constrains it (for example inside an [Expanded]).
@immutable
final class ConsoleLogView extends StatefulWidget {
  const ConsoleLogView({
    required this.entries,
    this.height,
    this.emptyText = AppTexts.noLogsYet,
    super.key,
  });

  final List<ConsoleLogEntry> entries;
  final double? height;
  final String emptyText;

  @override
  State<ConsoleLogView> createState() => _ConsoleLogViewState();
}

class _ConsoleLogViewState extends State<ConsoleLogView> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(ConsoleLogView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.entries.length != oldWidget.entries.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) {
      return;
    }
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = widget.entries;

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: entries.isEmpty
          ? Center(
              child: Text(
                widget.emptyText,
                style: const TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return ConsoleLogEntryTile(
                  key: ValueKey(entry.id),
                  entry: entry,
                );
              },
            ),
    );
  }
}
