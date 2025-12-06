import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show MeasurementUnit;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart';
import 'package:health_connector_toolbox/src/common/widgets/measurement_unit_display.dart';

/// A reusable card widget for displaying aggregation results with metric,
/// value type, value, and time range information.
@immutable
final class AggregateResultCard extends StatelessWidget {
  const AggregateResultCard({
    required this.metric,
    required this.value,
    super.key,
    this.endDateTime,
    this.startDateTime,
  });

  /// The aggregation metric name (e.g., 'SUM', 'AVG', 'MIN', 'MAX').
  final String metric;

  /// The aggregated value to display.
  final dynamic value;

  /// Optional start date and time for the aggregation period.
  final DateTime? startDateTime;

  /// Optional end date and time for the aggregation period.
  final DateTime? endDateTime;

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-'
        '${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildValueDisplay(BuildContext context, dynamic value) {
    if (value is MeasurementUnit) {
      return MeasurementUnitDisplay(unit: value);
    }

    // Fallback for any other type
    return Text(
      value.toString(),
      style:
          Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.aggregationResult,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTexts.metric,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.grey600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        metric,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTexts.valueType,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.grey600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value.runtimeType.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: AppColors.grey300),
            const SizedBox(height: 24),
            Text(
              AppTexts.value,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 8),
            _buildValueDisplay(context, value),
            if (startDateTime != null && endDateTime != null) ...[
              const SizedBox(height: 24),
              const Divider(color: AppColors.grey300),
              const SizedBox(height: 16),
              Text(
                AppTexts.timeRange,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.grey600),
              ),
              const SizedBox(height: 4),
              Text(
                '${_formatDateTime(startDateTime!)} - '
                '${_formatDateTime(endDateTime!)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
