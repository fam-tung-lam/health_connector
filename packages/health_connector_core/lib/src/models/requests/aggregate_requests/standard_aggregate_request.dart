part of 'aggregate_request.dart';

/// Standard aggregate request for standard health data types.
///
/// This is the default implementation for most health data types that don't
/// require specialized aggregation handling.
///
/// {@category Core API}
@sinceV1_2_0
@internalUse
@immutable
final class StandardAggregateRequest<U extends MeasurementUnit>
    extends AggregateRequest<U> {
  /// Creates a request to aggregate health records.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to aggregate
  /// - [aggregationMetric]: The type of aggregation to perform
  /// - [startTime]: Inclusive start of the time range
  /// - [endTime]: Exclusive end of the time range
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] before [startTime]
  /// - [ArgumentError] if [dataType] does not support [aggregationMetric]
  StandardAggregateRequest({
    required super.dataType,
    required super.aggregationMetric,
    required super.startTime,
    required super.endTime,
  });

  @override
  String toString() {
    return 'CommonAggregateRequest('
        'dataType=$dataType, '
        'aggregationMetric=$aggregationMetric, '
        'spanDays=${endTime.difference(startTime).inDays}'
        ')';
  }
}
