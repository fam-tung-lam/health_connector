import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0;

/// Defines the type of aggregation to perform on health data.
///
/// {@category Core API}
@sinceV1_0_0
enum AggregationMetric {
  /// Sum of all values in the time range.
  ///
  /// Only meaningful for cumulative data types like steps, distance, or
  /// calories burned.
  sum,

  /// Average (mean) value across all data points.
  ///
  /// Meaningful for both cumulative and measurement data types.
  avg,

  /// Minimum value in the dataset.
  ///
  /// Useful for finding the lowest recorded value in a time range.
  min,

  /// Maximum value in the dataset.
  ///
  /// Useful for finding the highest recorded value in a time range.
  max,
}
