import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV2_0_0;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord, HealthRecordId;
import 'package:health_connector_core/src/models/requests/delete_records_request.dart'
    show DeleteRecordsByIdsRequest, DeleteRecordsInTimeRangeRequest;
import 'package:meta/meta.dart' show internal;

/// Interface that adds deletion capability to a health data type.
///
/// Health data types that support deletion should implement this interface
/// to provide type-safe factory methods for creating deletion requests.
///
/// ## Data Ownership
///
/// Apps can only delete health records that they created.
/// Both deletion methods will fail if attempting to delete records from
/// other sources.
///
/// ## Example
///
/// ```dart
/// // Delete specific records by ID
/// final request1 = HealthDataType.steps.deleteByIds([id1, id2]);
/// await connector.deleteRecords(request1);
///
/// // Delete records in a time range
/// final request2 = HealthDataType.steps.deleteInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// await connector.deleteRecords(request2);
/// ```
@sinceV2_0_0
@internal
abstract interface class DeletableHealthDataType<R extends HealthRecord> {
  /// Creates a request to delete specific records by their IDs.
  ///
  /// Use this when you want to delete precise records and have their IDs
  /// (e.g., from a previous read operation).
  ///
  /// ## Parameters
  ///
  /// - [recordIds]: List of unique record identifiers to delete
  ///
  /// ## Returns
  ///
  /// A [DeleteRecordsByIdsRequest]
  ///
  /// ## Throws
  /// - [ArgumentError] if [recordIds] is empty
  /// - [ArgumentError] if any record ID is [HealthRecordId.none]
  DeleteRecordsByIdsRequest<R> deleteByIds(List<HealthRecordId> recordIds);

  /// Creates a request to delete all records within a time range.
  ///
  /// Use this for bulk deletion of records within a specific time period.
  /// Only records created by your app will be deleted.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: Inclusive start of the time range
  /// - [endTime]: Inclusive end of the time range
  ///
  /// ## Returns
  ///
  /// A [DeleteRecordsInTimeRangeRequest]
  ///
  /// ## Throws
  /// - [ArgumentError] if [endTime] is before [startTime]
  DeleteRecordsInTimeRangeRequest<R> deleteInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
  });
}
