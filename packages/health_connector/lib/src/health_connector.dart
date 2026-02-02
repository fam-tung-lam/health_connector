import 'dart:io' show Platform;

import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector/src/health_connector_impl.dart'
    show HealthConnectorImpl;
import 'package:health_connector_hc_android/health_connector_hc_android.dart'
    show HealthConnectorHCClient;
import 'package:health_connector_hk_ios/health_connector_hk_ios.dart'
    show HealthConnectorHKClient;

/// Main entry point for interacting with platform-specific health APIs.
///
/// Provides a unified interface for accessing health and fitness data across
/// multiple health platforms.
///
/// ## Supported Health Platforms
///
/// - **iOS HealthKit**: Uses Apple HealthKit Framework
/// - **Android Health Connect**: Uses Google Health Connect SDK
///
/// ## Core Capabilities
///
/// - **Permission Management**: Request, check, and revoke health data access
/// - **Data Reading**: Query individual records or time ranges with pagination
/// - **Data Writing**: Store single or multiple health records atomically
/// - **Aggregations**: Compute sums, averages, min/max over time ranges
/// - **Record Updates**: Modify existing records (Android Health Connect Only)
/// - **Data Deletion**: Remove records by ID or time range
///
/// ## See Also
///
/// - [HealthDataType] for available data types and their capabilities
/// - [HealthConnectorConfig] for configuration options
/// - [HealthRecord] for working with health data records
///
/// {@category Core API}
@sinceV1_0_0
abstract interface class HealthConnector {
  /// The tag used for logging in static methods.
  static const String _tag = 'HealthConnector';

  /// Creates a new [HealthConnector] instance.
  ///
  /// This factory ensures that the instance is properly configured for the
  /// current health platform. The factory automatically detects the platform
  /// and verifies health service availability before creating the instance.
  ///
  /// ## Parameters
  ///
  /// - [config]: Optional configuration for customizing connector behavior such
  ///   as logger enablement. If not provided, default configuration is used.
  ///
  /// ## Returns
  ///
  /// - A [Future] that completes with the configured [HealthConnector]
  ///   instance.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.healthServiceUnavailable]
  ///   when the health platform is unavailable on this device.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.healthServiceNotInstalledOrUpdateRequired]
  ///   when Health Connect app installation or update is required.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Create with configuration
  /// final connectorWithLogging = await HealthConnector.create(
  ///   HealthConnectorConfig(isLoggerEnabled: true),
  /// );
  /// ```
  ///
  /// ## See Also
  ///
  /// - [getHealthPlatformStatus]
  static Future<HealthConnector> create([
    HealthConnectorConfig config = const HealthConnectorConfig(),
  ]) async {
    // Register configured log processors
    for (final processor in config.loggerConfig.logProcessors) {
      HealthConnectorLogger.addProcessor(processor);
    }

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

        throw HealthServiceUnavailableException(
          HealthConnectorErrorCode.healthServiceUnavailable,
          '$healthPlatform is not available.',
        );
      case HealthPlatformStatus.installationOrUpdateRequired:
        HealthConnectorLogger.warning(
          _tag,
          operation: 'create',
          message: 'Health platform installation or update required',
          context: {'platform': healthPlatform.name},
        );

        throw HealthServiceUnavailableException(
          HealthConnectorErrorCode.healthServiceNotInstalledOrUpdateRequired,
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
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
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
      operation: 'get_health_platform_status',
      message: 'Checking health platform status',
    );

    try {
      final healthPlatform = Platform.isIOS
          ? HealthPlatform.appleHealth
          : HealthPlatform.healthConnect;
      final status = await switch (healthPlatform) {
        HealthPlatform.appleHealth =>
          HealthConnectorHKClient.getHealthPlatformStatus(),
        HealthPlatform.healthConnect =>
          HealthConnectorHCClient.getHealthPlatformStatus(),
      };

      HealthConnectorLogger.info(
        _tag,
        operation: 'get_health_platform_status',
        message: 'Health platform status retrieved',
        context: {'status': status.name},
      );

      return status;
    } catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'get_health_platform_status',
        message: 'Failed to get health platform status',
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  /// Launches the health app page in the platform's app store.
  ///
  /// Opens the app store page for installing or updating the health platform
  /// app. This method should be called when [getHealthPlatformStatus] returns
  /// [HealthPlatformStatus.installationOrUpdateRequired].
  ///
  /// ## Platform Differences
  ///
  /// ### iOS HealthKit
  ///
  /// - Always throws [UnsupportedOperationException] because Apple Health
  ///   is a built-in system service that is always available on iOS devices.
  ///
  /// ### Android Health Connect
  ///
  /// - Opens the Health Connect app page in Google Play Store.
  /// - This allows users to install or update the Health Connect app.
  ///
  /// ## Throws
  ///
  /// - [UnsupportedOperationException] on iOS, as Apple Health is always
  ///   available and doesn't require installation.
  /// - [HealthConnectorException] when unable to launch the app store page.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final status = await HealthConnector.getHealthPlatformStatus();
  /// if (status == HealthPlatformStatus.installationOrUpdateRequired) {
  ///   try {
  ///     await HealthConnector.launchHealthAppPageInAppStore();
  ///   } on UnsupportedOperationException catch (e) {
  ///     // On iOS, Health is always available
  ///     print('Apple Health is built-in');
  ///   } on HealthConnectorException catch (e) {
  ///     print('Failed to launch app store: ${e.message}');
  ///   }
  /// }
  /// ```
  @sinceV2_3_0
  @supportedOnHealthConnect
  static Future<void> launchHealthAppPageInAppStore() async {
    final healthPlatform = Platform.isIOS
        ? HealthPlatform.appleHealth
        : HealthPlatform.healthConnect;

    HealthConnectorLogger.debug(
      _tag,
      operation: 'launch_health_app_page_in_app_store',
      message: 'Launching health app page in app store',
      context: {
        'health_platform': healthPlatform,
      },
    );

    try {
      switch (healthPlatform) {
        case HealthPlatform.appleHealth:
          throw const UnsupportedOperationException(
            'Apple Health service is always available on iOS devices.',
          );
        case HealthPlatform.healthConnect:
          await HealthConnectorHCClient.launchHealthConnectPageInGooglePlay();
      }

      HealthConnectorLogger.info(
        _tag,
        operation: 'launch_health_app_page_in_app_store',
        message: 'Launched health app page in app store',
        context: {
          'health_platform': healthPlatform,
        },
      );
    } catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'launch_health_app_page_in_app_store',
        message: 'Failed to launch health app page in app store',
        context: {
          'health_platform': healthPlatform,
        },
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  /// The health platform being used by this connector.
  ///
  /// This value is determined during connector creation and remains constant
  /// for the lifetime of the instance.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final connector = await HealthConnector.create();
  /// print('Using: ${connector.healthPlatform}');
  /// // iOS: HealthPlatform.appleHealth
  /// // Android: HealthPlatform.healthConnect
  /// ```
  HealthPlatform get healthPlatform;

  /// The configuration used by this connector.
  ///
  /// Contains settings such as logger enablement and other connector
  /// behavior options.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final connector = await HealthConnector.create(
  ///   HealthConnectorConfig(isLoggerEnabled: true),
  /// );
  /// print('Logger enabled: ${connector.config.isLoggerEnabled}');
  /// ```
  ///
  /// ## See Also
  ///
  /// - [HealthConnectorConfig] for available configuration options
  HealthConnectorConfig get config;

  /// Requests the specified permissions from the health platform.
  ///
  /// ## Platform Differences
  ///
  /// ### iOS HealthKit
  ///
  /// - Read permissions always return [PermissionStatus.unknown] for privacy.
  /// - Write permissions return actual status.
  /// - Feature permissions always return [PermissionStatus.granted], as
  ///   features are available by default.
  ///
  /// ### Android Health Connect
  ///
  /// - Returns actual permission status for all permission types.
  ///
  /// ## Parameters
  ///
  /// - [permissions]: List of permissions to request from the user. Can include
  ///   [HealthDataPermission] for data access and
  ///   [HealthPlatformFeaturePermission] for platform features.
  ///
  /// ## Returns
  ///
  /// - A list of [PermissionRequestResult] objects containing the status
  ///   for each requested permission.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotDeclared] when
  ///   required permissions are missing from the configuration.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs.
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
  /// ## See Also
  ///
  /// - [HealthDataPermission] and [HealthPlatformFeaturePermission]
  /// - [HealthConnector.getFeatureStatus]
  Future<List<PermissionRequestResult>> requestPermissions(
    List<Permission> permissions,
  );

  /// Gets all permissions that have been granted to the app.
  ///
  /// Currently supported on Android Health Connect only.
  ///
  /// ## Returns
  ///
  /// - A list of [Permission] objects that have been granted.
  ///   This includes both health data permissions and feature permissions.
  ///   The list may be empty if no permissions have been granted.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.unsupportedOperation] if
  ///   this API is not supported on the current platform.
  /// - [HealthConnectorException] if the platform request fails or
  ///   returns invalid data.
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
  /// ## Platform Differences
  ///
  /// ### iOS HealthKit
  ///
  /// - Read permissions always return [PermissionStatus.unknown] for privacy.
  /// - Feature permissions always return [PermissionStatus.granted], as
  ///   features are available by default.
  /// - Write permissions return actual status.
  ///
  /// ### Android Health Connect
  ///
  /// - Returns actual permission status for all permission types.
  ///
  /// ## Parameters
  ///
  /// - [permission]: The permission to check. Can be either:
  /// - [HealthDataPermission] for health data access
  /// - [HealthPlatformFeaturePermission] for platform features (Android-only)
  ///
  /// ## Returns
  ///
  /// - The current [PermissionStatus] of the specified permission.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] when an error occurs while checking status.
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
  @sinceV2_0_0
  Future<PermissionStatus> getPermissionStatus(Permission permission);

  /// Revokes all permissions that have been granted to the app.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.unsupportedOperation] if this API is
  ///   not supported on the current platform.
  /// - [HealthConnectorException] if the platform request fails.
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
  /// ## Platform Differences
  ///
  /// ### iOS HealthKit
  ///
  /// - Always returns [HealthPlatformFeatureStatus.available], as
  ///   all features are available by default.
  ///
  /// ### Android Health Connect
  ///
  /// - Feature availability depends on Android and Health Connect SDK.
  ///   For example, some features require specific version.
  ///
  /// ## Parameters
  ///
  /// - [feature]: The platform feature to check availability for
  ///
  /// ## Returns
  ///
  /// - [HealthPlatformFeatureStatus.available] when
  ///   the feature is supported on this device.
  /// - [HealthPlatformFeatureStatus.unavailable] when
  ///   the feature is not supported.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotDeclared] when
  ///   required feature permissions are missing from the configuration.
  /// - [HealthConnectorException] when unable to query feature status.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final connector = await HealthConnector.create();
  /// final status = await connector.getFeatureStatus(
  ///                         HealthPlatformFeature.readHealthDataInBackground,
  ///                       );
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
  /// - [HealthRecord] if found, or `null` if no record exists with the
  /// specified ID.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted]
  ///   when read permission has not been granted.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs.
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
  @sinceV1_0_0
  Future<R?> readRecord<R extends HealthRecord>(
    ReadRecordByIdRequest<R> request,
  );

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
  /// - A [ReadRecordsInTimeRangeResponse] containing:
  ///   - The list of records found in the time range (up to pageSize records)
  ///   - The records, ordered by start time in ascending order (oldest first)
  ///   - The next page request if more records are available
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted]
  ///   when read permission has not been granted.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs.
  ///
  /// ## Example - With Pagination
  ///
  /// Use [ReadRecordsInTimeRangeResponse.hasMorePages] to check
  /// when additional pages exist:
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
  /// ## Parameters
  ///
  /// - [record]: The health record to write. Must have [HealthRecordId.none]
  ///   as its ID.
  ///
  /// ## Returns
  ///
  /// - The [HealthRecordId] assigned by the platform to the newly written
  ///   record.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted]
  ///   when write permission has not been granted.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] when the record ID is not
  ///   [HealthRecordId.none] or the record is not supported by the platform.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Create and write a step record
  /// final record = StepsRecord(
  ///   id: HealthRecordId.none, // Must be none for new records
  ///   startTime: DateTime.now().subtract(Duration(hours: 1)),
  ///   endTime: DateTime.now(),
  ///   count: Number(1234),
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
  /// ## Parameters
  ///
  /// - [records]: List of health records to write. All records must have
  ///   [HealthRecordId.none] as their ID.
  ///
  /// ## Returns
  ///
  /// - A list of [HealthRecordId]s assigned by the platform, in the same order
  ///   as the input records.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted] if write
  ///   permission has not been granted.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if any record ID is not
  ///   [HealthRecordId.none] or some records are not supported by the platform.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs (no records will be written).
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Create multiple step records
  /// final records = [
  ///   StepsRecord(
  ///     startTime: DateTime(2024, 1, 1, 9, 0),
  ///     endTime: DateTime(2024, 1, 1, 10, 0),
  ///     count: Number(1200),
  ///     metadata: Metadata.automaticallyRecorded(
  ///       device: Device.fromType(DeviceType.phone),
  ///     ),
  ///   ),
  ///   StepsRecord(
  ///     startTime: DateTime(2024, 1, 1, 10, 0),
  ///     endTime: DateTime(2024, 1, 1, 11, 0),
  ///     count: Number(1500),
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

  /// Computes an aggregated value (sum, average, minimum, or maximum) over
  /// all records of a specific type within the specified time range.
  ///
  /// ## Parameters
  ///
  /// - [request]: The aggregation request containing data type, metric,
  ///   and time range.
  ///
  /// ## Returns
  ///
  /// - The aggregated value in the appropriate measurement unit.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted]
  ///   when read permission has not been granted.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs.
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
  /// print('Total steps: ${response.value}'); // response is Number
  /// ```
  Future<U> aggregate<U extends MeasurementUnit>(AggregateRequest<U> request);

  /// Deletes health records based on the provided request.
  ///
  /// This unified deletion method accepts either [DeleteRecordsByIdsRequest]
  /// or [DeleteRecordsInTimeRangeRequest] to delete specific records or
  /// records within a time range.
  ///
  /// ## Platform Differences
  ///
  /// Health Connect SDK only supports atomic deletion within a single health
  /// record type. Due to this reason [DeleteRecordsRequest] contains
  /// [HealthDataType].
  ///
  /// While HealthKit SDK can delete multiple record types
  /// atomically, this method requires specifying a single data type to
  /// **maintain cross-platform consistency with Health Connect**.
  ///
  /// ## Data Ownership Restriction
  ///
  /// Apps can only delete health records that they created.
  /// Attempting to delete records created by other apps, manually entered by
  /// users, or system-generated will fail with a security error.
  ///
  /// ## Parameters
  ///
  /// - [request]: A deletion request specifying either record IDs or
  ///   a time range.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted]
  ///   when delete/write permission has not been granted or when attempting to
  ///   delete records not created by this app.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] when
  ///   the request contains invalid data.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs.
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
  Future<void> deleteRecords(DeleteRecordsRequest request);

  /// Updates an existing health record.
  ///
  /// ## Platform Differences
  ///
  /// - **Android Health Connect**: Full support
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
  ///   [HealthConnectorErrorCode.unsupportedOperation] on iOS HealthKit.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if the record ID is
  ///   [HealthRecordId.none] or the record is not supported by the platform.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted]
  ///   when write permission has not been granted or when attempting to
  ///   update a record not created by this app.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Read the existing record
  /// final recordId = HealthRecordId('existing-record-id');
  /// final request = HealthDataType.steps.readRecord(recordId);
  /// final existingRecord = await connector.readRecord(request);
  ///
  /// if (existingRecord != null && existingRecord is StepsRecord) {
  ///   // Modify the record
  ///   final updatedRecord = existingRecord.copyWith(
  ///     count: Number(existingRecord.count.value + 500),
  ///   );
  ///
  ///   // Update the record (Android Health Connect Only)
  ///   await connector.updateRecord(updatedRecord);
  /// }
  /// ```
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
  /// - **Android Health Connect**: Full support
  /// - **iOS HealthKit**: ❌ Not supported
  ///
  /// ### Why HealthKit Doesn't Support Updates
  ///
  /// HealthKit uses an **immutable data model** where health samples represent
  /// point-in-time observations that cannot be modified after creation.
  ///
  /// ## How to Achieve Batch Update Functionality on iOS HealthKit
  ///
  /// For iOS, you must explicitly use delete and create operations.
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
  ///   count: Number(newStepCount),
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
  ///       count: Number(record.count.value + 1000),
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
  ///   [HealthConnectorErrorCode.unsupportedOperation] on iOS HealthKit.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if any record ID is
  ///   [HealthRecordId.none] or some record are not supported by the platform.
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.permissionNotGranted]
  ///   when write permission has not been granted or when attempting to update
  ///   records not created by this app.
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknownError]
  ///   when an unexpected error occurs.
  ///
  /// ## See Also
  ///
  /// - [deleteRecords] for deleting multiple records
  /// - [writeRecords] for creating multiple new records
  @sinceV2_0_0
  @supportedOnHealthConnect
  Future<void> updateRecords<R extends HealthRecord>(List<R> records);

  /// Synchronizes health data using incremental change tracking.
  ///
  /// This API provides efficient incremental synchronization by tracking only
  /// the changes (additions, updates, deletions) since the last sync operation.
  ///
  /// ## How It Works
  ///
  /// 1. **Initial Sync**: Call with `syncToken: null` to establish a baseline
  /// 2. **Incremental Sync**: Use the token from the previous sync to get
  ///    only changes
  /// 3. **Pagination**: If `hasMore` is true, call again with `nextSyncToken`
  ///
  /// ## Parameters
  ///
  /// - [dataTypes]: Health data types to synchronize
  /// - [syncToken]: Token from previous sync, or null for initial sync
  ///
  /// ## Returns
  ///
  /// [HealthDataSyncResult] containing:
  /// - `upsertedRecords`: Records added/updated since last sync
  /// - `deletedRecordIds`: IDs of records deleted since last sync
  /// - `hasMore`: Whether pagination is needed
  /// - `nextSyncToken`: Token for next synchronization request
  ///
  /// ## Throws
  ///
  /// - [InvalidArgumentException] if token has expired (primarily Android
  ///   Health Connect)
  /// - [AuthorizationException] if permissions are missing
  /// - [InvalidArgumentException] if dataTypes don't match token scope
  ///
  /// ## Example - Initial Sync
  ///
  /// ```dart
  /// // Establish baseline at current moment
  /// final result = await connector.synchronize(
  ///   dataTypes: [HealthDataType.steps, HealthDataType.height],
  ///   syncToken: null,
  /// );
  ///
  /// // Save next token for next sync
  /// final token = result.nextSyncToken;
  /// await storage.save('sync_token', token.toJson());
  /// ```
  ///
  /// ## Example - Incremental Sync
  ///
  /// ```dart
  /// // Load saved token
  /// final tokenJson = await storage.load('sync_token');
  /// final token = HealthDataSyncToken.fromJson(tokenJson);
  ///
  /// // Get changes since last sync
  /// final result = await connector.synchronize(
  ///   dataTypes: [HealthDataType.steps, HealthDataType.height],
  ///   syncToken: token,
  /// );
  ///
  /// // Process changes
  /// for (final record in result.upsertedRecords) {
  ///   // process upserted record
  /// }
  /// for (final id in result.deletedRecordIds) {
  ///   // process deleted record
  /// }
  ///
  /// // Save new token for next sync
  /// if (result.nextSyncToken != null) {
  ///   await storage.save('sync_token', result.nextSyncToken!.toJson());
  /// }
  /// ```
  ///
  /// ## Example - Incremental Sync with Pagination
  ///
  /// ```dart
  /// var currentToken = savedToken;
  /// var hasMore = true;
  ///
  /// do {
  ///   final result = await connector.synchronize(
  ///     dataTypes: [HealthDataType.steps, HealthDataType.height],
  ///     syncToken: currentToken,
  ///   );
  ///
  ///   // Process page of changes
  ///   for (final record in result.upsertedRecords) {
  ///     // process upserted record
  ///   }
  ///   for (final id in result.deletedRecordIds) {
  ///     // process deleted record
  ///   }
  ///
  ///   hasMore = result.hasMore;
  ///   currentToken = result.nextSyncToken;
  /// } while (hasMore);
  ///
  /// // Save final token for the next periodic sync
  /// if (currentToken != null) {
  ///   await storage.save('sync_token', currentToken.toJson());
  /// }
  /// ```
  ///
  /// ## Example - Handling Token Expiration
  ///
  /// ```dart
  /// try {
  ///   final result = await connector.synchronize(
  ///     dataTypes: [HealthDataType.steps, HealthDataType.height],
  ///     syncToken: savedToken,
  ///   );
  /// } on InvalidArgumentException catch (e) {
  ///   // Token expired (Android ~30 days), backfill missing data
  ///   final gap = DateTime.now().difference(savedToken.createdAt);
  ///
  ///   // Backfill upserts using readRecords()
  ///   final backfillRequest = HealthDataType.steps.readInTimeRange(
  ///     startTime: savedToken.createdAt,
  ///     endTime: DateTime.now(),
  ///   );
  ///   final backfillResponse = await connector.readRecords(backfillRequest);
  ///
  ///   // Process backfill (deletions cannot be recovered)
  ///   for (final record in backfillResponse.records) {
  ///     // process upserted record
  ///   }
  ///
  ///   // Reset sync with new baseline
  ///   final result = await connector.synchronize(
  ///     dataTypes: [HealthDataType.steps, HealthDataType.height],
  ///     syncToken: null,
  ///   );
  ///
  ///   // Save next token for next sync
  ///   final token = result.nextSyncToken;
  ///   await storage.save('sync_token', token.toJson());
  /// }
  /// ```
  @sinceV3_0_0
  Future<HealthDataSyncResult> synchronize({
    required List<HealthDataType> dataTypes,
    required HealthDataSyncToken? syncToken,
  });

  /// Reads the exercise route for a given exercise session.
  ///
  /// Exercise routes contain GPS location data recorded during exercise
  /// sessions. Due to the sensitive nature of location data, reading routes
  /// requires separate permissions from reading exercise session records.
  ///
  /// ## Permissions Required
  ///
  /// Before calling this method, request [ExerciseRoutePermission.read]:
  ///
  /// ```dart
  /// await connector.requestPermissions([
  ///   ExerciseRoutePermission.read,
  /// ]);
  /// ```
  ///
  /// ## Parameters
  ///
  /// - [exerciseSessionId]: The ID of the exercise session to read the route
  ///   for. This should be an ID obtained from reading exercise session
  ///   records.
  ///
  /// ## Returns
  ///
  /// - The [ExerciseRoute] containing GPS location points if the session has
  ///   route data.
  /// - `null` if the session has no associated route data or doesn't exist.
  ///
  /// ## Platform Differences
  ///
  /// ### Android Health Connect
  ///
  /// - If route data was recorded by a third-party app, a system consent
  ///   dialog is shown automatically during this call.
  /// - If user grants consent, returns the route data.
  /// - If user denies consent, throws [AuthorizationException].
  /// - Routes recorded by your own app return directly without consent.
  ///
  /// ### iOS HealthKit
  ///
  /// - Returns the most recent route associated with the workout.
  /// - If multiple routes exist for a workout, only the latest is returned.
  /// - No per-route consent is required (all-or-nothing authorization).
  ///
  /// ## Throws
  ///
  /// - [AuthorizationException] if:
  ///   - [ExerciseRoutePermission.read] has not been granted
  ///   - User denies consent for third-party route data (Android only)
  /// - [HealthConnectorException] if the platform request fails
  ///
  /// ## Example
  ///
  /// ```dart
  /// // First, read exercise sessions
  /// final sessions = await connector.readRecords(
  ///   HealthDataType.exerciseSession.readInTimeRange(
  ///     startTime: DateTime.now().subtract(Duration(days: 7)),
  ///     endTime: DateTime.now(),
  ///   ),
  /// );
  ///
  /// // Then, load route for a specific session
  /// for (final session in sessions.records) {
  ///   try {
  ///     final route = await connector.readExerciseRoute(session.id);
  ///     if (route != null) {
  ///       print('Route has ${route.length} GPS points');
  ///       print('Duration: ${route.duration}');
  ///
  ///       // Display route on a map
  ///       for (final location in route.locations) {
  ///         print('${location.latitude}, ${location.longitude}');
  ///       }
  ///     } else {
  ///       print('No route data for this session');
  ///     }
  ///   } on AuthorizationException {
  ///     print('Route permission denied or consent not granted');
  ///   }
  /// }
  /// ```
  ///
  /// ## See Also
  ///
  /// - [ExerciseRoutePermission] for route-specific permissions
  /// - [ExerciseRoute] for route data structure
  /// - [ExerciseRouteLocation] for individual GPS points
  @sinceV3_8_0
  Future<ExerciseRoute?> readExerciseRoute(HealthRecordId exerciseSessionId);
}
