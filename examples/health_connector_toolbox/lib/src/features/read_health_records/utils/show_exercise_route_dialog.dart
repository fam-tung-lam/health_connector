import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:intl/intl.dart';

/// Shows a dialog displaying exercise route details.
Future<void> showExerciseRouteDialog(
  BuildContext context, {
  required ExerciseRoute route,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _ExerciseRouteDialog(route: route),
  );
}

/// A dialog widget that displays exercise route information.
class _ExerciseRouteDialog extends StatelessWidget {
  const _ExerciseRouteDialog({
    required this.route,
  });

  final ExerciseRoute route;

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final timeFormat = DateFormat('HH:mm:ss');

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            AppIcons.route,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 8),
          const Text(AppTexts.routeDetails),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary section
            _buildSummaryCard(context),
            const SizedBox(height: 16),
            // Locations list
            Text(
              AppTexts.routeLocations,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 300),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: route.locations.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final location = route.locations[index];
                    return _LocationTile(
                      index: index,
                      location: location,
                      timeFormat: timeFormat,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppTexts.close),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              icon: AppIcons.terrain,
              label: AppTexts.totalPoints,
              value: '${route.length}',
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: colorScheme.outline.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _SummaryItem(
              icon: AppIcons.time,
              label: AppTexts.duration,
              value: _formatDuration(route.duration),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          color: colorScheme.primary,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _LocationTile extends StatelessWidget {
  const _LocationTile({
    required this.index,
    required this.location,
    required this.timeFormat,
  });

  final int index;
  final ExerciseRouteLocation location;
  final DateFormat timeFormat;

  String _formatAccuracy(ExerciseRouteLocation loc) {
    final parts = <String>[];
    if (loc.horizontalAccuracy != null) {
      final value = loc.horizontalAccuracy!.inMeters.toStringAsFixed(1);
      parts.add('${AppTexts.horizontalAccuracy}: $value${AppTexts.metersAbbr}');
    }
    if (loc.verticalAccuracy != null) {
      final value = loc.verticalAccuracy!.inMeters.toStringAsFixed(1);
      parts.add('${AppTexts.verticalAccuracy}: $value${AppTexts.metersAbbr}');
    }
    return parts.join(' | ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with index and time
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                timeFormat.format(location.time),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Coordinates
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '${location.latitude.toStringAsFixed(6)}, '
                        '${location.longitude.toStringAsFixed(6)}',
                        style: theme.textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (location.altitude != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.height,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${AppTexts.altitude}: '
                          '${location.altitude!.inMeters.toStringAsFixed(1)} '
                          '${AppTexts.metersAbbr}',
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                if (location.horizontalAccuracy != null ||
                    location.verticalAccuracy != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.gps_fixed,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          _formatAccuracy(location),
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
