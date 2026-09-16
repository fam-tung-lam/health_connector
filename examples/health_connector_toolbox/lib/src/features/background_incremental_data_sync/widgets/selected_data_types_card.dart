import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthDataSyncToken, HealthDataType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/status_row.dart';
import 'package:provider/provider.dart';

/// Card listing the data types included in background sync and the stored
/// sync token that belongs to them.
///
/// Tapping the data types section asks the parent to open the selector. The
/// token section offers a clear action while a token is stored.
@immutable
final class SelectedDataTypesCard extends StatelessWidget {
  const SelectedDataTypesCard({
    required this.dataTypes,
    required this.onEdit,
    required this.onClearToken,
    super.key,
  });

  final List<HealthDataType> dataTypes;
  final VoidCallback onEdit;
  final VoidCallback onClearToken;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onEdit,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: _DataTypesSection(dataTypes: dataTypes),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: _TokenSection(onClearToken: onClearToken),
          ),
        ],
      ),
    );
  }
}

class _DataTypesSection extends StatelessWidget {
  const _DataTypesSection({required this.dataTypes});

  final List<HealthDataType> dataTypes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${AppTexts.selectedDataTypes} (${dataTypes.length})',
                style: theme.textTheme.titleMedium,
              ),
            ),
            const Icon(AppIcons.tune),
          ],
        ),
        const SizedBox(height: 12),
        if (dataTypes.isEmpty)
          Text(
            AppTexts.noDataTypesSelected,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          )
        else ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: dataTypes
                .map(
                  (type) => Chip(
                    avatar: Icon(type.icon, size: 18),
                    label: Text(type.displayName),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          Text(
            AppTexts.tapToAdjustSelection,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _TokenSection extends StatelessWidget {
  const _TokenSection({required this.onClearToken});

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
        return Column(
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
              Text(AppTexts.noneInitialSync, style: theme.textTheme.bodyMedium)
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
        );
      },
    );
  }
}
