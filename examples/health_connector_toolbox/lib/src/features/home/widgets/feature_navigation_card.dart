import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';

/// A reusable card widget for navigating to different features.
///
/// Displays a card with an icon, title, and description that users can
/// tap to navigate to a specific feature. Includes hover and press animations
/// for better interactivity.
@immutable
final class FeatureNavigationCard extends StatelessWidget {
  const FeatureNavigationCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.color,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveColor = color ?? colorScheme.primary;

    return Card(
      elevation: 1,
      shadowColor: colorScheme.primary.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Icon container with colored background
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: effectiveColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: effectiveColor,
                ),
              ),
              const SizedBox(width: 16),

              // Title and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Arrow indicator
              Icon(
                AppIcons.arrowForward,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
