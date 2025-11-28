import 'package:health_connector_annotation/health_connector_annotation.dart'
    show internalUse, sinceV1_0_0;
import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart'
    show HealthConnectorException;
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_platform.dart'
    show HealthPlatformStatus;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord, HealthRecordId;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/permissions/permission.dart'
    show Permission;
import 'package:health_connector_core/src/models/requests/aggregate_request.dart'
    show AggregateRequest;
import 'package:health_connector_core/src/models/requests/read_record_request.dart'
    show ReadRecordRequest;
import 'package:health_connector_core/src/models/requests/read_records_request.dart'
    show ReadRecordsRequest;
import 'package:health_connector_core/src/models/responses/aggregate_response.dart'
    show AggregateResponse;
import 'package:health_connector_core/src/models/responses/permission_request_result.dart'
    show PermissionRequestResult;
import 'package:health_connector_core/src/models/responses/read_records_response.dart'
    show ReadRecordsResponse;

/// Platform client interface for interacting with native health platforms.
///
/// This interface defines the contract for platform-specific implementations
/// that communicate with Health Connect (Android) or HealthKit (iOS) to read,
/// write, and manage health data.
///
/// Implementations of this interface handle:
/// - Permission management
/// - Reading and writing health records
/// - Aggregating health data
/// - Deleting health records
/// - Querying platform capabilities and features
@sinceV1_0_0
@internalUse
abstract interface class HealthConnectorPlatformClient {
  /// Queries the native platform to determine health platform availability.
  ///
  /// Returns the current status of the health platform on the device,
  /// indicating whether it's available, installed, or requires an update.
  ///
  /// ## Returns
  ///
  /// A [HealthPlatformStatus] indicating the availability state of the
  /// health platform.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the platform request fails
  ///   or returns invalid data
  Future<HealthPlatformStatus> getHealthPlatformStatus();

  /// Requests permissions from the native platform.
  ///
  /// Prompts the user to grant the specified permissions for reading and/or
  /// writing health data. The user may grant, deny, or dismiss the permission
  /// dialog.
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

  /// Reads a single health record by ID.
  ///
  /// Fetches a specific health record from the platform using its unique
  /// identifier. The record ID should come from a previous write operation
  /// or from reading a list of records.
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
  Future<R?> readRecord<R extends HealthRecord>(ReadRecordRequest<R> request);

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
  /// A [ReadRecordsResponse] containing the records in the current page
  /// and an optional request for fetching the next page.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the platform request fails
  ///   or returns invalid data
  Future<ReadRecordsResponse<R>> readRecords<R extends HealthRecord>(
    ReadRecordsRequest<R> request,
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
  /// Modifies an existing health record identified by its ID. The record
  /// must have been previously written to the platform and have a valid
  /// platform-assigned ID.
  ///
  /// ## Parameters
  ///
  /// - [record]: The health record to update. Must have a valid existing
  ///   [HealthRecordId] (not [HealthRecordId.none]).
  ///
  /// ## Returns
  ///
  /// The [HealthRecordId] of the updated record (same as the input ID).
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if:
  ///   - The platform request fails
  ///   - The record ID is invalid or doesn't exist
  ///   - The record data is invalid
  ///   - Required permissions are not granted
  ///   - The data type is not supported for updating
  Future<HealthRecordId> updateRecord<R extends HealthRecord>(R record);

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
  /// An [AggregateResponse] containing the aggregated value in the
  /// appropriate measurement unit.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if:
  ///   - The platform request fails
  ///   - The aggregation metric is not supported by the data type
  ///   - Required permissions are not granted
  ///   - The time range is invalid
  Future<AggregateResponse<R, U>>
  aggregate<R extends HealthRecord, U extends MeasurementUnit>(
    AggregateRequest<R, U> request,
  );

  /// Deletes records within a time range via platform client.
  ///
  /// Removes all health records of the specified type that fall within the
  /// given time range. This operation is permanent and cannot be undone.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health records to delete
  /// - [startTime]: Inclusive start of the time range
  /// - [endTime]: Exclusive end of the time range
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if:
  ///   - The platform request fails
  ///   - Required permissions are not granted
  ///   - The time range is invalid
  Future<void> deleteRecords<R extends HealthRecord>({
    required HealthDataType<R, MeasurementUnit> dataType,
    required DateTime startTime,
    required DateTime endTime,
  });

  /// Deletes specific records by IDs via platform client.
  ///
  /// Removes specific health records identified by their IDs. This operation
  /// is permanent and cannot be undone. Only records that were created by
  /// this app can typically be deleted.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health records to delete
  /// - [recordIds]: The list of record IDs to delete
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if:
  ///   - The platform request fails
  ///   - Required permissions are not granted
  ///   - One or more record IDs are invalid or don't exist
  ///   - The app doesn't have permission to delete the specified records
  Future<void> deleteRecordsByIds<R extends HealthRecord>({
    required HealthDataType<R, MeasurementUnit> dataType,
    required List<HealthRecordId> recordIds,
  });
}
