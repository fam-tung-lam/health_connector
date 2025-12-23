import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_status_colors.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';

/// A card widget displaying the connected health platform status.
///
/// Shows the platform name (HealthKit/Health Connect), connection status,
/// and platform-specific icon with calming visual styling suitable for
/// health applications.
@immutable
final class PlatformStatusCard extends StatelessWidget {
  const PlatformStatusCard({
    required this.healthPlatform,
    super.key,
  });

  final HealthPlatform healthPlatform;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final statusColors = Theme.of(context).extension<AppStatusColors>()!;

    return Card(
      elevation: 2,
      shadowColor: colorScheme.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              colorScheme.primaryContainer.withValues(alpha: 0.3),
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status label
            Text(
              AppTexts.platformStatus,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            // Platform info row
            Row(
              children: [
                // Platform icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getPlatformIcon(),
                    size: 28,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),

                // Platform name and status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        healthPlatform.displayName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            AppIcons.checkCircle,
                            size: 16,
                            color: statusColors.onSuccessContainer,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppTexts.available,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: statusColors.success,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the appropriate icon for the health platform.
  IconData _getPlatformIcon() {
    return switch (healthPlatform) {
      HealthPlatform.appleHealth => AppIcons.apple,
      HealthPlatform.healthConnect => AppIcons.android,
    };
  }
}
