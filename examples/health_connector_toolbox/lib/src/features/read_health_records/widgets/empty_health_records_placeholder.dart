import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthPlatform;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Empty state widget for when no health records are found.
///
/// Displays a helpful message and provides a button to check permissions
/// if the user hasn't granted access to health data.
@immutable
final class EmptyHealthRecordsPlaceholder extends StatelessWidget {
  const EmptyHealthRecordsPlaceholder({
    required this.healthPlatform,
    required this.onCheckPermissions,
    super.key,
  });

  final HealthPlatform healthPlatform;
  final VoidCallback onCheckPermissions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Icon(
            AppIcons.inbox,
            size: 80,
            color: colorScheme.outline,
          ),
          const SizedBox(height: 20),
          Text(
            AppTexts.noRecordsFound,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppTexts.emptyHealthRecordListPlaceholder,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          ElevatedButton.icon(
            onPressed: onCheckPermissions,
            icon: const Icon(AppIcons.lockOutline),
            label: const Text(AppTexts.checkPermissions),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
