import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        HealthConnectorConfig,
        HealthConnectorException,
        HealthConnectorPlatformClient,
        HealthDataPermission,
        HealthPlatformFeaturePermission,
        HealthPlatformStatus,
        HealthRecord,
        HealthRecordId,
        MeasurementUnit,
        Permission,
        PermissionRequestResult,
        PermissionStatus,
        ReadRecordByIdRequest,
        ReadRecordsInTimeRangeRequest,
        ReadRecordsInTimeRangeResponse,
        PermissionListExtension,
        sinceV1_0_0,
        internalUse,
        HealthConnectorErrorCode,
        DeleteRecordsRequest;
import 'package:health_connector_hk_ios/src/mappers/config_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_connector_error_code_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/request_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/response_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthConnectorHKIOSApi, HealthPlatformStatusDto;
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart' show immutable;

/// Platform client that communicates with native iOS HealthKit code.
///
/// This class acts as a bridge between Dart and platform-specific native code,
/// using generated Pigeon code for type-safe method channel communication.
@sinceV1_0_0
@internalUse
@immutable
final class HealthConnectorHKClient implements HealthConnectorPlatformClient {
  static const _tag = 'HealthConnectorHKClient';

  /// The Pigeon-generated platform API client for native communication.
  static final HealthConnectorHKIOSApi _platformClient =
      HealthConnectorHKIOSApi();

  /// Creates a new [HealthConnectorHKClient] instance with the given config.
  ///
  /// This factory method initializes the native iOS HealthKit platform code
  /// with the provided configuration before returning the client instance.
  ///
  /// ## Parameters
  ///
  /// - [config]: The configuration to use for initializing the client.
  ///
  /// ## Returns
  ///
  /// A configured [HealthConnectorHKClient] instance ready for use.
  static Future<HealthConnectorHKClient> create([
    HealthConnectorConfig config = const HealthConnectorConfig(),
  ]) async {
    await _platformClient.initialize(config.toDto());

    return HealthConnectorHKClient._(config);
  }

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
  static Future<HealthPlatformStatus> getHealthPlatformStatus() async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'getHealthPlatformStatus',
      message: 'Checking HealthKit platform status',
    );

    try {
      final statusDto = await _platformClient.getHealthPlatformStatus();

      final status = switch (statusDto) {
        HealthPlatformStatusDto.available => HealthPlatformStatus.available,
        HealthPlatformStatusDto.notAvailable =>
          HealthPlatformStatus.unavailable,
      };

      HealthConnectorLogger.info(
        _tag,
        operation: 'getHealthPlatformStatus',
        message: 'HealthKit platform status retrieved',
        context: {
          'health_platform_status': status.name,
        },
      );

      return status;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'getHealthPlatformStatus',
        message: 'Failed to get HealthKit platform status',
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to get health platform status: '
        '${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  const HealthConnectorHKClient._(this._config);

  final HealthConnectorConfig _config;

  @override
  HealthConnectorConfig get config => _config;

  /// iOS-specific implementation that auto-grants feature permissions.
  ///
  /// HealthKit doesn't have a separate permission system for features, so
  /// [HealthPlatformFeaturePermission] instances are automatically granted.
  /// Health data permissions are processed through the native permission flow.
  @override
  Future<List<PermissionRequestResult>> requestPermissions(
    List<Permission> permissions,
  ) async {
    final healthDataPermissions = permissions.healthDataPermissions;
    final featurePermissions = permissions.featurePermissions;
    final healthDataCount = healthDataPermissions.length;
    final featureCount = featurePermissions.length;

    HealthConnectorLogger.debug(
      tag,
      operation: 'requestPermissions',
      message: 'Requesting HealthKit permissions',
      context: {
        'requested_health_data_permissions': healthDataPermissions,
        'requested_feature_permissions': featurePermissions,
        'health_data_count': healthDataCount,
        'feature_count': featureCount,
      },
    );

    if (permissions.isEmpty) {
      HealthConnectorLogger.warning(
        tag,
        operation: 'requestPermissions',
        message: 'No permissions to request (empty list)',
      );

      return [];
    }

    final results = <PermissionRequestResult>[];

    // Process health data permissions through the native iOS permission dialog
    if (healthDataPermissions.isNotEmpty) {
      try {
        final requestDto = healthDataPermissions.toDto();

        final responseDto = await _platformClient.requestPermissions(
          requestDto,
        );

        final healthDataResults = responseDto.toDomain();
        results.addAll(healthDataResults);
      } on PlatformException catch (e, st) {
        HealthConnectorLogger.error(
          tag,
          operation: 'requestPermissions',
          message: 'Failed to request HealthKit permissions',
          context: {
            'requested_permissions': {
              'health_data_permissions': healthDataPermissions,
            },
          },
          exception: e,
          stackTrace: st,
        );

        throw HealthConnectorException(
          e.code.toHealthConnectorErrorCode(),
          'Failed to request permissions: ${e.message ?? 'Unknown error'}',
          cause: e,
          stackTrace: st,
        );
      }
    }

    // Auto-grant feature permissions on iOS, as iOS doesn't have a separate
    // permission system for features
    if (featurePermissions.isNotEmpty) {
      final grantedFeaturePermissions = featurePermissions.map(
        (permission) => PermissionRequestResult(
          permission: permission,
          status: PermissionStatus.granted,
        ),
      );
      results.addAll(grantedFeaturePermissions);
    }

    final grantedPermissions = results
        .where((result) => result.status == PermissionStatus.granted)
        .map((result) => result.permission)
        .toList();
    final grantedHealthDataPermissions =
        grantedPermissions.healthDataPermissions;

    HealthConnectorLogger.info(
      tag,
      operation: 'requestPermissions',
      message: 'HealthKit permissions requested successfully',
      context: {
        'granted_health_data_permissions': grantedHealthDataPermissions,
        'auto_granted_feature_permissions_count': featureCount,
        'total_results': results.length,
      },
    );

    return results;
  }

  @override
  Future<PermissionStatus> getPermissionStatus(Permission permission) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'getPermissionStatus',
      message: 'Getting permission status',
      context: {'permission': permission},
    );

    // Handle feature permissions - automatically granted on iOS
    if (permission is HealthPlatformFeaturePermission) {
      HealthConnectorLogger.info(
        tag,
        operation: 'getPermissionStatus',
        message: 'Feature permission status - automatically granted on iOS',
        context: {'permission': permission},
      );
      return PermissionStatus.granted;
    }

    // Cast to HealthDataPermission
    final healthDataPermission = permission as HealthDataPermission;

    try {
      final permissionDto = healthDataPermission.toDto();

      final statusDto = await _platformClient.getPermissionStatus(
        permissionDto,
      );

      final status = statusDto.toDomain();

      HealthConnectorLogger.info(
        tag,
        operation: 'getPermissionStatus',
        message: 'Permission status retrieved',
        context: {'permission': permission, 'status': status.name},
      );

      return status;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'getPermissionStatus',
        message: 'Failed to get permission status',
        context: {'permission': permission},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to get permission status: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<R?> readRecord<R extends HealthRecord>(
    ReadRecordByIdRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecord',
      message: 'Reading HealthKit record',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.readRecord(requestDto);

      final record = responseDto?.toDomain() as R?;

      if (record == null) {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'HealthKit record not found',
          context: {'request': request, 'response': null},
        );
      } else {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'HealthKit record read successfully',
          context: {'request': request, 'response': record},
        );
      }

      return record;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecord',
        message: 'Failed to read HealthKit record',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to process $request: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<ReadRecordsInTimeRangeResponse<R>> readRecords<R extends HealthRecord>(
    ReadRecordsInTimeRangeRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecords',

      message: 'Reading HealthKit records',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.readRecords(requestDto);

      final response = responseDto.toDomain<R>(request);

      HealthConnectorLogger.info(
        tag,
        operation: 'readRecords',
        message: 'HealthKit records read successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecords',
        message: 'Failed to read HealthKit records',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to process $request: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<HealthRecordId> writeRecord<R extends HealthRecord>(R record) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'write_record',

      message: 'Writing HealthKit record',
      context: {'record': record},
    );

    try {
      final idString = await _platformClient.writeRecord(record.toDto());

      final recordId = idString.toDomain();

      HealthConnectorLogger.info(
        tag,
        operation: 'write_record',
        message: 'HealthKit record written successfully',
        context: {'record': record, 'record_id': recordId},
      );

      return recordId;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'write_record',
        message: 'Failed to write HealthKit record',
        context: {'record': record},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to write $record: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<List<HealthRecordId>> writeRecords<R extends HealthRecord>(
    List<R> records,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'write_records',

      message: 'Writing HealthKit records',
      context: {'records': records},
    );

    if (records.isEmpty) {
      HealthConnectorLogger.warning(
        tag,
        operation: 'write_records',
        message: 'No records to write (empty list)',
      );

      return [];
    }

    try {
      final recordDtos = records.map((record) => record.toDto()).toList();

      final idStrings = await _platformClient.writeRecords(recordDtos);

      final recordIds = idStrings.map((id) => id.toDomain()).toList();

      HealthConnectorLogger.info(
        tag,
        operation: 'write_records',
        message: 'HealthKit records written successfully',
        context: {'records': records, 'record_ids': recordIds},
      );

      return recordIds;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'write_records',
        message: 'Failed to write HealthKit records',
        context: {'records': records},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to write $records: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<HealthRecordId> updateRecord<R extends HealthRecord>(R record) async {
    throw const HealthConnectorException(
      HealthConnectorErrorCode.unsupportedOperation,
      'updateRecord API is not supported on iOS HealthKit SDK',
    );
  }

  @override
  Future<void> updateRecords<R extends HealthRecord>(List<R> records) {
    throw const HealthConnectorException(
      HealthConnectorErrorCode.unsupportedOperation,
      'updateRecords API is not supported on iOS HealthKit SDK',
    );
  }

  @override
  Future<U> aggregate<R extends HealthRecord, U extends MeasurementUnit>(
    AggregateRequest<R, U> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'aggregate',

      message: 'Aggregating HealthKit data',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.aggregate(requestDto);

      final response = responseDto.toDomain() as U;

      HealthConnectorLogger.info(
        tag,
        operation: 'aggregate',
        message: 'HealthKit data aggregated successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'aggregate',
        message: 'Failed to aggregate HealthKit data',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to process $request: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> deleteRecords<R extends HealthRecord>(
    DeleteRecordsRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'deleteRecords',
      message: 'Deleting HealthKit records by time range',
      context: {'request': request},
    );

    try {
      await _platformClient.deleteRecords(request.toDto());

      HealthConnectorLogger.info(
        tag,
        operation: 'deleteRecords',
        message: 'HealthKit records deleted successfully',
        context: {'request': request},
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'deleteRecords',
        message: 'Failed to delete HealthKit records',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to delete records by $request: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }
}
