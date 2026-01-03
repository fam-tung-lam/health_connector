import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0, sinceV1_2_0, internalUse, supportedOnHealthConnect;
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit, Pressure;
import 'package:health_connector_core/src/models/requests/aggregation_metric.dart'
    show AggregationMetric;
import 'package:health_connector_core/src/models/requests/request.dart'
    show Request;
import 'package:health_connector_core/src/utils/validation_utils.dart'
    show requireEndTimeAfterStartTime, require;
import 'package:meta/meta.dart' show immutable;

/// Request to perform an aggregation query on health records.
@sinceV1_0_0
@internalUse
@immutable
sealed class AggregateRequest<R extends HealthRecord, U extends MeasurementUnit>
    extends Request {
  /// The type of health data to aggregate.
  ///
  /// This determines:
  /// - Which health record (R) are considered in the aggregation
  /// - The type of the aggregated value (V)
  /// - Which aggregation operations are supported
  final HealthDataType<R, U> dataType;

  /// The type of aggregation to perform.
  ///
  /// See [AggregationMetric] for available options and their semantics.
  final AggregationMetric aggregationMetric;

  /// Inclusive start of the time range.
  ///
  /// Only records with timestamps >= this value are included in aggregation.
  final DateTime startTime;

  /// Exclusive end of the time range.
  ///
  /// Only records with timestamps < this value are included in aggregation.
  final DateTime endTime;

  /// Creates a request to aggregate health records.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to aggregate
  /// - [aggregationMetric]: The type of aggregation to perform
  /// - [startTime]: Inclusive start of the time range
  /// - [endTime]: Exclusive end of the time range
  const AggregateRequest({
    required this.dataType,
    required this.aggregationMetric,
    required this.startTime,
    required this.endTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AggregateRequest &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          aggregationMetric == other.aggregationMetric &&
          startTime == other.startTime &&
          endTime == other.endTime;

  @override
  int get hashCode =>
      dataType.hashCode ^
      aggregationMetric.hashCode ^
      startTime.hashCode ^
      endTime.hashCode;
}

/// Common aggregate request for standard health data types.
///
/// This is the default implementation for most health data types that don't
/// require specialized aggregation handling.
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
  /// - [ArgumentError] if [endTime] before [startTime]
  /// - [ArgumentError] if [dataType] does not support [aggregationMetric]
  CommonAggregateRequest({
    required super.dataType,
    required super.aggregationMetric,
    required super.startTime,
    required super.endTime,
  }) : super() {
    require(
      dataType.supportedAggregationMetrics.contains(aggregationMetric),
      '$dataType does not support aggregation with '
      'metric ${aggregationMetric.name}',
    );
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }
}

/// Request to perform an aggregation query on blood pressure health records.
///
/// This specialized request extends [AggregateRequest] and includes an
/// additional field to store the specific blood pressure data type
/// (systolic or diastolic) being aggregated.
@sinceV1_2_0
@supportedOnHealthConnect
@internalUse
@immutable
final class BloodPressureAggregateRequest
    extends AggregateRequest<HealthRecord, Pressure> {
  static const _bloodPressureHealthDataTypes = [
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
  }) : super() {
    require(
      dataType.supportedAggregationMetrics.contains(aggregationMetric),
      '$dataType does not support aggregation with '
      'metric ${aggregationMetric.name}',
    );
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);

    require(
      _bloodPressureHealthDataTypes.contains(dataType),
      '$dataType is not a valid blood pressure type for aggregation. '
      'Must be one of: $_bloodPressureHealthDataTypes.',
    );
  }
}
