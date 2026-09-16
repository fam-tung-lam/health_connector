import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/console_logs/pages/console_logs_page.dart';

/// App bar action that opens the SDK console logs page.
///
/// The console log store is provided above the [MaterialApp], so the pushed
/// page reads it from the inherited provider tree.
@immutable
final class ConsoleLogsActionButton extends StatelessWidget {
  const ConsoleLogsActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(AppIcons.terminal),
      tooltip: AppTexts.sdkConsoleLogs,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute<Widget>(builder: (_) => const ConsoleLogsPage()),
      ),
    );
  }
}
