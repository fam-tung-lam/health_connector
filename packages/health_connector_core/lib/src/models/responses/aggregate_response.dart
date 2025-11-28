import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/responses/response.dart'
    show Response;
import 'package:meta/meta.dart' show immutable;

/// Response from an aggregation query.
///
/// This response contains the aggregated value computed over health records
/// within a time range, along with metadata about the aggregation.
@sinceV1_0_0
@immutable
final class AggregateResponse<R extends HealthRecord, U extends MeasurementUnit>
    extends Response {
  const AggregateResponse(this.value);

  /// The aggregated value.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Steps (scalar)
  /// final stepsResponse = await connector.aggregate(stepsRequest);
  /// final totalSteps = stepsResponse.value; // Numeric
  /// print('Total steps: ${totalSteps.value}');
  ///
  /// // Weight (unit)
  /// final weightResponse = await connector.aggregate(weightRequest);
  /// final avgWeight = weightResponse.value; // Mass
  /// print('${avgWeight.inKilograms} kg');
  /// ```
  final U value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AggregateResponse &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'AggregateResponse(value: $value)';
}
