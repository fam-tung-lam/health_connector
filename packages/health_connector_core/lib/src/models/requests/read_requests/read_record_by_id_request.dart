part of 'read_records_request.dart';

/// Request to read a single health record by its ID.
///
/// {@category Core API}
@sinceV1_0_0
@internalUse
@immutable
final class ReadRecordByIdRequest<R extends HealthRecord>
    extends ReadRecordsRequest {
  /// Creates a request to read a health record by its ID.
  ///
  /// This ID should come from a previous write or reading operation. IDs are
  /// platform-assigned and should not be manually created.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to read.
  /// - [id]: The unique identifier of the record to read.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [id] is [HealthRecordId.none]
  ReadRecordByIdRequest({
    required super.dataType,
    required this.id,
  }) {
    require(
      condition: id != HealthRecordId.none,
      value: id,
      name: 'id',
      message: 'Record ID cannot be HealthRecordId.none',
    );
  }

  /// The unique identifier of the record to read.
  final HealthRecordId id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadRecordByIdRequest<R> &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          id == other.id;

  @override
  int get hashCode => dataType.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'ReadRecordByIdRequest(dataType=$dataType, id=$id)';
  }
}
