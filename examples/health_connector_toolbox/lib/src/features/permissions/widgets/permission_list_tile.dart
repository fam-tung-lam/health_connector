import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show PermissionStatus;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_status_colors.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';

/// Base widget for permission status tiles.
///
/// This widget provides common functionality for displaying permission
/// tiles with status-based styling, checkbox selection, and consistent card
/// appearance.
///
/// Benefits:
/// - Eliminates code duplication across tile widgets
/// - Ensures consistent UX and styling
/// - Single source of truth for status colors and checkbox logic
@immutable
final class PermissionListTile extends StatelessWidget {
  const PermissionListTile({
    required this.title,
    required this.isSelected,
    required this.permissionStatus,
    required this.onChanged,
    this.subtitle,
    this.trailing,
    this.children,
    this.isEnabled = true,
    super.key,
  });

  /// The title widget for the tile.
  final Widget title;

  /// The subtitle widget for the tile.
  final Widget? subtitle;

  /// The trailing widget for the tile.
  final Widget? trailing;

  /// Children widgets for expandable tiles.
  final List<Widget>? children;

  /// Whether the permission is currently selected for batch request.
  final bool isSelected;

  /// Current permission status (granted/denied/unknown).
  final PermissionStatus? permissionStatus;

  /// Callback when selection changes.
  final ValueChanged<bool>? onChanged;

  /// Whether the tile is enabled for interaction.
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final isGranted = permissionStatus == PermissionStatus.granted;
    final isDenied = permissionStatus == PermissionStatus.denied;
    final statusColors = Theme.of(context).extension<AppStatusColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    // Determine border color based on status
    final borderColor = isGranted
        ? statusColors.success
        : isDenied
        ? colorScheme.error
        : colorScheme.outline.withValues(alpha: 0.3);

    // Determine background color
    final backgroundColor = isGranted
        ? statusColors.successContainer.withValues(alpha: 0.3)
        : isDenied
        ? colorScheme.errorContainer.withValues(alpha: 0.3)
        : null;

    final tileWidget = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: borderColor,
              width: 4,
            ),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: isGranted
              ? _buildStatusIcon(context, isGranted: true)
              : SizedBox(
                  width: 40,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: isEnabled
                        ? (value) => onChanged?.call(value ?? false)
                        : null,
                  ),
                ),
          title: title,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                subtitle!,
              ],
              const SizedBox(height: 8),
              _buildStatusBadge(context, isGranted, isDenied, statusColors),
            ],
          ),
          trailing: trailing,
        ),
      ),
    );

    final card = Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      elevation: 1,
      shadowColor: borderColor.withValues(alpha: 0.2),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: borderColor.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: children != null
          ? ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: isGranted
                  ? _buildStatusIcon(context, isGranted: true)
                  : SizedBox(
                      width: 40,
                      child: Checkbox(
                        value: isSelected,
                        onChanged: isEnabled
                            ? (value) => onChanged?.call(value ?? false)
                            : null,
                      ),
                    ),
              title: title,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    subtitle!,
                  ],
                  const SizedBox(height: 8),
                  _buildStatusBadge(context, isGranted, isDenied, statusColors),
                ],
              ),
              trailing: trailing,
              children: children!,
            )
          : tileWidget,
    );

    return card;
  }

  /// Builds a status icon for granted or denied permissions.
  Widget _buildStatusIcon(BuildContext context, {required bool isGranted}) {
    final statusColors = Theme.of(context).extension<AppStatusColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isGranted
            ? statusColors.success.withValues(alpha: 0.1)
            : colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        isGranted ? AppIcons.checkCircleOutline : AppIcons.cancelOutlined,
        color: isGranted ? statusColors.success : colorScheme.error,
        size: 24,
      ),
    );
  }

  /// Builds a status badge chip.
  Widget _buildStatusBadge(
    BuildContext context,
    bool isGranted,
    bool isDenied,
    AppStatusColors statusColors,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    final status = permissionStatus;
    final statusText = status == null ? AppTexts.unknown : status.displayName;

    final badgeColor = isGranted
        ? statusColors.success
        : isDenied
        ? colorScheme.error
        : colorScheme.onSurfaceVariant;

    final badgeBackgroundColor = isGranted
        ? statusColors.successContainer
        : isDenied
        ? colorScheme.errorContainer
        : colorScheme.surfaceContainerHighest;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: badgeBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isGranted
                ? AppIcons.checkCircle
                : isDenied
                ? AppIcons.cancel
                : AppIcons.helpCircleOutline,
            size: 14,
            color: badgeColor,
          ),
          const SizedBox(width: 6),
          Text(
            statusText,
            style: theme.textTheme.labelSmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
