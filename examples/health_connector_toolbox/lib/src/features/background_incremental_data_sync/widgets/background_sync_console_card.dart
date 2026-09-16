import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/console_logs/widgets/console_log_view.dart';
import 'package:provider/provider.dart';

/// Card embedding the central console so a developer can watch the run
/// without leaving the screen.
@immutable
final class BackgroundSyncConsoleCard extends StatelessWidget {
  const BackgroundSyncConsoleCard({required this.onOpenConsole, super.key});

  final VoidCallback onOpenConsole;

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsoleLogStore>(
      builder: (context, store, _) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(AppIcons.terminal),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        AppTexts.consoleLog,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(AppIcons.openInNew),
                      tooltip: AppTexts.openFullConsole,
                      onPressed: onOpenConsole,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ConsoleLogView(entries: store.entries.toList(), height: 240),
              ],
            ),
          ),
        );
      },
    );
  }
}
