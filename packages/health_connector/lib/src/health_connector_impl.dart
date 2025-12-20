import 'package:health_connector/health_connector.dart' show HealthConnector;
import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        AggregateResponse,
        DeleteRecordsRequest,
        DeleteRecordsByIdsRequest,
        DeleteRecordsInTimeRangeRequest,
        HealthConnectorConfig,
        HealthConnectorException,
        HealthConnectorErrorCode,
        HealthConnectorPlatformClient,
        HealthPlatform,
        HealthPlatformFeature,
        HealthPlatformFeatureStatus,
        HealthRecord,
        HealthRecordId,
        MeasurementUnit,
        Permission,
        PermissionRequestResult,
        PermissionStatus,
        ReadRecordByIdRequest,
        ReadRecordsInTimeRangeRequest,
        ReadRecordsInTimeRangeResponse,
        require,
        sinceV1_0_0,
        supportedOnHealthConnect;
import 'package:health_connector_hc_android/health_connector_hc_android.dart'
    show HealthConnectorHCClient;
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart' show immutable;

@sinceV1_0_0
@immutable
final class HealthConnectorImpl implements HealthConnector {
  const HealthConnectorImpl({
    required HealthConnectorConfig config,
    required HealthPlatform healthPlatform,
    required HealthConnectorPlatformClient healthPlatformClient,
  }) : _config = config,
       _healthPlatform = healthPlatform,
       _client = healthPlatformClient;

  final HealthConnectorConfig _config;
  final HealthPlatform _healthPlatform;
  final HealthConnectorPlatformClient _client;

  @override
  HealthConnectorConfig get config => _config;

  @override
  HealthPlatform get healthPlatform => _healthPlatform;

  @override
  Future<List<PermissionRequestResult>> requestPermissions(
    List<Permission> permissions,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'requestPermissions',
      message: 'Requesting permissions',
      context: {'permissions': permissions},
    );

    if (permissions.isEmpty) {
      return [];
    }

    try {
      final results = await _client.requestPermissions(permissions);

      HealthConnectorLogger.info(
        tag,
        operation: 'requestPermissions',
        message: 'Permissions requested successfully',
        context: {'results': results},
      );

      return results;
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'requestPermissions',
        message: 'Failed to request permissions',
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @supportedOnHealthConnect
  @override
  Future<List<Permission>> getGrantedPermissions() async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'getGrantedPermissions',
      message: 'Getting granted permissions',
    );

    switch (_healthPlatform) {
      case HealthPlatform.appleHealth:
        HealthConnectorLogger.error(
          tag,
          operation: 'getGrantedPermissions',
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
            tag,
            operation: 'getGrantedPermissions',
            message: 'Granted permissions retrieved',
            context: {'permissions': permissions},
          );

          return permissions;
        } catch (e, st) {
          HealthConnectorLogger.error(
            tag,
            operation: 'getGrantedPermissions',
            message: 'Failed to get granted permissions',
            exception: e,
            stackTrace: st,
          );

          rethrow;
        }
    }
  }

  @override
  Future<PermissionStatus> getPermissionStatus(Permission permission) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'getPermissionStatus',
      message: 'Getting permission status',
      context: {'permission': permission},
    );

    try {
      final status = await _client.getPermissionStatus(permission);

      HealthConnectorLogger.info(
        tag,
        operation: 'getPermissionStatus',
        message: 'Permission status retrieved',
        context: {'permission': permission, 'status': status.name},
      );

      return status;
    } catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'getPermissionStatus',
        message: 'Failed to get permission status',
        context: {'permission': permission},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @supportedOnHealthConnect
  @override
  Future<void> revokeAllPermissions() async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'revokeAllPermissions',
      message: 'Revoking all permissions',
    );

    switch (_healthPlatform) {
      case HealthPlatform.appleHealth:
        HealthConnectorLogger.error(
          tag,
          operation: 'revokeAllPermissions',
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
            tag,
            operation: 'revokeAllPermissions',
            message: 'All permissions revoked successfully',
          );
        } catch (e, st) {
          HealthConnectorLogger.error(
            tag,
            operation: 'revokeAllPermissions',
            message: 'Failed to revoke all permissions',
            exception: e,
            stackTrace: st,
          );

          rethrow;
        }
    }
  }

  @override
  Future<HealthPlatformFeatureStatus> getFeatureStatus(
    HealthPlatformFeature feature,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'getFeatureStatus',
      message: 'Checking feature status',
      context: {'feature': feature.toString()},
    );

    switch (_healthPlatform) {
      case HealthPlatform.appleHealth:
        HealthConnectorLogger.info(
          tag,
          operation: 'getFeatureStatus',
          message: 'Feature status retrieved',
          context: {'feature': feature.toString(), 'status': 'available'},
        );

        return HealthPlatformFeatureStatus.available;
      case HealthPlatform.healthConnect:
        try {
          final hcClient = _client as HealthConnectorHCClient;
          final status = await hcClient.getFeatureStatus(feature);

          HealthConnectorLogger.info(
            tag,
            operation: 'getFeatureStatus',
            message: 'Feature status retrieved',
            context: {
              'feature': feature.toString(),
              'status': status.name,
            },
          );

          return status;
        } catch (e, st) {
          HealthConnectorLogger.error(
            tag,
            operation: 'getFeatureStatus',
            message: 'Failed to get feature status',
            context: {'feature': feature.toString()},
            exception: e,
            stackTrace: st,
          );

          rethrow;
        }
    }
  }

  @override
  Future<R?> readRecord<R extends HealthRecord>(
    ReadRecordByIdRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecord',
      message: 'Reading health record',
      context: {'request': request},
    );

    try {
      final record = await _client.readRecord(request);

      if (record != null) {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'Health record read successfully',
          context: {'request': request, 'response': record},
        );
      } else {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'Health record not found',
          context: {'request': request, 'response': null},
        );
      }

      return record;
    } catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecord',
        message: 'Failed to read health record',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<ReadRecordsInTimeRangeResponse<R>> readRecords<R extends HealthRecord>(
    ReadRecordsInTimeRangeRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecords',
      message: 'Reading health records',
      context: {'request': request},
    );

    try {
      final response = await _client.readRecords(request);

      HealthConnectorLogger.info(
        tag,
        operation: 'readRecords',
        message: 'Health records read successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecords',
        message: 'Failed to read health records',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<HealthRecordId> writeRecord<R extends HealthRecord>(R record) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'writeRecord',
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
        tag,
        operation: 'writeRecord',
        message: 'Health record written successfully',
        context: {'record': record, 'assignedRecordId': recordId},
      );

      return recordId;
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecord',
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
        tag,
        operation: 'writeRecord',
        message: 'Failed to write health record',
        context: {'record': record},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<List<HealthRecordId>> writeRecords<R extends HealthRecord>(
    List<R> records,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'writeRecords',
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
        tag,
        operation: 'writeRecords',
        message: 'Health records written successfully',
        context: {'records': records, 'assignedRecordIds': recordIds},
      );

      return recordIds;
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecords',
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
        tag,
        operation: 'writeRecords',
        message: 'Failed to write health records',
        context: {'records': records},
        exception: e,
        stackTrace: st,
      );

      rethrow;
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
      message: 'Aggregating health data',
      context: {'request': request},
    );

    try {
      final response = await _client.aggregate(request);

      HealthConnectorLogger.info(
        tag,
        operation: 'aggregate',
        message: 'Health data aggregated successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'aggregate',
        message: 'Failed to aggregate health data',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<void> deleteRecords<R extends HealthRecord>(
    DeleteRecordsRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'deleteRecords',
      message: 'Deleting health records by time range',
      context: {'request': request},
    );

    try {
      switch (request) {
        case DeleteRecordsInTimeRangeRequest<R> _:
          break;
        case final DeleteRecordsByIdsRequest<R> request:
          if (request.recordIds.isEmpty) {
            return;
          }
      }

      await _client.deleteRecords(request);

      HealthConnectorLogger.info(
        tag,
        operation: 'deleteRecords',
        message: 'Health records deleted successfully',
        context: {'request': request},
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'deleteRecords',
        message: 'Failed to delete health records',
        context: {'request': request},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<void> updateRecord<R extends HealthRecord>(R record) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'update_record',
      message: 'Updating health record',
      context: {'record': record},
    );

    try {
      require(
        record.id != HealthRecordId.none,
        'Record ID must not be HealthRecordId.none for updates. ',
      );

      await _client.updateRecord(record);

      HealthConnectorLogger.info(
        tag,
        operation: 'update_record',
        message: 'Health record updated successfully',
        context: {'record': record},
      );
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.warning(
        tag,
        operation: 'update_record',
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
        tag,
        operation: 'update_record',
        message: 'Failed to update health record',
        context: {'record': record},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<void> updateRecords<R extends HealthRecord>(List<R> records) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'update_records',
      message: 'Updating health records',
      context: {'records': records},
    );

    try {
      require(
        records.every((record) => record.id != HealthRecordId.none),
        'Record IDs must not be HealthRecordId.none for updates. ',
      );

      await _client.updateRecords(records);

      HealthConnectorLogger.info(
        tag,
        operation: 'update_records',
        message: 'Health records updated successfully',
        context: {'records': records},
      );
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.warning(
        tag,
        operation: 'update_records',
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
        tag,
        operation: 'update_records',
        message: 'Failed to update health records',
        context: {'records': records},
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }
}
