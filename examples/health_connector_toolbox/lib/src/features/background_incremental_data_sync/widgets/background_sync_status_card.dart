import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthPlatform, HealthPlatformFeatureStatus, PermissionStatus;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_status_colors.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/status_row.dart';
import 'package:provider/provider.dart';

/// Card showing whether the periodic task is registered, its frequency, the
/// scheduler's view of it, platform caveats, and the background read
/// permission on Health Connect.
@immutable
final class BackgroundSyncStatusCard extends StatelessWidget {
  const BackgroundSyncStatusCard({
    required this.healthPlatform,
    required this.onRunNow,
    required this.onRequestPermission,
    required this.onFrequencyChanged,
    super.key,
  });

  final HealthPlatform healthPlatform;
  final VoidCallback onRunNow;
  final VoidCallback onRequestPermission;
  final ValueChanged<Duration> onFrequencyChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColors = theme.extension<AppStatusColors>()!;

    return Consumer<BackgroundIncrementalDataSyncChangeNotifier>(
      builder: (context, notifier, _) {
        final isEnabled = notifier.isBackgroundSyncEnabled;
        final workInfo = notifier.workInfo;
        final permissionStatus = notifier.backgroundReadPermissionStatus;
        final featureStatus = notifier.backgroundReadFeatureStatus;

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
                        AppTexts.backgroundSyncStatus,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    Chip(
                      avatar: Icon(
                        isEnabled ? AppIcons.checkCircle : AppIcons.cancel,
                        size: 18,
                        color: isEnabled
                            ? statusColors.onSuccessContainer
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      label: Text(
                        isEnabled ? AppTexts.active : AppTexts.inactive,
                      ),
                      backgroundColor: isEnabled
                          ? statusColors.successContainer
                          : theme.colorScheme.surfaceContainerHighest,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppTexts.frequency,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    DropdownButton<Duration>(
                      value: notifier.settings.frequency,
                      underline: const SizedBox.shrink(),
                      items: BackgroundIncrementalDataSyncChangeNotifier
                          .frequencyOptions
                          .map(
                            (option) => DropdownMenuItem(
                              value: option,
                              child: Text(
                                AppTexts.everyMinutes.replaceFirst(
                                  '{0}',
                                  '${option.inMinutes}',
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          onFrequencyChanged(value);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                StatusRow(
                  label: AppTexts.schedulerState,
                  value: workInfo?.state.name ?? AppTexts.notScheduled,
                ),
                if (workInfo?.lastFinishedAt case final lastFinishedAt?) ...[
                  const SizedBox(height: 8),
                  StatusRow(
                    label: AppTexts.lastFinished,
                    value: DateFormatter.formatDateTimeWithSeconds(
                      lastFinishedAt,
                    ),
                  ),
                ],
                if (notifier.requiresBackgroundReadPermission) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppTexts.backgroundReadPermission,
                              style: theme.textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              featureStatus ==
                                      HealthPlatformFeatureStatus.unavailable
                                  ? AppTexts.featureUnavailable
                                  : permissionStatus?.displayName ??
                                        AppTexts.unknown,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color:
                                    permissionStatus == PermissionStatus.granted
                                    ? statusColors.success
                                    : theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (permissionStatus != PermissionStatus.granted)
                        FilledButton.tonal(
                          onPressed:
                              featureStatus ==
                                  HealthPlatformFeatureStatus.unavailable
                              ? null
                              : onRequestPermission,
                          child: const Text(AppTexts.requestPermission),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  healthPlatform == HealthPlatform.healthConnect
                      ? AppTexts.androidBackgroundSyncNote
                      : AppTexts.iosBackgroundSyncNote,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: notifier.isSyncing ? null : onRunNow,
                  icon: const Icon(AppIcons.playArrow),
                  label: const Text(AppTexts.runSyncNow),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 44),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppTexts.runSyncNowHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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
