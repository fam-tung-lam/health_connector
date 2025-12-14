import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        AggregateResponse,
        HealthConnectorConfig,
        HealthConnectorException,
        HealthConnectorPlatformClient,
        HealthDataType,
        HealthPlatformFeaturePermission,
        HealthPlatformStatus,
        HealthRecord,
        HealthRecordId,
        MeasurementUnit,
        Permission,
        PermissionRequestResult,
        PermissionStatus,
        ReadRecordRequest,
        ReadRecordsRequest,
        ReadRecordsResponse,
        formatTimeRange,
        PermissionListExtension,
        sinceV1_0_0,
        internalUse;
import 'package:health_connector_hk_ios/src/mappers/config_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_connector_error_code_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/request_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/response_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show
        DeleteRecordsByIdsRequestDto,
        DeleteRecordsByTimeRangeRequestDto,
        HealthConnectorPlatformApi,
        HealthPlatformStatusDto;
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
  const HealthConnectorHKClient._();

  /// The Pigeon-generated platform API client for native communication.
  static final HealthConnectorPlatformApi _platformClient =
      HealthConnectorPlatformApi();

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
    return const HealthConnectorHKClient._();
  }

  @override
  Future<HealthPlatformStatus> getHealthPlatformStatus() async {
    HealthConnectorLogger.debug(
      tag,
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
        tag,
        operation: 'getHealthPlatformStatus',
        message: 'HealthKit platform status retrieved',
        context: {
          'health_platform_status': status.name,
        },
      );

      return status;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
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
  Future<R?> readRecord<R extends HealthRecord>(
    ReadRecordRequest<R> request,
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

      if (responseDto == null) {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'HealthKit record not found',
          context: {'request': request, 'response': null},
        );

        return null; // Record not found
      }

      final record = responseDto.record?.toDomain() as R?;

      HealthConnectorLogger.info(
        tag,
        operation: 'readRecord',
        message: 'HealthKit record read successfully',
        context: {'request': request, 'response': record},
      );

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
  Future<ReadRecordsResponse<R>> readRecords<R extends HealthRecord>(
    ReadRecordsRequest<R> request,
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
      operation: 'writeRecord',

      message: 'Writing HealthKit record',
      context: {'record': record},
    );

    try {
      final requestDto = record.toWriteRecordRequestDto();

      final responseDto = await _platformClient.writeRecord(requestDto);

      final assignedRecordId = responseDto.recordId.toDomain();

      HealthConnectorLogger.info(
        tag,
        operation: 'writeRecord',

        message: 'HealthKit record written successfully',
        context: {'record': record, 'assignedRecordId': assignedRecordId},
      );

      return assignedRecordId;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecord',

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
      operation: 'writeRecords',

      message: 'Writing HealthKit records',
      context: {'records': records},
    );

    if (records.isEmpty) {
      HealthConnectorLogger.warning(
        tag,
        operation: 'writeRecords',

        message: 'No records to write (empty list)',
      );

      return [];
    }

    try {
      final requestDto = records.toWriteRecordsRequestDto();

      final responseDto = await _platformClient.writeRecords(requestDto);

      final recordIds = responseDto.recordIds
          .map((id) => id.toDomain())
          .toList();

      HealthConnectorLogger.info(
        tag,
        operation: 'writeRecords',

        message: 'HealthKit records written successfully',
        context: {'records': records, 'assignedRecordIds': recordIds},
      );

      return recordIds;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecords',

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
    HealthConnectorLogger.debug(
      tag,
      operation: 'updateRecord',

      message: 'Updating HealthKit record',
      context: {'record': record},
    );

    try {
      final requestDto = record.toUpdateRecordRequestDto();

      final responseDto = await _platformClient.updateRecord(requestDto);

      final updatedRecordId = responseDto.recordId.toDomain();

      HealthConnectorLogger.info(
        tag,
        operation: 'updateRecord',

        message: 'HealthKit record updated successfully',
        context: {'record': record},
      );

      return updatedRecordId;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'updateRecord',

        message: 'Failed to update HealthKit record',
        context: {'record': record},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to update $record: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<AggregateResponse<R, U>> aggregate<
    R extends HealthRecord,
    U extends MeasurementUnit
  >(AggregateRequest<R, U> request) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'aggregate',

      message: 'Aggregating HealthKit data',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.aggregate(requestDto);

      final response = responseDto.toDomain<R, U>(request.dataType);

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
  Future<void> deleteRecords<R extends HealthRecord>({
    required HealthDataType<R, MeasurementUnit> dataType,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final request = {
      'dataType': dataType,
      'timeRange': formatTimeRange(startTime: startTime, endTime: endTime),
    };

    HealthConnectorLogger.debug(
      tag,
      operation: 'deleteRecords',

      message: 'Deleting HealthKit records by time range',
      context: {'request': request},
    );

    try {
      final requestDto = DeleteRecordsByTimeRangeRequestDto(
        dataType: dataType.toDto(),
        startTime: startTime.millisecondsSinceEpoch,
        endTime: endTime.millisecondsSinceEpoch,
      );

      await _platformClient.deleteRecordsByTimeRange(requestDto);

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

  @override
  Future<void> deleteRecordsByIds<R extends HealthRecord>({
    required HealthDataType<R, MeasurementUnit> dataType,
    required List<HealthRecordId> recordIds,
  }) async {
    final request = {
      'dataType': dataType,
      'recordIds': recordIds,
    };

    HealthConnectorLogger.debug(
      tag,
      operation: 'deleteRecordsByIds',

      message: 'Deleting HealthKit records by IDs',
      context: {'request': request},
    );

    if (recordIds.isEmpty) {
      HealthConnectorLogger.warning(
        tag,
        operation: 'deleteRecordsByIds',

        message: 'No records to delete (empty IDs list)',
      );

      return;
    }

    try {
      final requestDto = DeleteRecordsByIdsRequestDto(
        dataType: dataType.toDto(),
        recordIds: recordIds.map((id) => id.toDto()).toList(),
      );

      await _platformClient.deleteRecordsByIds(requestDto);

      HealthConnectorLogger.info(
        tag,
        operation: 'deleteRecordsByIds',

        message: 'HealthKit records deleted successfully',
        context: {'request': request},
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'deleteRecordsByIds',

        message: 'Failed to delete HealthKit records by IDs',
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
