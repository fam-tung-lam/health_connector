import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/requests/aggregate_request.dart'
    show AggregateRequest;
import 'package:meta/meta.dart' show internal;

/// Interface that adds average aggregation capability to a health data type.
@sinceV1_0_0
@internal
abstract interface class AvgAggregatableHealthDataType<
  R extends HealthRecord,
  U extends MeasurementUnit
> {
  /// Creates a request to compute the average value over a time range.
  ///
  /// Returns the mean (average) of all values for this data type within the
  /// specified time range.
  AggregateRequest<R, U> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  });
}
