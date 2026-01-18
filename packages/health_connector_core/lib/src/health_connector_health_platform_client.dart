import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/config/health_connector_config.dart';
import 'package:health_connector_core/src/models/exceptions/health_connector_error_code.dart';
import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart';
import 'package:health_connector_core/src/models/health_data_sync/health_data_sync_result.dart';
import 'package:health_connector_core/src/models/health_data_sync/health_data_sync_token.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';
import 'package:health_connector_core/src/models/permissions/permission.dart';
import 'package:health_connector_core/src/models/requests/aggregate_requests/aggregate_request.dart';
import 'package:health_connector_core/src/models/requests/delete_records_request.dart';
import 'package:health_connector_core/src/models/requests/read_records_request.dart';
import 'package:health_connector_core/src/models/responses/permission_request_result.dart';
import 'package:health_connector_core/src/models/responses/read_records_response.dart';

/// Platform client interface for interacting with native health platforms.
///
/// This interface defines the contract for platform-specific implementations
/// that communicate with health platforms to read, write, and
/// manage health data.
///
/// {@category Core API}
@sinceV1_0_0
@internalUse
abstract interface class HealthConnectorPlatformClient {
  /// The configuration used by this client.
  @sinceV2_0_0
  HealthConnectorConfig get config;

  /// Requests permissions from the native platform.
  ///
  /// ## Parameters
  ///
  /// - [permissions]: The list of permissions to request. Each permission
  ///   specifies a data type and access level (read/write).
  ///
  /// ## Returns
  ///
  /// A list of [PermissionRequestResult] objects, one for each requested
  /// permission, indicating whether it was granted, denied, or has an
  /// unknown status.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the platform request fails
  ///   or returns invalid data
  Future<List<PermissionRequestResult>> requestPermissions(
    List<Permission> permissions,
  );

  /// Gets the current permission status for a specific permission.
  ///
  /// ## Parameters
  ///
  /// - [permission]: The permission to check status for
  ///
  /// ## Returns
  ///
  /// The current [PermissionStatus] of the specified permission
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if an error occurs while checking status
  @sinceV2_0_0
  Future<PermissionStatus> getPermissionStatus(Permission permission);

  /// Reads a single health record by ID.
  ///
  /// ## Parameters
  ///
  /// - [request]: The read request containing the data type and record ID
  ///
  /// ## Returns
  ///
  /// The health record if found, or `null` if no record exists with the
  /// specified ID.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the platform request fails
  ///   or returns invalid data
  Future<R?> readRecord<R extends HealthRecord>(
    ReadRecordByIdRequest<R> request,
  );

  /// Reads multiple health records within a time range.
  ///
  /// Fetches health records that fall within the specified time range.
  /// Results are paginated and can be filtered by data origin.
  ///
  /// ## Parameters
  ///
  /// - [request]: The read request containing the data type, time range,
  ///   pagination parameters, and optional data origin filters
  ///
  /// ## Returns
  ///
  /// A [ReadRecordsInTimeRangeResponse] containing the records in the current
  /// page and an optional request for fetching the next page.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the platform request fails
  ///   or returns invalid data
  Future<ReadRecordsInTimeRangeResponse<R>> readRecords<R extends HealthRecord>(
    ReadRecordsInTimeRangeRequest<R> request,
  );

  /// Writes a single health record to the platform.
  ///
  /// Creates a new health record in the platform's data store. The record
  /// should have [HealthRecordId.none] as its ID, which will be replaced
  /// with a platform-assigned UUID upon successful write.
  ///
  /// ## Parameters
  ///
  /// - [record]: The health record to write. Must have a valid data type
  ///   and all required fields populated.
  ///
  /// ## Returns
  ///
  /// The platform-assigned [HealthRecordId] for the newly created record.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if:
  ///   - The platform request fails
  ///   - The record data is invalid
  ///   - Required permissions are not granted
  ///   - The data type is not supported for writing
  Future<HealthRecordId> writeRecord<R extends HealthRecord>(R record);

  /// Writes multiple health records atomically.
  ///
  /// Creates multiple health records in a single transaction. If any record
  /// fails to write, the entire operation is rolled back and no records are
  /// written.
  ///
  /// ## Parameters
  ///
  /// - [records]: The list of health records to write. All records should
  ///   have [HealthRecordId.none] as their ID.
  ///
  /// ## Returns
  ///
  /// A list of platform-assigned [HealthRecordId]s for the newly created
  /// records, in the same order as the input records.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if:
  ///   - The platform request fails
  ///   - Any record data is invalid
  ///   - Required permissions are not granted
  ///   - Any data type is not supported for writing
  ///   - The atomic transaction fails
  Future<List<HealthRecordId>> writeRecords<R extends HealthRecord>(
    List<R> records,
  );

  /// Updates a single health record on the platform.
  ///
  /// ## Parameters
  ///
  /// - [record]: The health record to update. Must have a valid existing
  ///   [HealthRecordId] (not [HealthRecordId.none]).
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorErrorCode.unsupportedOperation] on iOS because HealthKit
  ///   uses an immutable data model
  /// - [HealthConnectorException] with other error codes if:
  ///   - The platform request fails
  ///   - The record ID is invalid or doesn't exist
  ///   - Required permissions are not granted
  @supportedOnHealthConnect
  Future<void> updateRecord<R extends HealthRecord>(R record);

  /// Updates multiple health records on the platform.
  ///
  /// ## Parameters
  ///
  /// - [records]: The health records to update. Must have a valid existing
  ///   [HealthRecordId] (not [HealthRecordId.none]).
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorErrorCode.unsupportedOperation] on iOS because HealthKit
  ///   uses an immutable data model
  /// - [HealthConnectorException] with other error codes if:
  ///   - The platform request fails
  ///   - The record ID is invalid or doesn't exist
  ///   - Required permissions are not granted
  @supportedOnHealthConnect
  Future<void> updateRecords<R extends HealthRecord>(List<R> records);

  /// Performs an aggregation query over health records.
  ///
  /// Computes aggregated statistics (e.g., sum, average, min, max) over
  /// health records within a specified time range. The aggregation metric
  /// must be supported by the data type.
  ///
  /// ## Parameters
  ///
  /// - [request]: The aggregation request containing the data type,
  ///   aggregation metric, and time range
  ///
  /// ## Returns
  ///
  /// An the aggregated value in the appropriate measurement unit.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if:
  ///   - The platform request fails
  ///   - The aggregation metric is not supported by the data type
  ///   - Required permissions are not granted
  ///   - The time range is invalid
  Future<U> aggregate<R extends HealthRecord, U extends MeasurementUnit>(
    AggregateRequest<R, U> request,
  );

  /// Deletes health records based on the provided request.
  ///
  /// ## Parameters
  ///
  /// - [request]: A deletion request
  ///
  /// ## Returns
  ///
  /// A [Future] that completes when the deletion operation finishes.
  /// This operation is permanent and cannot be undone.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted]
  ///   if delete/write permission has not been granted
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if the request contains
  ///   invalid data
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted]
  ///   if attempting to delete records not created by this app
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   if an unexpected error occurs
  @sinceV2_0_0
  Future<void> deleteRecords(DeleteRecordsRequest request);

  /// Synchronizes health data from the health platform using incremental
  /// change tracking.
  ///
  /// ## Parameters
  ///
  /// - [dataTypes]: Health data types to synchronize
  /// - [syncToken]: Token from previous sync, or null for initial sync
  ///
  /// ## Returns
  ///
  /// [HealthDataSyncResult] containing:
  /// - upsertedRecords: Records added/updated since last sync
  /// - deletedRecordIds: IDs of records deleted since last sync
  /// - hasMore: Whether pagination is needed
  /// - nextSyncToken: Token for next synchronization request
  ///
  /// ## Initial Sync (syncToken: null)
  ///
  /// Establishes a baseline at the current moment. Returns empty records.
  ///
  /// ## Incremental Sync (syncToken: provided)
  ///
  /// Returns changes since the token was created.
  ///
  /// ## Throws
  ///
  /// - [InvalidArgumentException] if token has expired
  /// - [AuthorizationException] if permissions are missing
  /// - [InvalidArgumentException] if dataTypes don't match token scope
  @sinceV3_0_0
  Future<HealthDataSyncResult> synchronize({
    required List<HealthDataType> dataTypes,
    required HealthDataSyncToken? syncToken,
  });
}
