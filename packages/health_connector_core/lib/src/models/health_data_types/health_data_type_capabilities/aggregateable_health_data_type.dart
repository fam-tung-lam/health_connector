import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/annotations/since.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/permissions/permission.dart'
    show HealthDataPermission;
import 'package:health_connector_core/src/models/requests/aggregate_requests/aggregate_request.dart'
    show AggregateRequest;

/// Interface that adds aggregation capability to a health data type.
@sinceV3_2_0
@internalUse
abstract interface class AggregatableHealthDataType<U extends MeasurementUnit> {
  /// The read permission for this health data type.
  ///
  /// Aggregation operation require a read permission.
  HealthDataPermission get readPermission;
}

/// Interface that adds average aggregation capability to a health data type.
@sinceV1_0_0
@internalUse
abstract interface class AvgAggregatableHealthDataType<
  U extends MeasurementUnit
>
    implements AggregatableHealthDataType<U> {
  /// Creates a request to compute the average value over a time range.
  ///
  /// Returns the mean (average) of all values for this data type within the
  /// specified time range.
  AggregateRequest<U> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  });
}

/// Interface that adds maximum aggregation capability to a health data type.
@sinceV1_0_0
@internalUse
abstract interface class MaxAggregatableHealthDataType<
  U extends MeasurementUnit
>
    implements AggregatableHealthDataType<U> {
  /// Creates a request to find the maximum value over a time range.
  ///
  /// Returns the highest value for this data type within the specified
  /// time range.
  AggregateRequest<U> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  });
}

/// Interface that adds minimum aggregation capability to a health data type.
@sinceV1_0_0
@internalUse
abstract interface class MinAggregatableHealthDataType<
  U extends MeasurementUnit
>
    implements AggregatableHealthDataType<U> {
  /// Creates a request to find the minimum value over a time range.
  ///
  /// Returns the lowest value for this data type within the specified
  /// time range.
  AggregateRequest<U> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  });
}

/// Interface that adds sum aggregation capability to a health data type.
@sinceV1_0_0
@internalUse
abstract interface class SumAggregatableHealthDataType<
  U extends MeasurementUnit
>
    implements AggregatableHealthDataType<U> {
  /// Creates a request to sum values over a time range.
  ///
  /// Returns the total sum of all values for this data type within the
  /// specified time range.
  AggregateRequest<U> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  });
}
