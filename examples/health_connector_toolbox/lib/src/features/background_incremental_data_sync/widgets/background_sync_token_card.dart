import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthDataSyncToken;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/status_row.dart';
import 'package:provider/provider.dart';

/// Card showing the stored background sync token with a clear action.
@immutable
final class BackgroundSyncTokenCard extends StatelessWidget {
  const BackgroundSyncTokenCard({required this.onClearToken, super.key});

  final VoidCallback onClearToken;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Selector<
      BackgroundIncrementalDataSyncChangeNotifier,
      HealthDataSyncToken?
    >(
      selector: (_, notifier) => notifier.syncToken,
      builder: (context, token, _) {
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
                    Expanded(
                      child: Text(
                        AppTexts.syncToken,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    if (token != null)
                      IconButton(
                        icon: const Icon(AppIcons.delete),
                        tooltip: AppTexts.clearToken,
                        onPressed: onClearToken,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                if (token == null)
                  Text(
                    AppTexts.noneInitialSync,
                    style: theme.textTheme.bodyMedium,
                  )
                else ...[
                  StatusRow(label: AppTexts.token, value: token.token),
                  const SizedBox(height: 8),
                  StatusRow(
                    label: AppTexts.createdAt,
                    value: DateFormatter.formatDateTimeWithSeconds(
                      token.createdAt.toLocal(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  StatusRow(
                    label: AppTexts.dataTypes,
                    value: token.dataTypes.map((type) => type.id).join(', '),
                    maxLines: 6,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
