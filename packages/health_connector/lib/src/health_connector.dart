import 'dart:io' show Platform;

import 'package:health_connector/src/health_connector_config.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        AggregateResponse,
        HealthConnectorException,
        HealthConnectorErrorCode,
        HealthConnectorPlatformClient,
        HealthDataType,
        HealthPlatform,
        HealthPlatformFeature,
        HealthPlatformFeatureStatus,
        HealthPlatformStatus,
        HealthRecord,
        HealthRecordId,
        MeasurementUnit,
        HealthDataPermission,
        HealthPlatformFeaturePermission,
        Permission,
        PermissionStatus,
        PermissionRequestResult,
        ReadRecordRequest,
        ReadRecordsRequest,
        ReadRecordsResponse,
        require,
        requireEndTimeAfterStartTime,
        sinceV1_0_0,
        PlatformSpecificBehaviors,
        supportedOnHealthConnect,
        ExperimentalOn;
import 'package:health_connector_hc_android/health_connector_hc_android.dart'
    show HealthConnectorHCClient;
import 'package:health_connector_logger/health_connector_logger.dart'
    show HealthConnectorLogger;
import 'package:meta/meta.dart' show immutable;

/// Main entry point for interacting with platform-specific health APIs.
///
/// [HealthConnector] provides a unified interface for accessing health data
/// across different health platforms.
///
/// This class uses a factory pattern to create instances. Use
/// [HealthConnector.create] to obtain an instance.
@sinceV1_0_0
@immutable
final class HealthConnector {
  const HealthConnector._({
    required this.config,
    required HealthPlatform healthPlatform,
    required HealthConnectorPlatformClient healthPlatformClient,
  }) : _healthPlatform = healthPlatform,
       _client = healthPlatformClient;

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
  static Future<HealthConnector> create(HealthConnectorConfig config) async {
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
          phase: 'failed',
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
          phase: 'failed',
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
          phase: 'succeeded',
          message: 'HealthConnector created successfully',
          context: {'platform': healthPlatform.name},
        );

        final healthPlatformClient = switch (healthPlatform) {
          HealthPlatform.appleHealth => config.healthKitClient,
          HealthPlatform.healthConnect => config.healthConnectClient,
        };

        return HealthConnector._(
          config: config,
          healthPlatform: healthPlatform,
          healthPlatformClient: healthPlatformClient,
        );
    }
  }

  final HealthConnectorConfig config;
  final HealthPlatform _healthPlatform;
  final HealthConnectorPlatformClient _client;

  /// The health platform being used by this connector.
  HealthPlatform get healthPlatform => _healthPlatform;

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
  ///     final connector = await HealthConnector.create(config);
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
      phase: 'entry',
      message: 'Checking health platform status',
    );

    try {
      final healthPlatform = Platform.isIOS
          ? HealthPlatform.appleHealth
          : HealthPlatform.healthConnect;
      final healthPlatformClient = switch (healthPlatform) {
        HealthPlatform.appleHealth => HealthConnectorConfig().healthKitClient,
        HealthPlatform.healthConnect =>
          HealthConnectorConfig().healthConnectClient,
      };

      final status = await healthPlatformClient.getHealthPlatformStatus();

      HealthConnectorLogger.info(
        _tag,
        operation: 'getHealthPlatformStatus',
        phase: 'succeeded',
        message: 'Health platform status retrieved',
        context: {'status': status.name},
      );

      return status;
    } catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'getHealthPlatformStatus',
        phase: 'failed',
        message: 'Failed to get health platform status',
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

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
  /// final connector = await HealthConnector.create(config);
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
  ) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'requestPermissions',
      phase: 'entry',
      message: 'Requesting permissions',
      context: {'permissions': permissions},
    );

    if (permissions.isEmpty) {
      return [];
    }

    try {
      final results = await _client.requestPermissions(permissions);

      HealthConnectorLogger.info(
        _tag,
        operation: 'requestPermissions',
        phase: 'succeeded',
        message: 'Permissions requested successfully',
        context: {'results': results},
      );

      return results;
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'requestPermissions',
        phase: 'failed',
        message: 'Failed to request permissions',
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

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
  /// final connector = await HealthConnector.create(config);
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
  Future<List<Permission>> getGrantedPermissions() async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'getGrantedPermissions',
      phase: 'entry',
      message: 'Getting granted permissions',
    );

    switch (_healthPlatform) {
      case HealthPlatform.appleHealth:
        HealthConnectorLogger.error(
          _tag,
          operation: 'getGrantedPermissions',
          phase: 'failed',
          message: 'getGrantedPermissions is only available on Health Connect',
          context: {'current_health_platform': _healthPlatform.name},
        );

        throw const HealthConnectorException(
          HealthConnectorErrorCode.unsupportedOperation,
          'getGrantedPermissions is only available on Health Connect. ',
        );
      case HealthPlatform.healthConnect:
        try {
          final hcClient = _client as HealthConnectorHCClient;
          final permissions = await hcClient.getGrantedPermissions();

          HealthConnectorLogger.info(
            _tag,
            operation: 'getGrantedPermissions',
            phase: 'succeeded',
            message: 'Granted permissions retrieved',
            context: {'permissions': permissions},
          );

          return permissions;
        } catch (e, st) {
          HealthConnectorLogger.error(
            _tag,
            operation: 'getGrantedPermissions',
            phase: 'failed',
            message: 'Failed to get granted permissions',
            exception: e,
            stackTrace: st,
          );

          rethrow;
        }
    }
  }

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
  /// final connector = await HealthConnector.create(config);
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
  Future<void> revokeAllPermissions() async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'revokeAllPermissions',
      phase: 'entry',
      message: 'Revoking all permissions',
    );

    switch (_healthPlatform) {
      case HealthPlatform.appleHealth:
        HealthConnectorLogger.error(
          _tag,
          operation: 'revokeAllPermissions',
          phase: 'failed',
          message: 'revokeAllPermissions is only available on Health Connect',
          context: {'current_health_platform': _healthPlatform.name},
        );

        throw const HealthConnectorException(
          HealthConnectorErrorCode.unsupportedOperation,
          'revokeAllPermissions is only available on Health Connect. ',
        );
      case HealthPlatform.healthConnect:
        try {
          final hcClient = _client as HealthConnectorHCClient;
          await hcClient.revokeAllPermissions();

          HealthConnectorLogger.info(
            _tag,
            operation: 'revokeAllPermissions',
            phase: 'succeeded',
            message: 'All permissions revoked successfully',
          );
        } catch (e, st) {
          HealthConnectorLogger.error(
            _tag,
            operation: 'revokeAllPermissions',
            phase: 'failed',
            message: 'Failed to revoke all permissions',
            exception: e,
            stackTrace: st,
          );

          rethrow;
        }
    }
  }

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
  /// final connector = await HealthConnector.create(config);
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
  ) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'getFeatureStatus',
      phase: 'entry',
      message: 'Checking feature status',
      context: {'feature': feature.toString()},
    );

    switch (_healthPlatform) {
      case HealthPlatform.appleHealth:
        HealthConnectorLogger.info(
          _tag,
          operation: 'getFeatureStatus',
          phase: 'succeeded',
          message: 'Feature status retrieved',
          context: {'feature': feature.toString(), 'status': 'available'},
        );

        return HealthPlatformFeatureStatus.available;
      case HealthPlatform.healthConnect:
        try {
          final hcClient = _client as HealthConnectorHCClient;
          final status = await hcClient.getFeatureStatus(feature);

          HealthConnectorLogger.info(
            _tag,
            operation: 'getFeatureStatus',
            phase: 'succeeded',
            message: 'Feature status retrieved',
            context: {
              'feature': feature.toString(),
              'status': status.name,
            },
          );

          return status;
        } catch (e, st) {
          HealthConnectorLogger.error(
            _tag,
            operation: 'getFeatureStatus',
            phase: 'failed',
            message: 'Failed to get feature status',
            context: {'feature': feature.toString()},
            exception: e,
            stackTrace: st,
          );

          rethrow;
        }
    }
  }

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
  ) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'readRecord',
      phase: 'entry',
      message: 'Reading health record',
      context: {'request': request},
    );

    try {
      final record = await _client.readRecord(request);

      if (record != null) {
        HealthConnectorLogger.info(
          _tag,
          operation: 'readRecord',
          phase: 'succeeded',
          message: 'Health record read successfully',
          context: {'request': request, 'response': record},
        );
      } else {
        HealthConnectorLogger.info(
          _tag,
          operation: 'readRecord',
          phase: 'succeeded',
          message: 'Health record not found',
          context: {'request': request, 'response': null},
        );
      }

      return record;
    } catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'readRecord',
        phase: 'failed',
        message: 'Failed to read health record',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

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
  ) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'readRecords',
      phase: 'entry',
      message: 'Reading health records',
      context: {'request': request},
    );

    try {
      final response = await _client.readRecords(request);

      HealthConnectorLogger.info(
        _tag,
        operation: 'readRecords',
        phase: 'succeeded',
        message: 'Health records read successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'readRecords',
        phase: 'failed',
        message: 'Failed to read health records',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

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
  /// final record = StepRecord(
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
  Future<HealthRecordId> writeRecord<R extends HealthRecord>(R record) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'writeRecord',
      phase: 'entry',
      message: 'Writing health record',
      context: {'record': record},
    );

    try {
      require(
        record.id == HealthRecordId.none,
        'Record ID must be HealthRecordId.none for new records. ',
      );

      final recordId = await _client.writeRecord(record);

      HealthConnectorLogger.info(
        _tag,
        operation: 'writeRecord',
        phase: 'succeeded',
        message: 'Health record written successfully',
        context: {'record': record, 'assignedRecordId': recordId},
      );

      return recordId;
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'writeRecord',
        phase: 'failed',
        message: 'Validation failed',
        context: {'record': record},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        HealthConnectorErrorCode.invalidArgument,
        (e.message as String?) ?? e.toString(),
      );
    } catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'writeRecord',
        phase: 'failed',
        message: 'Failed to write health record',
        context: {'record': record},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

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
  ///   StepRecord(
  ///     startTime: DateTime(2024, 1, 1, 9, 0),
  ///     endTime: DateTime(2024, 1, 1, 10, 0),
  ///     count: Numeric(1200),
  ///     metadata: Metadata.automaticallyRecorded(
  ///       device: Device.fromType(DeviceType.phone),
  ///     ),
  ///   ),
  ///   StepRecord(
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
  ) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'writeRecords',
      phase: 'entry',
      message: 'Writing health records',
      context: {'records': records},
    );

    if (records.isEmpty) {
      return [];
    }

    try {
      if (records.any((record) => record.id == HealthRecordId.none)) {
        throw ArgumentError(
          'All records must have `HealthRecordId.none` for new records.',
        );
      }

      final recordIds = await _client.writeRecords(records);

      HealthConnectorLogger.info(
        _tag,
        operation: 'writeRecords',
        phase: 'succeeded',
        message: 'Health records written successfully',
        context: {'records': records, 'assignedRecordIds': recordIds},
      );

      return recordIds;
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'writeRecords',
        phase: 'failed',
        message: 'Validation failed',
        context: {'records': records},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        HealthConnectorErrorCode.invalidArgument,
        (e.message as String?) ?? e.toString(),
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'writeRecords',
        phase: 'failed',
        message: 'Failed to write health records',
        context: {'records': records},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

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
  >(AggregateRequest<R, U> request) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'aggregate',
      phase: 'entry',
      message: 'Aggregating health data',
      context: {'request': request},
    );

    try {
      final response = await _client.aggregate(request);

      HealthConnectorLogger.info(
        _tag,
        operation: 'aggregate',
        phase: 'succeeded',
        message: 'Health data aggregated successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'aggregate',
        phase: 'failed',
        message: 'Failed to aggregate health data',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

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
  }) async {
    final request = {
      'dataType': dataType,
      'startTime': startTime,
      'endTime': endTime,
    };

    HealthConnectorLogger.debug(
      _tag,
      operation: 'deleteRecords',
      phase: 'entry',
      message: 'Deleting health records by time range',
      context: {'request': request},
    );

    try {
      requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);

      await _client.deleteRecords(
        dataType: dataType,
        startTime: startTime,
        endTime: endTime,
      );

      HealthConnectorLogger.info(
        _tag,
        operation: 'deleteRecords',
        phase: 'succeeded',
        message: 'Health records deleted successfully',
        context: {'request': request},
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'deleteRecords',
        phase: 'failed',
        message: 'Failed to delete health records',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

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
  }) async {
    final request = {
      'dataType': dataType,
      'recordIds': recordIds,
    };

    HealthConnectorLogger.debug(
      _tag,
      operation: 'deleteRecordsByIds',
      phase: 'entry',
      message: 'Deleting health records by IDs',
      context: {'request': request},
    );

    try {
      if (recordIds.any((id) => id == HealthRecordId.none)) {
        throw ArgumentError(
          'All record IDs must not be `HealthRecordId.none`.',
        );
      }

      await _client.deleteRecordsByIds(
        dataType: dataType,
        recordIds: recordIds,
      );

      HealthConnectorLogger.info(
        _tag,
        operation: 'deleteRecordsByIds',
        phase: 'succeeded',
        message: 'Health records deleted successfully',
        context: {'request': request},
      );
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'deleteRecordsByIds',
        phase: 'failed',
        message: 'Validation failed',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        HealthConnectorErrorCode.invalidArgument,
        (e.message as String?) ?? e.toString(),
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'deleteRecordsByIds',
        phase: 'failed',
        message: 'Failed to delete health records by IDs',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  /// Updates an existing health record on the platform.
  ///
  /// Modifies an existing health record with new values. The record must have
  /// a valid existing ID (not [HealthRecordId.none]).
  ///
  /// ## Parameters
  ///
  /// - [record]: The health record to update (must have a valid existing ID)
  ///
  /// ## Returns
  ///
  /// The [HealthRecordId] of the updated record.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] with
  ///   [HealthConnectorErrorCode.invalidArgument] if the record ID is
  ///   [HealthRecordId.none] or invalid
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if write/delete permission has not been granted
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.notAuthorized]
  ///   if attempting to update a record not created by this app
  /// - [HealthConnectorException] with [HealthConnectorErrorCode.unknown]
  ///   if an unexpected error occurs
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Read an existing record
  /// final recordId = HealthRecordId('existing-record-id');
  /// final request = HealthDataType.steps.readRecord(recordId);
  /// final existingRecord = await connector.readRecord(request);
  ///
  /// if (existingRecord != null) {
  ///   // Create updated record with modified values
  ///   final updatedRecord = StepRecord(
  ///     id: existingRecord.id, // Preserve the original ID
  ///     startTime: existingRecord.startTime,
  ///     endTime: existingRecord.endTime,
  ///     count: Numeric(existingRecord.count.value + 100), // Update step count
  ///     metadata: existingRecord.metadata,
  ///   );
  ///
  ///   final newRecordId = await connector.updateRecord(updatedRecord);
  ///   print('Record updated. New ID: ${newRecordId.value}');
  /// }
  /// ```
  @PlatformSpecificBehaviors({
    HealthPlatform.appleHealth:
        'Uses immutable data model. The plugin implemented as '
        '`delete-then-insert`, so returns a new UUID different from input ID.',
    HealthPlatform.healthConnect:
        'Provides native update API. '
        'Record ID is preserved during update operation.',
  })
  @ExperimentalOn({
    HealthPlatform.appleHealth:
        'The plugin implemented deletion operation as `delete-then-insert`, '
        'so returns a new UUID different from input ID.',
  })
  Future<HealthRecordId> updateRecord<R extends HealthRecord>(R record) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'updateRecord',
      phase: 'entry',
      message: 'Updating health record',
      context: {'record': record},
    );

    try {
      require(
        record.id != HealthRecordId.none,
        'Record ID must not be HealthRecordId.none for updates. ',
      );

      final recordId = await _client.updateRecord(record);

      HealthConnectorLogger.info(
        _tag,
        operation: 'updateRecord',
        phase: 'succeeded',
        message: 'Health record updated successfully',
        context: {'record': record},
      );

      return recordId;
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.warning(
        _tag,
        operation: 'updateRecord',
        phase: 'failed',
        message: 'Validation failed',
        context: {'record': record},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        HealthConnectorErrorCode.invalidArgument,
        (e.message as String?) ?? e.toString(),
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'updateRecord',
        phase: 'failed',
        message: 'Failed to update health record',
        context: {'record': record},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }
}
