import 'dart:io' show Platform;

import 'package:health_connector/src/health_connector_impl.dart'
    show HealthConnectorImpl;
import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        AggregateResponse,
        DeleteRecordsRequest,
        HealthConnectorConfig,
        HealthPlatformFeaturePermission,
        PermissionStatus,
        HealthDataPermission,
        HealthConnectorException,
        HealthConnectorErrorCode,
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
        ReadRecordByIdRequest,
        ReadRecordsInTimeRangeRequest,
        ReadRecordsInTimeRangeResponse,
        supportedOnHealthConnect,
        sinceV2_0_0,
        DeleteRecordsInTimeRangeRequest,
        DeleteRecordsByIdsRequest;
import 'package:health_connector_hc_android/health_connector_hc_android.dart'
    show HealthConnectorHCClient;
import 'package:health_connector_hk_ios/health_connector_hk_ios.dart'
    show HealthConnectorHKClient;
import 'package:health_connector_logger/health_connector_logger.dart';

/// Main entry point for interacting with platform-specific health APIs.
///
/// This class uses a factory pattern to create instances. Use
/// [HealthConnector.create] to obtain an instance.
abstract interface class HealthConnector {
  /// The tag used for logging in static methods.
  static const String _tag = 'HealthConnector';

  /// Creates a new [HealthConnector] instance.
  ///
  /// This factory ensures that the instance is properly configured for the
  /// current platform.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.healthProviderUnavailable]
  ///   if health provider is unavailable on this device.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.healthProviderNotInstalledOrUpdateRequired]
  ///   if Health Connect provider installation or update is required.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  static Future<HealthConnector> create([
    HealthConnectorConfig config = const HealthConnectorConfig(),
  ]) async {
    HealthConnectorLogger.isEnabled = config.isLoggerEnabled;

    final healthPlatform = Platform.isIOS
        ? HealthPlatform.appleHealth
        : HealthPlatform.healthConnect;

    final status = await switch (healthPlatform) {
      HealthPlatform.appleHealth =>
        HealthConnectorHKClient.getHealthPlatformStatus(),
      HealthPlatform.healthConnect =>
        HealthConnectorHCClient.getHealthPlatformStatus(),
    };
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

  /// Gets the current permission status for a specific permission.
  ///
  /// This method allows you to check whether a permission has been granted,
  /// denied, or is in an unknown state without requesting it.
  ///
  /// ## Platform Differences
  ///
  /// ### iOS (HealthKit)
  ///
  /// **Read Permissions**: Due to HealthKit's privacy protections, read
  /// permissions will **always** return [PermissionStatus.unknown]. This is
  /// a platform limitation - HealthKit does not allow apps to determine
  /// whether read access has been granted or denied.
  ///
  /// **Write Permissions**: Can return definitive [PermissionStatus.granted]
  /// or [PermissionStatus.denied] status.
  ///
  /// **Feature Permissions**: Since feature permissions are Android-only, they
  /// will return [PermissionStatus.granted] on iOS.
  ///
  /// ### Android (Health Connect)
  ///
  /// All permissions (both data and feature permissions) return definitive
  /// status:
  /// - [PermissionStatus.granted] if the permission has been granted
  /// - [PermissionStatus.denied] if the permission has not been granted
  ///
  /// Note: Health Connect does not distinguish between "never requested" and
  /// "explicitly denied" - both cases will return [PermissionStatus.denied].
  ///
  /// ## Parameters
  ///
  /// - [permission]: The permission to check. Can be either:
  ///   - [HealthDataPermission] for health data access
  ///   - [HealthPlatformFeaturePermission] for platform features (Android-only)
  ///
  /// ## Returns
  ///
  /// The current [PermissionStatus] of the specified permission
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if an error occurs while checking status
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Check status of a read permission
  /// final stepsReadPermission = HealthDataPermission(
  ///   dataType: HealthDataTypes.steps,
  ///   accessType: HealthDataPermissionAccessType.read,
  /// );
  ///
  /// final status = await connector.getPermissionStatus(stepsReadPermission);
  ///
  /// switch (status) {
  ///   case PermissionStatus.granted:
  ///     print('Permission granted');
  ///   case PermissionStatus.denied:
  ///     print('Permission denied');
  ///   case PermissionStatus.unknown:
  ///     print('Cannot determine (iOS read permission)');
  /// }
  /// ```
  ///
  /// ## See Also
  ///
  /// - [requestPermissions] - Request permissions from the user
  /// - [getGrantedPermissions] - Get all currently granted permissions
  /// - [PermissionStatus] - Enum defining possible permission states
  @PlatformSpecificBehaviors({
    HealthPlatform.appleHealth:
        'Read permissions always return `PermissionStatus.unknown` due to '
        'privacy. '
        'Feature permissions always return `PermissionStatus.granted`. '
        'Write permissions return actual status.',
    HealthPlatform.healthConnect:
        'Returns actual permission status for all permission types.',
  })
  Future<PermissionStatus> getPermissionStatus(Permission permission);

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
    ReadRecordByIdRequest<R> request,
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
  /// A [ReadRecordsInTimeRangeResponse] containing:
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
  /// Use [ReadRecordsInTimeRangeResponse.hasMorePages] to check
  /// if additional pages exist:
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
  Future<ReadRecordsInTimeRangeResponse<R>> readRecords<R extends HealthRecord>(
    ReadRecordsInTimeRangeRequest<R> request,
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

  /// Deletes health records based on the provided request.
  ///
  /// This unified deletion method accepts either [DeleteRecordsByIdsRequest]
  /// or [DeleteRecordsInTimeRangeRequest] to delete specific records or
  /// records within a time range.
  ///
  /// ## Data Ownership Restriction
  ///
  /// Apps can only delete health records that they created.
  /// Attempting to delete records created by other apps, manually entered by
  /// users, or system-generated will fail with a security error.
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
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if delete/write permission has not been granted
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if
  ///   the request contains invalid data
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if attempting to delete records not created by this app
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## Example - Delete by IDs
  ///
  /// ```dart
  /// // Create deletion request using the capability interface
  /// final request = HealthDataType.steps.deleteByIds([id1, id2, id3]);
  ///
  /// // Delete the records
  /// await connector.deleteRecords(request);
  /// ```
  ///
  /// ## Example - Delete by Time Range
  ///
  /// ```dart
  /// // Create deletion request for a time range
  /// final request = HealthDataType.steps.deleteInTimeRange(
  ///   startTime: DateTime.now().subtract(Duration(days: 7)),
  ///   endTime: DateTime.now(),
  /// );
  ///
  /// // Delete all records in the time range
  /// await connector.deleteRecords(request);
  /// ```
  @sinceV2_0_0
  @PlatformSpecificBehaviors({
    HealthPlatform.healthConnect:
        'Health Connect SDK only supports atomic deletion within a single'
        ' health record type. '
        'Due to this reason `DeleteRecordsRequest` contains `HealthDataType`.',
    HealthPlatform.appleHealth:
        'While HealthKit SDK can delete multiple record types atomically, '
        'this API requires specifying a single data type to maintain '
        'cross-platform consistency with  Health Connect.',
  })
  Future<void> deleteRecords<R extends HealthRecord>(
    DeleteRecordsRequest<R> request,
  );

  /// Updates an existing health record.
  ///
  /// ## Platform Differences
  ///
  /// - **Android Health Connect**: ✅ Full support
  /// - **iOS HealthKit**: ❌ Not supported (see [updateRecords] for details)
  ///
  /// ## Parameters
  ///
  /// - [record]: The health record to update. Must have a valid existing
  ///   [HealthRecordId] (not [HealthRecordId.none]).
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
  /// - [deleteRecords] for deleting specific records
  /// - [writeRecord] for creating new records
  @supportedOnHealthConnect
  Future<void> updateRecord<R extends HealthRecord>(R record);

  /// Updates multiple existing health records in a single batch operation.
  ///
  /// ## Platform Differences
  ///
  /// - **Android Health Connect**: ✅ Full support with atomic batch operations
  /// - **iOS HealthKit**: ❌ Not supported
  ///
  /// ## Why HealthKit Doesn't Support Updates
  ///
  /// HealthKit uses an **immutable data model** where health samples represent
  /// point-in-time observations that cannot be modified after creation.
  ///
  /// ## How to Achieve Batch Update Functionality on iOS
  ///
  /// For iOS, you must explicitly use delete and create operations. See
  /// [updateRecord] for detailed workarounds and patterns.
  ///
  /// **Quick example for batch operations on iOS**:
  ///
  /// ```dart
  /// // 1. Delete existing records
  /// await connector.deleteRecords(
  ///   HealthDataType.steps.deleteByIds(
  ///     recordIds: existingRecords.map((r) => r.id).toList(),
  ///   ),
  /// );
  ///
  /// // 2. Create new records with updated values
  /// final updatedRecords = existingRecords.map((record) => StepsRecord(
  ///   id: HealthRecordId.none,
  ///   startTime: record.startTime,
  ///   endTime: record.endTime,
  ///   count: Numeric(newStepCount),
  ///   metadata: record.metadata,
  /// )).toList();
  ///
  /// await connector.writeRecords(updatedRecords);
  /// ```
  ///
  /// ## Example - Batch Update on Android
  ///
  /// ```dart
  /// // Read existing records
  /// final request = HealthDataType.steps.readByIds(
  ///   recordIds: [id1, id2, id3],
  /// );
  /// final records = await connector.readRecords(request);
  ///
  /// // Modify the records
  /// final updatedRecords = records.map((record) {
  ///   if (record is StepsRecord) {
  ///     return record.copyWith(
  ///       count: Numeric(record.count.value + 1000),
  ///     );
  ///   }
  ///   return record;
  /// }).toList();
  ///
  /// // Update all records atomically
  /// await connector.updateRecords(updatedRecords);
  /// ```
  ///
  /// ## Parameters
  ///
  /// - [records]: The list of health records to update. All records must:
  ///   - Be of the same type
  ///   - Have valid existing [HealthRecordId] (not [HealthRecordId.none])
  ///   - Exist in the health data store
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.unsupportedOperation] on iOS HealthKit
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if any record ID is
  ///   [HealthRecordId.none] or invalid
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if write permission has not been granted
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if attempting to update records not created by this app
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## See Also
  ///
  /// - [deleteRecords] for deleting multiple records
  /// - [writeRecords] for creating multiple new records
  @sinceV2_0_0
  @supportedOnHealthConnect
  Future<void> updateRecords<R extends HealthRecord>(List<R> records);
}
