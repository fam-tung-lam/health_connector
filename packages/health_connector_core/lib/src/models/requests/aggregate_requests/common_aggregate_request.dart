part of 'aggregate_request.dart';

/// Common aggregate request for standard health data types.
///
/// This is the default implementation for most health data types that don't
/// require specialized aggregation handling.
///
/// {@category Core API}
@sinceV1_2_0
@internalUse
@immutable
final class CommonAggregateRequest<
  R extends HealthRecord,
  U extends MeasurementUnit
>
    extends AggregateRequest<R, U> {
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
  CommonAggregateRequest({
    required super.dataType,
    required super.aggregationMetric,
    required super.startTime,
    required super.endTime,
  }) : super() {
    require(
      condition: dataType.supportedAggregationMetrics.contains(
        aggregationMetric,
      ),
      value: aggregationMetric,
      name: 'aggregationMetric',
      message:
          '$dataType does not support aggregation with '
          'metric ${aggregationMetric.name}',
    );
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  @override
  String toString() {
    return 'CommonAggregateRequest('
        'dataType=$dataType, '
        'aggregationMetric=$aggregationMetric, '
        'spanDays=${endTime.difference(startTime).inDays}'
        ')';
  }
}
