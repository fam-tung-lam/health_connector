import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart' show AggregationMetric;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [AggregationMetric] to provide UI-related properties.
extension AggregationMetricUI on AggregationMetric {
  /// Returns the display name for this aggregation metric.
  String get displayName {
    return switch (this) {
      AggregationMetric.sum => AppTexts.sum,
      AggregationMetric.avg => AppTexts.average,
      AggregationMetric.min => AppTexts.minimum,
      AggregationMetric.max => AppTexts.maximum,
    };
  }

  /// Returns the icon for this aggregation metric.
  IconData get icon {
    return switch (this) {
      AggregationMetric.sum => AppIcons.sum,
      AggregationMetric.avg => AppIcons.avg,
      AggregationMetric.min => AppIcons.min,
      AggregationMetric.max => AppIcons.max,
    };
  }
}
