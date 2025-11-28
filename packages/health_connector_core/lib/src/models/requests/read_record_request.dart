import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord, HealthRecordId;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/requests/request.dart'
    show Request;
import 'package:health_connector_core/src/utils/validation.dart' show require;
import 'package:meta/meta.dart' show immutable, internal;

/// Request to read a single health record by its ID.
@sinceV1_0_0
@immutable
final class ReadRecordRequest<R extends HealthRecord> extends Request {
  /// Creates a request to read a health record by its ID.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to read
  /// - [id]: The unique identifier of the record to read
  ///
  /// ## Throws
  /// - [ArgumentError] if [id] is [HealthRecordId.none]
  @internal
  factory ReadRecordRequest({
    required HealthDataType<R, MeasurementUnit> dataType,
    required HealthRecordId id,
  }) {
    require(
      id != HealthRecordId.none,
      'Record ID cannot be HealthRecordId.none',
    );

    return ReadRecordRequest._(dataType: dataType, id: id);
  }

  const ReadRecordRequest._({required this.dataType, required this.id});

  /// The type of health data to read.
  ///
  /// This determines which platform API to use and how to deserialize the
  /// response.
  final HealthDataType<R, MeasurementUnit> dataType;

  /// The unique identifier of the record to read.
  ///
  /// This ID should come from a previous write operation or from reading
  /// a list of records. IDs are platform-assigned and cannot be manually
  /// created.
  final HealthRecordId id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadRecordRequest<R> &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          id == other.id;

  @override
  int get hashCode => dataType.hashCode ^ id.hashCode;

  @override
  String toString() =>
      'ReadRecordRequest('
      'dataType: $dataType, '
      'id: $id'
      ')';
}
