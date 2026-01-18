import 'package:health_connector_core/src/annotations/annotations.dart'
    show
        internalUse,
        sinceV1_0_0,
        sinceV1_2_0,
        sinceV3_1_0,
        supportedOnHealthConnect;
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/aggregateable_health_data_type.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show ActivityIntensityType, HealthRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit, Pressure, TimeDuration;
import 'package:health_connector_core/src/models/requests/aggregate_requests/aggregation_metric.dart'
    show AggregationMetric;
import 'package:health_connector_core/src/models/requests/request.dart'
    show Request;
import 'package:health_connector_core/src/utils/validation_utils.dart'
    show requireEndTimeAfterStartTime, require;
import 'package:meta/meta.dart';

part 'activity_intensity_aggregate_request.dart';
part 'blood_pressure_aggregate_request.dart';
part 'standard_aggregate_request.dart';

/// Base request class to perform an aggregation query on health records.
///
/// {@category Core API}
@sinceV1_0_0
@internalUse
@immutable
sealed class AggregateRequest<U extends MeasurementUnit> extends Request {
  /// The type of health data to aggregate.
  final HealthDataType<HealthRecord, U> dataType;

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
  AggregateRequest({
    required this.dataType,
    required this.aggregationMetric,
    required this.startTime,
    required this.endTime,
  }) {
    require(
      condition: dataType is AggregatableHealthDataType,
      value: dataType,
      name: 'dataType',
      message: '$dataType is not aggregatable.',
    );
    require(
      condition: dataType.supportedAggregationMetrics.contains(
        aggregationMetric,
      ),
      value: aggregationMetric,
      name: 'aggregationMetric',
      message:
          '$dataType does not support aggregation with '
          'metric $aggregationMetric',
    );
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

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
