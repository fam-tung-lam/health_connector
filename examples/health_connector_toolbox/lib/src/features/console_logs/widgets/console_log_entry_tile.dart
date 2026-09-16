import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthConnectorLogLevel;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';

/// Terminal-style row for one [ConsoleLogEntry].
///
/// Tapping the row toggles a detail block with origin, isolate, operation,
/// context, and exception information.
@immutable
final class ConsoleLogEntryTile extends StatefulWidget {
  const ConsoleLogEntryTile({required this.entry, super.key});

  final ConsoleLogEntry entry;

  /// Console text color for [level].
  static Color colorFor(HealthConnectorLogLevel level) {
    return switch (level) {
      HealthConnectorLogLevel.debug => Colors.grey.shade400,
      HealthConnectorLogLevel.info => Colors.greenAccent,
      HealthConnectorLogLevel.warning => Colors.amberAccent,
      HealthConnectorLogLevel.error => Colors.redAccent,
    };
  }

  @override
  State<ConsoleLogEntryTile> createState() => _ConsoleLogEntryTileState();
}

class _ConsoleLogEntryTileState extends State<ConsoleLogEntryTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final color = ConsoleLogEntryTile.colorFor(entry.level);
    const lineStyle = TextStyle(fontFamily: 'monospace', fontSize: 12);

    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.formattedLine,
              style: lineStyle.copyWith(color: color),
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 2, bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailLine(
                      label: AppTexts.origin,
                      value: entry.origin,
                    ),
                    _DetailLine(
                      label: AppTexts.isolate,
                      value: entry.isolate.id,
                    ),
                    if (entry.operation != null)
                      _DetailLine(
                        label: AppTexts.operation,
                        value: entry.operation!,
                      ),
                    if (entry.context case final context?
                        when context.isNotEmpty)
                      ...context.entries.map(
                        (item) => _DetailLine(
                          label: item.key,
                          value: item.value,
                        ),
                      ),
                    if (entry.exception != null)
                      _DetailLine(
                        label: AppTexts.exception,
                        value: entry.exception!,
                        isError: true,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  const _DetailLine({
    required this.label,
    required this.value,
    this.isError = false,
  });

  final String label;
  final String value;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      '$label: $value',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: isError ? Colors.redAccent : Colors.grey.shade300,
      ),
    );
  }
}
