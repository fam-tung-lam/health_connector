import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthPlatformFeatureStatus, PermissionStatus;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_status_colors.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/status_row.dart';
import 'package:provider/provider.dart';

/// Card showing the background sync status and the latest run.
///
/// The status section shows whether the periodic task is registered, the
/// scheduler's view of it, and the background read permission on Health
/// Connect. The report section shows when the latest worker run started and
/// finished, how it ended, the token transition, and how many records it
/// upserted and deleted.
@immutable
final class LatestSyncReportCard extends StatelessWidget {
  const LatestSyncReportCard({required this.onRequestPermission, super.key});

  final VoidCallback onRequestPermission;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColors = theme.extension<AppStatusColors>()!;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusSection(
              statusColors: statusColors,
              onRequestPermission: onRequestPermission,
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Text(AppTexts.latestSyncResult, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Selector<
              BackgroundIncrementalDataSyncChangeNotifier,
              BackgroundSyncReport?
            >(
              selector: (_, notifier) => notifier.latestReport,
              builder: (context, report, _) => report == null
                  ? Text(
                      AppTexts.noSyncResultYet,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    )
                  : _ReportDetails(report: report, statusColors: statusColors),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusSection extends StatelessWidget {
  const _StatusSection({
    required this.statusColors,
    required this.onRequestPermission,
  });

  final AppStatusColors statusColors;
  final VoidCallback onRequestPermission;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<BackgroundIncrementalDataSyncChangeNotifier>(
      builder: (context, notifier, _) {
        final isEnabled = notifier.isBackgroundSyncEnabled;
        final workInfo = notifier.workInfo;
        final permissionStatus = notifier.backgroundReadPermissionStatus;
        final featureStatus = notifier.backgroundReadFeatureStatus;

        return Column(
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
                  label: Text(isEnabled ? AppTexts.active : AppTexts.inactive),
                  backgroundColor: isEnabled
                      ? statusColors.successContainer
                      : theme.colorScheme.surfaceContainerHighest,
                ),
              ],
            ),
            const SizedBox(height: 12),
            StatusRow(
              label: AppTexts.schedulerState,
              value: workInfo?.state.name ?? AppTexts.notScheduled,
            ),
            if (notifier.requiresBackgroundReadPermission) ...[
              const SizedBox(height: 12),
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
                            color: permissionStatus == PermissionStatus.granted
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
          ],
        );
      },
    );
  }
}

class _ReportDetails extends StatelessWidget {
  const _ReportDetails({required this.report, required this.statusColors});

  final BackgroundSyncReport report;
  final AppStatusColors statusColors;

  Color _outcomeColor(BuildContext context) => switch (report.outcome) {
    BackgroundSyncOutcome.succeeded => statusColors.success,
    BackgroundSyncOutcome.failed => Theme.of(context).colorScheme.error,
    BackgroundSyncOutcome.skipped => statusColors.warning,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final error = report.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusRow(
          label: AppTexts.outcome,
          value: report.outcome.id,
          valueColor: _outcomeColor(context),
        ),
        const SizedBox(height: 8),
        StatusRow(
          label: AppTexts.startedAt,
          value: DateFormatter.formatDateTimeWithSeconds(
            report.startedAt.toLocal(),
          ),
        ),
        const SizedBox(height: 8),
        StatusRow(
          label: AppTexts.finishedAt,
          value: DateFormatter.formatDateTimeWithSeconds(
            report.finishedAt.toLocal(),
          ),
        ),
        const SizedBox(height: 8),
        StatusRow(
          label: AppTexts.duration,
          value: '${report.duration.inMilliseconds} ms',
        ),
        const SizedBox(height: 8),
        StatusRow(label: AppTexts.pages, value: '${report.pageCount}'),
        const SizedBox(height: 8),
        StatusRow(
          label: AppTexts.upsertedRecords,
          value: '${report.upsertedRecordCount}',
          valueColor: statusColors.success,
        ),
        const SizedBox(height: 8),
        StatusRow(
          label: AppTexts.deletedRecords,
          value: '${report.deletedRecordCount}',
          valueColor: theme.colorScheme.error,
        ),
        const SizedBox(height: 8),
        StatusRow(
          label: AppTexts.dataTypes,
          value: report.dataTypeIds.join(', '),
          maxLines: 6,
        ),
        const SizedBox(height: 8),
        StatusRow(
          label: AppTexts.syncToken,
          value:
              '${report.tokenBefore?.token ?? AppTexts.none} → '
              '${report.tokenAfter?.token ?? AppTexts.none}',
          maxLines: 4,
        ),
        if (report.tokenReset) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColors.warningContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  AppIcons.warning,
                  size: 18,
                  color: statusColors.onWarningContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${AppTexts.tokenReset}: ${AppTexts.tokenResetHint}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: statusColors.onWarningContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (error != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppTexts.errorPrefixColon}: ${error.code}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  error.message,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${AppTexts.willRetry}: ${error.willRetry}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
