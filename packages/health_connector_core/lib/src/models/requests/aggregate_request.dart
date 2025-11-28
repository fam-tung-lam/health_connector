import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/health_connector_core.dart' show require;
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/requests/aggregation_metric.dart'
    show AggregationMetric;
import 'package:health_connector_core/src/models/requests/request.dart'
    show Request;
import 'package:health_connector_core/src/utils/datetime.dart';
import 'package:health_connector_core/src/utils/validation.dart'
    show requireEndTimeAfterStartTime;
import 'package:meta/meta.dart' show immutable, internal;

/// Request to perform an aggregation query on health records.
@sinceV1_0_0
@immutable
final class AggregateRequest<R extends HealthRecord, U extends MeasurementUnit>
    extends Request {
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
  @internal
  factory AggregateRequest({
    required HealthDataType<R, U> dataType,
    required AggregationMetric aggregationMetric,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    require(
      dataType.supportedAggregationMetrics.contains(aggregationMetric),
      '$dataType does not support aggregation with '
      'metric ${aggregationMetric.name}',
    );
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);

    return AggregateRequest._(
      dataType: dataType,
      aggregationMetric: aggregationMetric,
      startTime: startTime,
      endTime: endTime,
    );
  }

  const AggregateRequest._({
    required this.dataType,
    required this.aggregationMetric,
    required this.startTime,
    required this.endTime,
  });

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

  @override
  String toString() =>
      'AggregateRequest('
      'dataType: $dataType, '
      'aggregationMetric: ${aggregationMetric.name}, '
      'time_range: ${formatTimeRange(startTime: startTime, endTime: endTime)}'
      ')';
}
