import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthDataType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';

/// Card listing the data types included in background sync.
///
/// Tapping anywhere on the card asks the parent to open the selector.
@immutable
final class SelectedDataTypesCard extends StatelessWidget {
  const SelectedDataTypesCard({
    required this.dataTypes,
    required this.onEdit,
    super.key,
  });

  final List<HealthDataType> dataTypes;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
          ),
        ),
      ),
    );
  }
}
