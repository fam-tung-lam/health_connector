import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/requests/aggregate_request.dart'
    show AggregateRequest;
import 'package:meta/meta.dart' show internal;

/// Interface that adds sum aggregation capability to a health data type.
@sinceV1_0_0
@internal
abstract interface class SumAggregatableHealthDataType<
  R extends HealthRecord,
  U extends MeasurementUnit
> {
  /// Creates a request to sum values over a time range.
  ///
  /// Returns the total sum of all values for this data type within the
  /// specified time range.
  AggregateRequest<R, U> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  });
}
