import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show AggregationMetric, MeasurementUnit;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/common/widgets/measurement_unit_display.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/widgets/aggregate_info_row.dart';

/// A reusable card widget for displaying aggregation results with metric,
/// value type, value, and time range information.
///
/// Features modern Material Design 3 styling with gradient backgrounds,
/// color-coded metric badges, and prominent value display.
@immutable
final class AggregateResultCard extends StatelessWidget {
  const AggregateResultCard({
    required this.metric,
    required this.value,
    required this.aggregationMetric,
    super.key,
    this.endDateTime,
    this.startDateTime,
  });

  /// The aggregation metric name (e.g., 'Sum', 'Average', 'Minimum').
  final String metric;

  /// The aggregation metric enum for color coding.
  final AggregationMetric aggregationMetric;

  /// The aggregated value to display.
  final MeasurementUnit value;

  /// Optional start date and time for the aggregation period.
  final DateTime? startDateTime;

  /// Optional end date and time for the aggregation period.
  final DateTime? endDateTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      elevation: 2,
      shadowColor: colorScheme.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: MeasurementUnitDisplay(
                  unit: value,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  AggregateInfoRow(
                    icon: AppIcons.infoOutline,
                    label: AppTexts.valueType,
                    value: value.runtimeType.toString(),
                  ),
                  const SizedBox(height: 12),
                  AggregateInfoRow(
                    icon: AppIcons.infoOutline,
                    label: AppTexts.aggregationMetric,
                    value: aggregationMetric.name,
                  ),
                  if (startDateTime != null && endDateTime != null) ...[
                    const SizedBox(height: 12),
                    AggregateInfoRow(
                      icon: AppIcons.time,
                      label: AppTexts.startTime,
                      value: DateFormatter.formatDateTime(startDateTime),
                    ),
                    const SizedBox(height: 12),
                    AggregateInfoRow(
                      icon: AppIcons.time,
                      label: AppTexts.endTime,
                      value: DateFormatter.formatDateTime(endDateTime),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
