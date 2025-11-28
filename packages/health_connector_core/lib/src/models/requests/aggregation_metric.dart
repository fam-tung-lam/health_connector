import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;

/// Defines the type of aggregation to perform on health data.
///
/// Each aggregation type computes a different metric over a set of health
/// records within a specified time range.
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

  /// Count of data points (records) in the dataset.
  ///
  /// Returns the number of health records that exist within the specified
  /// time range, regardless of their values.
  count,
}
