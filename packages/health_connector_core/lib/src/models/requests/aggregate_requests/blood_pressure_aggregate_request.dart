part of 'aggregate_request.dart';

/// Request to perform an aggregation query on blood pressure health records.
///
/// This specialized request extends [AggregateRequest] and includes an
/// additional field to store the specific blood pressure data type
/// (systolic or diastolic) being aggregated.
///
/// {@category Core API}
@sinceV1_2_0
@supportedOnHealthConnect
@internalUse
@immutable
final class BloodPressureAggregateRequest extends AggregateRequest<Pressure> {
  static const _bloodPressureDataTypes = [
    HealthDataType.diastolicBloodPressure,
    HealthDataType.systolicBloodPressure,
  ];

  /// Creates a blood pressure aggregation request.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The blood pressure data type to aggregate (must be either
  ///   systolic or diastolic blood pressure)
  /// - [aggregationMetric]: The type of aggregation to perform
  /// - [startTime]: Inclusive start of the time range
  /// - [endTime]: Exclusive end of the time range
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [dataType] is not a valid blood pressure type
  /// - [ArgumentError] if [endTime] is before [startTime]
  /// - [ArgumentError] if [dataType] does not support [aggregationMetric]
  BloodPressureAggregateRequest({
    required super.dataType,
    required super.aggregationMetric,
    required super.startTime,
    required super.endTime,
  }) {
    require(
      condition: _bloodPressureDataTypes.contains(dataType),
      value: dataType,
      name: 'dataType',
      message:
          '$dataType is not a valid blood pressure type for aggregation. '
          'Must be one of: $_bloodPressureDataTypes.',
    );
  }

  @override
  String toString() {
    return 'BloodPressureAggregateRequest('
        'dataType=$dataType, '
        'aggregationMetric=$aggregationMetric, '
        'spanDays=${endTime.difference(startTime).inDays}'
        ')';
  }
}
