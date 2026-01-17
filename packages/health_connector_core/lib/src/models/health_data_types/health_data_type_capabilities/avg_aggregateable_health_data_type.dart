import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/annotations/since.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/requests/aggregate_requests/aggregate_request.dart'
    show AggregateRequest;

/// Interface that adds average aggregation capability to a health data type.
@sinceV1_0_0
@internalUse
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
