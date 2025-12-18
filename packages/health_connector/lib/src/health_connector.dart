import 'dart:io' show Platform;

import 'package:health_connector/src/health_connector_impl.dart'
    show HealthConnectorImpl;
import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        AggregateResponse,
        HealthConnectorConfig,
        HealthPlatformFeaturePermission,
        PermissionStatus,
        HealthDataPermission,
        HealthConnectorException,
        HealthConnectorErrorCode,
        HealthDataType,
        HealthPlatform,
        HealthPlatformFeature,
        HealthPlatformFeatureStatus,
        HealthPlatformStatus,
        HealthRecord,
        HealthRecordId,
        MeasurementUnit,
        Permission,
        PermissionRequestResult,
        PlatformSpecificBehaviors,
        ReadRecordRequest,
        ReadRecordsRequest,
        ReadRecordsResponse,
        supportedOnHealthConnect;
import 'package:health_connector_hc_android/health_connector_hc_android.dart'
    show HealthConnectorHCClient;
import 'package:health_connector_hk_ios/health_connector_hk_ios.dart'
    show HealthConnectorHKClient;
import 'package:health_connector_logger/health_connector_logger.dart';

/// Main entry point for interacting with platform-specific health APIs.
///
/// [HealthConnector] provides a unified interface for accessing health data
/// across different health platforms.
///
/// This class uses a factory pattern to create instances. Use
/// [HealthConnector.create] to obtain an instance.
abstract interface class HealthConnector {
  /// The tag used for logging in static methods.
  static const String _tag = 'HealthConnector';

  /// Creates a new [HealthConnector] instance.
  ///
  /// This factory ensures that the instance is properly configured for the
  /// current platform. The instance is automatically configured based on the
  /// platform (iOS uses HealthKit, Android uses Health Connect).
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.healthProviderUnavailable]
  ///   if Health platform is unavailable on this device.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.healthProviderNotInstalledOrUpdateRequired]
  ///   if Health platform installation or update is required.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## See
  ///
  /// - [HealthConnector.getHealthPlatformStatus]
  static Future<HealthConnector> create([
    HealthConnectorConfig config = const HealthConnectorConfig(),
  ]) async {
    HealthConnectorLogger.isEnabled = config.isLoggerEnabled;

    final healthPlatform = Platform.isIOS
        ? HealthPlatform.appleHealth
        : HealthPlatform.healthConnect;

    final status = await getHealthPlatformStatus();
    switch (status) {
      case HealthPlatformStatus.unavailable:
        HealthConnectorLogger.error(
          _tag,
          operation: 'create',
          message: 'Health platform unavailable',
          context: {'platform': healthPlatform.name},
        );

        throw HealthConnectorException(
          HealthConnectorErrorCode.healthProviderUnavailable,
          '$healthPlatform is not available.',
        );
      case HealthPlatformStatus.installationOrUpdateRequired:
        HealthConnectorLogger.warning(
          _tag,
          operation: 'create',
          message: 'Health platform installation or update required',
          context: {'platform': healthPlatform.name},
        );

        throw HealthConnectorException(
          HealthConnectorErrorCode.healthProviderNotInstalledOrUpdateRequired,
          '$healthPlatform needs installation or update.',
        );
      case HealthPlatformStatus.available:
        HealthConnectorLogger.info(
          _tag,
          operation: 'create',
          message: 'HealthConnector created successfully',
          context: {'platform': healthPlatform.name},
        );

        final healthPlatformClient = switch (healthPlatform) {
          HealthPlatform.appleHealth => await HealthConnectorHKClient.create(
            config,
          ),
          HealthPlatform.healthConnect => await HealthConnectorHCClient.create(
            config,
          ),
        };

        return HealthConnectorImpl(
          config: config,
          healthPlatform: healthPlatform,
          healthPlatformClient: healthPlatformClient,
        );
    }
  }

  /// Checks the availability status of the health platform.
  ///
  /// This static method can be called before creating a [HealthConnector]
  /// instance to verify that the health platform is ready to use.
  ///
  /// ## Returns
  ///
  /// - [HealthPlatformStatus.available] - Platform is ready to use
  /// - [HealthPlatformStatus.installationOrUpdateRequired] - Health platform
  ///   needs installation or update
  /// - [HealthPlatformStatus.unavailable] - Platform is not available
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## Example
  ///
  /// ```dart
  /// final status = await HealthConnector.getHealthPlatformStatus();
  /// switch (status) {
  ///   case HealthPlatformStatus.available:
  ///     final connector = await HealthConnector.create();
  ///     // Proceed with health data operations
  ///   case HealthPlatformStatus.installationOrUpdateRequired:
  ///     // Show dialog prompting user to install/update health platform
  ///   case HealthPlatformStatus.unavailable:
  ///     // Health platform not supported on this device
  /// }
  /// ```
  static Future<HealthPlatformStatus> getHealthPlatformStatus() async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'getHealthPlatformStatus',
      message: 'Checking health platform status',
    );

    try {
      final healthPlatform = Platform.isIOS
          ? HealthPlatform.appleHealth
          : HealthPlatform.healthConnect;
      final healthPlatformClient = switch (healthPlatform) {
        HealthPlatform.appleHealth => await HealthConnectorHKClient.create(),
        HealthPlatform.healthConnect => await HealthConnectorHCClient.create(),
      };

      final status = await healthPlatformClient.getHealthPlatformStatus();

      HealthConnectorLogger.info(
        _tag,
        operation: 'getHealthPlatformStatus',
        message: 'Health platform status retrieved',
        context: {'status': status.name},
      );

      return status;
    } catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'getHealthPlatformStatus',
        message: 'Failed to get health platform status',
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  /// The health platform being used by this connector.
  HealthPlatform get healthPlatform;

  /// The configuration used by this connector.
  HealthConnectorConfig get config;

  /// Requests the specified permissions from the health platform.
  ///
  /// This method triggers the platform's permission request flow and returns
  /// the results for each requested permission.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidConfiguration] if
  ///    required permissions are missing from platform configuration
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if unexpected error occurs
  ///
  /// ## Example
  ///
  /// ```dart
  /// final connector = await HealthConnector.create();
  ///
  /// // Request multiple permissions
  /// final permissions = [
  ///   HealthDataType.steps.readPermission,
  ///   HealthDataType.steps.writePermission,
  ///   HealthPlatformFeature.readHealthDataHistory.permission,
  ///   HealthPlatformFeature.readHealthDataInBackground.permission,
  ///   // ...
  /// ];
  ///
  /// final results = await connector.requestPermissions(permissions);
  ///
  /// for (final result in results) {
  ///   print('status: ${result.status}');
  /// }
  /// ```
  ///
  /// ## See
  ///
  /// - [HealthDataPermission] and [HealthPlatformFeaturePermission]
  /// - [HealthConnector.getFeatureStatus]
  @PlatformSpecificBehaviors({
    HealthPlatform.appleHealth:
        'Read permissions always return `PermissionStatus.unknown` for '
        'privacy. Feature permissions always return '
        '`PermissionStatus.granted`. Write permissions return actual status.',
    HealthPlatform.healthConnect:
        'Returns actual permission status for all permission types.',
  })
  Future<List<PermissionRequestResult>> requestPermissions(
    List<Permission> permissions,
  );

  /// Gets all permissions that have been granted to the app.
  ///
  /// Returns a list of all currently granted permissions.
  /// Only permissions with [PermissionStatus.granted] status are returned.
  /// This includes both health data permissions and feature permissions.
  ///
  /// ## Returns
  ///
  /// A list of [Permission] objects that have been granted.
  /// The list may be empty if no permissions have been granted.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.unsupportedOperation] if
  ///   this API is not supported on the current platform
  /// - [HealthConnectorException] if the platform request fails or
  ///   returns invalid data
  ///
  /// ## Example
  ///
  /// ```dart
  /// final connector = await HealthConnector.create();
  ///
  /// try {
  ///   final grantedPermissions = await connector.getGrantedPermissions();
  ///
  ///   print('Granted permissions: ${grantedPermissions.length}');
  ///   for (final permission in grantedPermissions) {
  ///     if (permission is HealthDataPermission) {
  ///       print('  - ${permission.dataType} (${permission.accessType})');
  ///     } else if (permission is HealthPlatformFeaturePermission) {
  ///       print('  - Feature: ${permission.feature}');
  ///     }
  ///   }
  /// } on HealthConnectorException catch (e) {
  ///   if (e.code == HealthConnectorErrorCode.unsupportedHealthPlatformApi) {
  ///     // This API is not supported on this platform
  ///     print('getGrantedPermissions() is not available');
  ///   } else {
  ///     print('Error: ${e.message}');
  ///   }
  /// }
  /// ```
  @supportedOnHealthConnect
  Future<List<Permission>> getGrantedPermissions();

  /// Revokes all permissions that have been granted to the app.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.unsupportedOperation] if this API is
  ///   not supported on the current platform
  /// - [HealthConnectorException] if the platform request fails
  ///
  /// ## Example
  ///
  /// ```dart
  /// final connector = await HealthConnector.create();
  ///
  /// try {
  ///   await connector.revokeAllPermissions();
  ///   print('All permissions have been revoked');
  /// } on HealthConnectorException catch (e) {
  ///   if (e.code == HealthConnectorErrorCode.unsupportedHealthPlatformApi) {
  ///     // This API is not supported on this platform
  ///     print('revokeAllPermissions() is not available');
  ///   } else {
  ///     print('Error: ${e.message}');
  ///   }
  /// }
  /// ```
  @supportedOnHealthConnect
  Future<void> revokeAllPermissions();

  /// Checks the availability status of a specific platform feature.
  ///
  /// ## Parameters
  ///
  /// - [feature]: The platform feature to check availability for
  ///
  /// ## Returns
  ///
  /// - [HealthPlatformFeatureStatus.available] if the feature is
  ///   supported on this device
  /// - [HealthPlatformFeatureStatus.unavailable] if the feature is
  ///   not supported
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidConfiguration] if
  ///   required feature permissions are missing from platform configuration
  /// - [HealthConnectorException] if unable to query feature status
  ///
  /// ## Example
  ///
  /// ```dart
  /// final connector = await HealthConnector.create();
  /// final status = await connector.getFeatureStatus(
  ///                 HealthPlatformFeature.readHealthDataInBackground,
  ///               );
  ///
  /// if (status == HealthPlatformFeatureStatus.available) {
  ///   // Feature is supported, safe to request permissions
  ///   final results = await connector.requestPermissions([
  ///     HealthPlatformFeature.readHealthDataInBackground.permission,
  ///   ]);
  /// } else {
  ///   // Feature not available, disable background reading functionality
  /// }
  /// ```
  @PlatformSpecificBehaviors({
    HealthPlatform.appleHealth:
        'All features are available by default. Always returns '
        '`HealthPlatformFeatureStatus.available`.',
    HealthPlatform.healthConnect:
        'Feature availability depends on Android and Health Connect SDK. '
        'Some features require specific Android versions or system updates.',
  })
  Future<HealthPlatformFeatureStatus> getFeatureStatus(
    HealthPlatformFeature feature,
  );

  /// Reads a single health record by ID.
  ///
  /// ## Parameters
  ///
  /// - [request]: The read request containing the record ID and data type
  ///
  /// ## Returns
  ///
  /// The [HealthRecord] if found, or `null` if no record exists with the
  /// specified ID.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if read permission has not been granted
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## Example
  ///
  /// ```dart
  /// final recordId = HealthRecordId('abc-123-def-456');
  /// final request = HealthDataType.steps.readRecord(recordId);
  /// final record = await connector.readRecord(request);
  ///
  /// if (record != null) {
  ///   print('Found step record with ${record.count.value} steps');
  /// } else {
  ///   print('Record not found');
  /// }
  /// ```
  Future<R?> readRecord<R extends HealthRecord>(
    ReadRecordRequest<R> request,
  );

  /// Reads multiple health records within a time range.
  ///
  /// Queries health records of a specific type within the specified time range.
  /// Results are paginated to handle large datasets efficiently.
  ///
  /// ## Parameters
  ///
  /// - [request]: The read request containing time range, data type,
  ///   pagination settings, and optional filters.
  ///
  /// ## Returns
  ///
  /// A [ReadRecordsResponse] containing:
  /// - List of records found in the time range (up to pageSize records)
  /// - Records are ordered by start time in ascending order (oldest first)
  /// - Next page request if more records are available
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if read permission has not been granted
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## Example - With Pagination
  ///
  /// Use [ReadRecordsResponse.hasMorePages] to check if additional pages exist:
  ///
  /// ```dart
  /// var response = await connector.readRecords(request);
  ///
  /// while (response.nextPageRequest != null) {
  ///   // Process current page (records are already ordered by start time ascending)
  ///   for (final record in response.records) {
  ///     print(record);
  ///   }
  ///
  ///   // Fetch next page
  ///   response = await connector.readRecords(response.nextPageRequest);
  /// }
  /// ```
  Future<ReadRecordsResponse<R>> readRecords<R extends HealthRecord>(
    ReadRecordsRequest<R> request,
  );

  /// Writes a single health record to the platform.
  ///
  /// The record must be new (id = [HealthRecordId.none]). The platform will
  /// assign a unique ID to the record.
  ///
  /// ## Parameters
  ///
  /// - [record]: The health record to write
  ///
  /// ## Returns
  ///
  /// The [HealthRecordId] assigned by the platform to the newly written record.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if write permission has not been granted
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if the record ID is not
  ///   [HealthRecordId.none]
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Create and write a step record
  /// final record = StepsRecord(
  ///   id: HealthRecordId.none, // Must be none for new records
  ///   startTime: DateTime.now().subtract(Duration(hours: 1)),
  ///   endTime: DateTime.now(),
  ///   count: Numeric(1234),
  ///   metadata: Metadata.automaticallyRecorded(
  ///     device: Device.fromType(DeviceType.phone),
  ///   ),
  /// );
  ///
  /// final recordId = await connector.writeRecord(record);
  /// print('Record written with ID: $recordId');
  /// ```
  Future<HealthRecordId> writeRecord<R extends HealthRecord>(R record);

  /// Writes multiple health records atomically.
  ///
  /// Stores multiple new health records in a single atomic transaction.
  /// Either all records are written successfully, or none are written.
  ///
  /// All records must be new (id = [HealthRecordId.none]).
  ///
  /// ## Parameters
  ///
  /// - [records]: List of health records to write
  ///
  /// ## Returns
  ///
  /// A list of [HealthRecordId]s assigned by the platform, in the same order
  /// as the input records.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.notAuthorized] if write permission has not
  ///   been granted
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if any record ID is not
  ///   [HealthRecordId.none]
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs (no records will be written)
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Create multiple step records
  /// final records = [
  ///   StepsRecord(
  ///     startTime: DateTime(2024, 1, 1, 9, 0),
  ///     endTime: DateTime(2024, 1, 1, 10, 0),
  ///     count: Numeric(1200),
  ///     metadata: Metadata.automaticallyRecorded(
  ///       device: Device.fromType(DeviceType.phone),
  ///     ),
  ///   ),
  ///   StepsRecord(
  ///     startTime: DateTime(2024, 1, 1, 10, 0),
  ///     endTime: DateTime(2024, 1, 1, 11, 0),
  ///     count: Numeric(1500),
  ///     metadata: Metadata.automaticallyRecorded(
  ///       device: Device.fromType(DeviceType.phone),
  ///     ),
  ///   ),
  /// ];
  ///
  /// final recordIds = await connector.writeRecords(records);
  /// print('Wrote ${recordIds.length} records');
  /// ```
  Future<List<HealthRecordId>> writeRecords<R extends HealthRecord>(
    List<R> records,
  );

  /// Performs an aggregation query over health records.
  ///
  /// Computes an aggregated value (sum, average, minimum, or maximum) over
  /// all records of a specific type within the specified time range.
  ///
  /// ## Parameters
  ///
  /// - [request]: The aggregation request containing data type, metric,
  ///   and time range
  ///
  /// ## Returns
  ///
  /// An [AggregateResponse] containing the aggregated value of type `V`
  /// (a [MeasurementUnit] subclass)
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if read permission has not been granted
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Get total steps for the last 7 days
  /// final request = HealthDataType.steps.aggregateSum(
  ///   startTime: DateTime.now().subtract(Duration(days: 7)),
  ///   endTime: DateTime.now(),
  /// );
  /// final response = await connector.aggregate(request);
  ///
  /// print('Total steps: ${response.value.value}'); // response.value is Numeric
  /// ```
  Future<AggregateResponse<R, U>> aggregate<
    R extends HealthRecord,
    U extends MeasurementUnit
  >(AggregateRequest<R, U> request);

  /// Deletes health records within a time range.
  ///
  /// Removes all records of the specified [dataType] that fall within the
  /// time range from [startTime] to [endTime] (inclusive). This operation
  /// is permanent and cannot be undone.
  ///
  /// ## Data Ownership Restriction
  ///
  /// Apps can only delete health records that they created.
  /// Attempting to delete records created by other apps, manually entered by
  /// users, or system-generated will fail with a security error.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health records to delete
  /// - [startTime]: The start of the time range (inclusive)
  /// - [endTime]: The end of the time range (inclusive)
  ///
  /// ## Throws
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if
  ///   [endTime] before [startTime]
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if delete/write permission has not been granted
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if attempting to delete records not created by this app
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Delete all step records from the last 7 days
  /// await connector.deleteRecords(
  ///   dataType: HealthDataType.steps,
  ///   startTime: DateTime.now().subtract(Duration(days: 7)),
  ///   endTime: DateTime.now(),
  /// );
  /// ```
  Future<void> deleteRecords<R extends HealthRecord>({
    required HealthDataType<R, MeasurementUnit> dataType,
    required DateTime startTime,
    required DateTime endTime,
  });

  /// Deletes specific health records by their IDs.
  ///
  /// Removes the health records identified by [recordIds] from the platform's
  /// health data store. This operation is permanent and cannot be undone.
  ///
  /// ## Data Ownership Restriction
  ///
  /// Apps can only delete health records that they created.
  /// Attempting to delete records created by other apps, manually entered by
  /// users, or system-generated will fail with a security error.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health records to delete
  /// - [recordIds]: List of record IDs to delete
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if delete/write permission has not been granted
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if
  ///   any record ID is [HealthRecordId.none]
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if attempting to delete records not created by this app
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Read records and delete specific ones
  /// final response = await connector.readRecords(request);
  /// final idsToDelete = response.records
  ///     .where((record) => shouldDelete(record))
  ///     .map((record) => record.id)
  ///     .toList();
  ///
  /// await connector.deleteRecordsByIds(
  ///   dataType: HealthDataType.steps,
  ///   recordIds: idsToDelete,
  /// );
  /// ```
  Future<void> deleteRecordsByIds<R extends HealthRecord>({
    required HealthDataType<R, MeasurementUnit> dataType,
    required List<HealthRecordId> recordIds,
  });

  /// Updates an existing health record.
  ///
  /// ## Platform Differences
  ///
  /// - **Android Health Connect**: ✅ Full support
  /// - **iOS HealthKit**: ❌ Not supported
  ///
  /// ## Why HealthKit Doesn't Support Updates
  ///
  /// HealthKit uses an **immutable data model** where health samples represent
  /// point-in-time observations that cannot be modified after creation.
  ///
  /// ## How to Achieve Update Functionality on iOS
  ///
  /// This SDK **intentionally does not provide automatic delete-then-create
  /// logic**. Developers who need update functionality must explicitly use the
  /// SDK's delete and create APIs. This design ensures full awareness and
  /// responsibility for data modification operations.
  ///
  /// ### Option 1: Explicit Delete-Then-Create
  ///
  /// **You must explicitly call both operations**:
  ///
  /// ```dart
  /// // 1. EXPLICITLY delete the existing record
  /// //    You are responsible for this destructive operation
  /// await connector.deleteRecordsByIds(
  ///   dataType: HealthDataType.steps,
  ///   recordIds: [existingRecord.id],
  /// );
  ///
  /// // 2. EXPLICITLY create a new record with updated values
  /// //    This creates a new record, not an update
  /// final updatedRecord = StepsRecord(
  ///   id: HealthRecordId.none, // Must be none for new records
  ///   startTime: existingRecord.startTime,
  ///   endTime: existingRecord.endTime,
  ///   count: Numeric(newStepCount), // Updated value
  ///   metadata: existingRecord.metadata,
  /// );
  ///
  /// final newId = await connector.writeRecord(updatedRecord);
  /// ```
  ///
  /// > [!CAUTION]
  /// > The delete operation is permanent and cannot be undone. You are
  /// > responsible for understanding the implications of deleting health data.
  ///
  /// ### Option 2: Track Versions with Custom Metadata
  ///
  /// Use custom metadata to link different "versions" of the same logical
  /// record. **You must still explicitly delete and create**:
  ///
  /// ```dart
  /// // Original record with custom metadata
  /// final original = StepsRecord(
  ///   id: HealthRecordId.none,
  ///   // ... other fields
  ///   metadata: Metadata.manualEntry(
  ///     device: Device.fromType(DeviceType.phone),
  ///     customMetadata: {
  ///       'logicalRecordId': 'my-workout-123',
  ///       'version': '1',
  ///     },
  ///   ),
  /// );
  /// await connector.writeRecord(original);
  ///
  /// // To "update": delete old, create new with same logicalRecordId
  /// await connector.deleteRecordsByIds(
  ///   dataType: HealthDataType.steps,
  ///   recordIds: [original.id],
  /// );
  ///
  /// final updated = StepsRecord(
  ///   id: HealthRecordId.none,
  ///   // ... updated fields
  ///   metadata: Metadata.manualEntry(
  ///     device: Device.fromType(DeviceType.phone),
  ///     customMetadata: {
  ///       'logicalRecordId': 'my-workout-123', // Same logical ID
  ///       'version': '2', // Incremented version
  ///     },
  ///   ),
  /// );
  /// await connector.writeRecord(updated);
  /// ```
  ///
  /// ## Parameters
  ///
  /// - [record]: The health record to update. Must have a valid existing
  ///   [HealthRecordId] (not [HealthRecordId.none]).
  ///
  /// ## Returns
  ///
  /// The [HealthRecordId] of the updated record (same as input on Health
  /// Connect).
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.unsupportedOperation] on iOS HealthKit
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if the record ID is
  ///   [HealthRecordId.none] or invalid
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if write permission has not been granted
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if attempting to update a record not created by this app
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## See Also
  ///
  /// - [deleteRecordsByIds] for deleting specific records
  /// - [writeRecord] for creating new records
  @supportedOnHealthConnect
  Future<HealthRecordId> updateRecord<R extends HealthRecord>(R record);
}
