import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/annotations/since.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord, HealthRecordId;
import 'package:health_connector_core/src/models/permissions/permission.dart'
    show HealthDataPermission;
import 'package:health_connector_core/src/models/requests/delete_records_request.dart'
    show DeleteRecordsByIdsRequest, DeleteRecordsInTimeRangeRequest;

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
@sinceV2_0_0
@internalUse
abstract interface class DeletableHealthDataType<R extends HealthRecord> {
  /// The write permission for this health data type.
  ///
  /// Deletion operation require a write permission.
  HealthDataPermission get writePermission;
}

/// Interface for health data types that support deleting records by ID.
@sinceV2_0_0
@internalUse
abstract interface class DeletableByIdsHealthDataType<R extends HealthRecord>
    implements DeletableHealthDataType<R> {
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
  ///
  /// - [ArgumentError] if [recordIds] is empty
  /// - [ArgumentError] if any record ID is [HealthRecordId.none]
  DeleteRecordsByIdsRequest deleteByIds(List<HealthRecordId> recordIds);
}

/// Interface for health data types that support deleting records in a time
/// range.
@sinceV2_0_0
@internalUse
abstract interface class DeletableInTimeRangeHealthDataType<
  R extends HealthRecord
>
    implements DeletableHealthDataType<R> {
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
  ///
  /// - [ArgumentError] if [endTime] is before [startTime]
  DeleteRecordsInTimeRangeRequest deleteInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
  });
}
