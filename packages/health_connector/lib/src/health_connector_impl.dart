import 'package:health_connector/health_connector.dart';
import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        AggregateRequest,
        DeleteRecordsRequest,
        DeleteRecordsByIdsRequest,
        DeleteRecordsInTimeRangeRequest,
        HealthConnectorConfig,
        HealthConnectorException,
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
        supportedOnHealthConnect,
        UnsupportedOperationException,
        InvalidArgumentException,
        ExerciseSessionRecord,
        ExerciseTypeExtension,
        sinceV2_0_0;
import 'package:health_connector_hc_android/health_connector_hc_android.dart'
    show HealthConnectorHCClient;
import 'package:meta/meta.dart' show internal, immutable;

@sinceV2_0_0
@internal
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
    final context = {
      'permission_count': permissions.length,
      'has_permissions': permissions.isNotEmpty,
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'requestPermissions',
      message: 'Requesting permissions',
      context: context,
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
        context: {
          ...context,
          'result_count': results.length,
          'granted_count': results
              .where((r) => r.status == PermissionStatus.granted)
              .length,
          'denied_count': results
              .where((r) => r.status == PermissionStatus.denied)
              .length,
          'unknown_count': results
              .where((r) => r.status == PermissionStatus.unknown)
              .length,
        },
      );

      return results;
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'requestPermissions',
        message: 'Failed to request permissions',
        exception: e,
        stackTrace: st,
        context: context,
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
        );

        throw const UnsupportedOperationException(
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
            context: {
              'permission_count': permissions.length,
            },
          );

          return permissions;
        } on HealthConnectorException catch (e, st) {
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
    final context = {
      'permission_type': permission.runtimeType.toString(),
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'getPermissionStatus',
      message: 'Getting permission status',
      context: context,
    );

    try {
      final status = await _client.getPermissionStatus(permission);

      HealthConnectorLogger.info(
        tag,
        operation: 'getPermissionStatus',
        message: 'Permission status retrieved',
        context: {
          ...context,
          'status': status.name,
        },
      );

      return status;
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'getPermissionStatus',
        message: 'Failed to get permission status',
        context: context,
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
        );

        throw const UnsupportedOperationException(
          'revokeAllPermissions is only available on Health Connect.',
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
        } on HealthConnectorException catch (e, st) {
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
    final context = {'feature': feature.toString()};
    HealthConnectorLogger.debug(
      tag,
      operation: 'getFeatureStatus',
      message: 'Checking feature status',
      context: context,
    );

    switch (_healthPlatform) {
      case HealthPlatform.appleHealth:
        HealthConnectorLogger.info(
          tag,
          operation: 'getFeatureStatus',
          message: 'Feature status retrieved',
          context: {...context, 'status': 'available'},
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
              ...context,
              'status': status.name,
            },
          );

          return status;
        } on HealthConnectorException catch (e, st) {
          HealthConnectorLogger.error(
            tag,
            operation: 'getFeatureStatus',
            message: 'Failed to get feature status',
            context: context,
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
    final context = {
      'data_type': request.dataType.runtimeType.toString(),
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecord',
      message: 'Reading health record',
      context: context,
    );

    try {
      final record = await _client.readRecord(request);

      if (record != null) {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'Health record read successfully',
          context: {
            ...context,
            'record_found': true,
            'record_type': record.runtimeType.toString(),
          },
        );
      } else {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'Health record not found',
          context: {
            ...context,
            'record_found': false,
          },
        );
      }

      return record;
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecord',
        message: 'Failed to read health record',
        context: context,
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
    final context = {
      'data_type': request.dataType.runtimeType.toString(),
      'query_span_days': request.startTime.difference(request.endTime).inDays,
      'page_size': request.pageSize,
      'has_page_token': request.pageToken != null,
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecords',
      message: 'Reading health records',
      context: context,
    );

    try {
      final response = await _client.readRecords(request);

      HealthConnectorLogger.info(
        tag,
        operation: 'readRecords',
        message: 'Health records read successfully',
        context: {
          ...context,
          'record_count': response.records.length,
          'has_next_page': response.hasMorePages,
        },
      );

      return response;
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecords',
        message: 'Failed to read health records',
        context: context,
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<HealthRecordId> writeRecord<R extends HealthRecord>(R record) async {
    final context = {
      'record_type': record.runtimeType.toString(),
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'writeRecord',
      message: 'Writing health record',
      context: context,
    );

    try {
      require(
        record.id == HealthRecordId.none,
        'Record ID must be HealthRecordId.none for new records. ',
      );
      _validateRecordSupport(record);

      final recordId = await _client.writeRecord(record);

      HealthConnectorLogger.info(
        tag,
        operation: 'writeRecord',
        message: 'Health record written successfully',
        context: {
          ...context,
          'record_written': true,
        },
      );

      return recordId;
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecord',
        message: 'Validation failed',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw InvalidArgumentException(
        (e.message as String?) ?? e.toString(),
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecord',
        message: 'Failed to write health record',
        context: context,
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
    final context = {
      'record_count': records.length,
      'record_types': records
          .map((r) => r.runtimeType.toString())
          .toSet()
          .toList(),
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'writeRecords',
      message: 'Writing health records',
      context: context,
    );

    if (records.isEmpty) {
      return [];
    }

    try {
      records.forEach(_validateRecordSupport);
      require(
        records.every((record) => record.id == HealthRecordId.none),
        'All records must have `HealthRecordId.none` for new records.',
      );

      final recordIds = await _client.writeRecords(records);

      HealthConnectorLogger.info(
        tag,
        operation: 'writeRecords',
        message: 'Health records written successfully',
        context: {
          ...context,
          'records_written': recordIds.length,
        },
      );

      return recordIds;
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecords',
        message: 'Validation failed',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw InvalidArgumentException(
        (e.message as String?) ?? e.toString(),
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecords',
        message: 'Failed to write health records',
        context: context,
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<U> aggregate<R extends HealthRecord, U extends MeasurementUnit>(
    AggregateRequest<R, U> request,
  ) async {
    final context = {
      'data_type': request.dataType.runtimeType.toString(),
      'metric_type': request.aggregationMetric.runtimeType.toString(),
      'query_span_days': request.startTime.difference(request.endTime).inDays,
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'aggregate',
      message: 'Aggregating health data',
      context: context,
    );

    try {
      final aggregatedValue = await _client.aggregate(request);

      HealthConnectorLogger.info(
        tag,
        operation: 'aggregate',
        message: 'Health data aggregated successfully',
        context: {
          ...context,
          'result_type': aggregatedValue.runtimeType.toString(),
        },
      );

      return aggregatedValue;
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'aggregate',
        message: 'Failed to aggregate health data',
        context: context,
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
    final context = {
      'data_type': request.dataType.runtimeType.toString(),
      if (request is DeleteRecordsInTimeRangeRequest)
        'query_span_days': (request as DeleteRecordsInTimeRangeRequest)
            .startTime
            .difference((request as DeleteRecordsInTimeRangeRequest).endTime)
      else
        'id_to_delete_count':
            (request as DeleteRecordsByIdsRequest).recordIds.length,
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'deleteRecords',
      message: 'Deleting health records',
      context: context,
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
        context: context,
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'deleteRecords',
        message: 'Failed to delete health records',
        context: context,
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<void> updateRecord<R extends HealthRecord>(R record) async {
    final context = {
      'record_type': record.runtimeType.toString(),
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'update_record',
      message: 'Updating health record',
      context: context,
    );

    try {
      if (healthPlatform == HealthPlatform.appleHealth) {
        throw const UnsupportedOperationException(
          'updateRecord API is not supported on iOS HealthKit SDK',
        );
      }
      _validateRecordSupport(record);
      require(
        record.id != HealthRecordId.none,
        'Record ID must not be HealthRecordId.none for updates. ',
      );

      await _client.updateRecord(record);

      HealthConnectorLogger.info(
        tag,
        operation: 'update_record',
        message: 'Health record updated successfully',
        context: context,
      );
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.warning(
        tag,
        operation: 'update_record',
        message: 'Validation failed',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw InvalidArgumentException(
        (e.message as String?) ?? e.toString(),
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'update_record',
        message: 'Failed to update health record',
        context: context,
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  @override
  Future<void> updateRecords<R extends HealthRecord>(List<R> records) async {
    final context = {
      'record_count': records.length,
      'record_types': records
          .map((r) => r.runtimeType.toString())
          .toSet()
          .toList(),
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'update_records',
      message: 'Updating health records',
      context: context,
    );

    try {
      if (healthPlatform == HealthPlatform.appleHealth) {
        throw const UnsupportedOperationException(
          'updateRecord API is not supported on iOS HealthKit SDK',
        );
      }
      records.forEach(_validateRecordSupport);
      require(
        records.every((record) => record.id != HealthRecordId.none),
        'Record IDs must not be HealthRecordId.none for updates. ',
      );

      await _client.updateRecords(records);

      HealthConnectorLogger.info(
        tag,
        operation: 'update_records',
        message: 'Health records updated successfully',
        context: context,
      );
    } on ArgumentError catch (e, st) {
      HealthConnectorLogger.warning(
        tag,
        operation: 'update_records',
        message: 'Validation failed',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw InvalidArgumentException(
        (e.message as String?) ?? e.toString(),
      );
    } on HealthConnectorException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'update_records',
        message: 'Failed to update health records',
        context: context,
        exception: e,
        stackTrace: st,
      );

      rethrow;
    }
  }

  void _validateRecordSupport(HealthRecord record) {
    require(
      record.supportedHealthPlatforms.contains(healthPlatform),
      '${record.runtimeType} is not supported on $healthPlatform.',
    );

    if (record is ExerciseSessionRecord) {
      if (!record.exerciseType.isSupportedOnPlatform(healthPlatform)) {
        throw UnsupportedError(
          '${record.exerciseType} is not supported on $healthPlatform.',
        );
      }
    }
  }
}
