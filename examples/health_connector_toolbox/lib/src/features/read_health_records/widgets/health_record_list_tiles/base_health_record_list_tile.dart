import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_connector/health_connector_internal.dart' show Metadata;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

import 'package:health_connector_toolbox/src/common/utils/show_app_dialog.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_metadata_info.dart';

/// A base widget for displaying health records in an expandable tile format.
///
/// This widget provides common functionality for all health record types
/// including:
/// - Expandable tile with custom icon, title, and subtitle
/// - Delete button with confirmation dialog
/// - Expansion indicator (rotating chevron)
/// - Common detail section layout with metadata
@immutable
final class BaseHealthRecordListTile extends StatefulWidget {
  const BaseHealthRecordListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.detailRows,
    required this.metadata,
    required this.onDelete,
    super.key,
  });

  final IconData icon;
  final String title;
  final Widget subtitle;
  final List<Widget> detailRows;
  final Metadata metadata;
  final VoidCallback onDelete;

  @override
  State<BaseHealthRecordListTile> createState() =>
      _BaseHealthRecordListTileState();
}

class _BaseHealthRecordListTileState extends State<BaseHealthRecordListTile> {
  bool _isExpanded = false;

  Future<void> _handleDelete() async {
    final confirmed = await showConfirmationDialog(
      context,
      title: AppTexts.deleteRecordQuestion,
      message: AppTexts.actionCannotBeUndone,
      confirmText: AppTexts.delete,
    );

    if (confirmed) {
      // Haptic feedback on confirmed delete
      await HapticFeedback.mediumImpact();
      widget.onDelete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      elevation: 1,
      shadowColor: colorScheme.primary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            widget.icon,
            color: colorScheme.primary,
            size: 24,
          ),
        ),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: widget.subtitle,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                AppIcons.delete,
                color: colorScheme.error.withValues(alpha: 0.8),
                size: 22,
              ),
              tooltip: AppTexts.delete,
              onPressed: _handleDelete,
              visualDensity: VisualDensity.compact,
            ),
            const SizedBox(width: 4),
            AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                AppIcons.expandMore,
                color: colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
          ],
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      AppIcons.infoOutline,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppTexts.recordDetails,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...widget.detailRows,
                const SizedBox(height: 12),
                HealthRecordMetadataInfo(metadata: widget.metadata),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
