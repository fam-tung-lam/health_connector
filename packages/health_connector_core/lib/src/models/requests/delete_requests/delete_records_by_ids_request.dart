part of 'delete_records_request.dart';

/// Request to delete specific health records by their IDs.
///
/// This request type allows precise deletion of individual records when
/// you have their unique identifiers.
///
/// {@category Core API}
@sinceV3_2_0
@internalUse
@immutable
final class DeleteRecordsByIdsRequest extends DeleteRecordsRequest {
  /// Creates a request to delete specific health records by their IDs.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to delete
  /// - [recordIds]: List of unique record identifiers to delete
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if any record ID is [HealthRecordId.none]
  DeleteRecordsByIdsRequest({
    required super.dataType,
    required this.recordIds,
  }) {
    require(
      condition: recordIds.every((id) => id != HealthRecordId.none),
      value: recordIds,
      name: 'recordIds',
      message:
          'Record ID to delete cannot be HealthRecordId.none. '
          'Found invalid ID in `recordIds` list.',
    );
  }

  /// List of unique record identifiers to delete.
  ///
  /// All IDs must be valid (not [HealthRecordId.none]) and should come from
  /// previous write operations or read queries.
  final List<HealthRecordId> recordIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteRecordsByIdsRequest &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          const ListEquality<HealthRecordId>().equals(
            recordIds,
            other.recordIds,
          );

  @override
  int get hashCode => dataType.hashCode ^ recordIds.hashCode;

  @override
  String toString() {
    return 'DeleteRecordsByIdsRequest('
        'dataType=$dataType, '
        'idsCount=${recordIds.length}'
        ')';
  }
}
