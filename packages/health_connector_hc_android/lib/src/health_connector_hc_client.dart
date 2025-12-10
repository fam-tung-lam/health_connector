import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        AggregateResponse,
        HealthConnectorException,
        HealthConnectorPlatformClient,
        HealthDataPermission,
        HealthDataPermissionAccessType,
        HealthDataType,
        HealthPlatformFeature,
        HealthPlatformFeatureStatus,
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
import 'package:health_connector_hc_android/src/mappers/error_code_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_platform_feature_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/request_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/response_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show
        DeleteRecordsByIdsRequestDto,
        DeleteRecordsByTimeRangeRequestDto,
        HealthConnectorPlatformApi,
        HealthPlatformStatusDto;
import 'package:health_connector_logger/health_connector_logger.dart'
    show HealthConnectorLogger;
import 'package:meta/meta.dart' show immutable;

/// Platform client that communicates with native Android Health Connect code.
///
/// This class acts as a bridge between Dart and platform-specific native code,
/// using generated Pigeon code for type-safe method channel communication.
@sinceV1_0_0
@internalUse
@immutable
final class HealthConnectorHCClient implements HealthConnectorPlatformClient {
  const HealthConnectorHCClient();

  static final String _tag = (HealthConnectorHCClient).toString();

  /// The Pigeon-generated platform API client for native communication.
  static final HealthConnectorPlatformApi _platformClient =
      HealthConnectorPlatformApi();

  /// All nutrient health data types that share the same permission as
  /// [HealthDataType.nutrition] in Health Connect.
  ///
  /// Health Connect uses a single permission for nutrition and all nutrient
  /// health data types. This list excludes nutrition itself.
  static const List<HealthDataType<HealthRecord, MeasurementUnit>>
  _nutrientDataTypes = [
    HealthDataType.energyNutrient,
    HealthDataType.caffeine,
    HealthDataType.protein,
    HealthDataType.totalCarbohydrate,
    HealthDataType.totalFat,
    HealthDataType.saturatedFat,
    HealthDataType.monounsaturatedFat,
    HealthDataType.polyunsaturatedFat,
    HealthDataType.cholesterol,
    HealthDataType.dietaryFiber,
    HealthDataType.sugar,
    HealthDataType.calcium,
    HealthDataType.iron,
    HealthDataType.magnesium,
    HealthDataType.manganese,
    HealthDataType.phosphorus,
    HealthDataType.potassium,
    HealthDataType.selenium,
    HealthDataType.sodium,
    HealthDataType.zinc,
    HealthDataType.vitaminA,
    HealthDataType.vitaminB6,
    HealthDataType.vitaminB12,
    HealthDataType.vitaminC,
    HealthDataType.vitaminD,
    HealthDataType.vitaminE,
    HealthDataType.vitaminK,
    HealthDataType.thiamin,
    HealthDataType.riboflavin,
    HealthDataType.niacin,
    HealthDataType.folate,
    HealthDataType.biotin,
    HealthDataType.pantothenicAcid,
  ];

  @override
  Future<HealthPlatformStatus> getHealthPlatformStatus() async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'getHealthPlatformStatus',
      phase: 'entry',
      message: 'Checking Health Connect platform status',
    );

    try {
      final statusDto = await _platformClient.getHealthPlatformStatus();

      final status = switch (statusDto) {
        HealthPlatformStatusDto.available => HealthPlatformStatus.available,
        HealthPlatformStatusDto.notAvailable =>
          HealthPlatformStatus.unavailable,
        HealthPlatformStatusDto.installationOrUpdateRequired =>
          HealthPlatformStatus.installationOrUpdateRequired,
      };

      HealthConnectorLogger.info(
        _tag,
        operation: 'getHealthPlatformStatus',
        phase: 'succeeded',
        message: 'Health Connect platform status retrieved',
        context: {
          'health_platform_status': status.name,
        },
      );

      return status;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'getHealthPlatformStatus',
        phase: 'failed',
        message: 'Failed to get Health Connect platform status',
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

  @override
  Future<List<PermissionRequestResult>> requestPermissions(
    List<Permission> permissions,
  ) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'requestPermissions',
      phase: 'entry',
      message: 'Requesting Health Connect permissions',
      context: {
        'requested_health_data_permissions': permissions.healthDataPermissions,
        'requested_feature_permissions': permissions.featurePermissions,
      },
    );

    if (permissions.isEmpty) {
      HealthConnectorLogger.warning(
        _tag,
        operation: 'requestPermissions',
        phase: 'succeeded',
        message: 'No permissions to request (empty list)',
      );

      return [];
    }

    try {
      final requestDto = permissions.toDto();
      final responseDto = await _platformClient.requestPermissions(requestDto);
      final results = responseDto.toDomain();

      final finalResults = _handleNutritionNutrientPermissions(
        requestedPermissions: permissions,
        results: results,
      );
      final grantedPermissions = finalResults
          .where((result) => result.status == PermissionStatus.granted)
          .map((result) => result.permission)
          .toList();

      HealthConnectorLogger.info(
        _tag,
        operation: 'requestPermissions',
        phase: 'succeeded',
        message: 'Health Connect permissions requested successfully',
        context: {
          'granted_health_data_permissions':
              grantedPermissions.healthDataPermissions,
          'granted_feature_permissions': grantedPermissions.featurePermissions,
        },
      );

      return finalResults;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'requestPermissions',
        phase: 'failed',
        message: 'Failed to request Health Connect permissions',
        context: {
          'requested_permissions': {
            'health_data_permissions': permissions.healthDataPermissions,
            'feature_permissions': permissions.featurePermissions,
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

  /// Gets all permissions that have been granted to the app.
  ///
  /// Returns a list of all permissions that are currently granted.
  /// This can be used to check which data types the app has access to without
  /// prompting the user.
  ///
  /// ## Returns
  ///
  /// - A list of [Permission] objects representing all currently
  /// granted permissions.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the platform request fails or
  ///   returns invalid data.
  Future<List<Permission>> getGrantedPermissions() async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'getGrantedPermissions',
      phase: 'entry',
      message: 'Getting granted Health Connect permissions',
    );

    try {
      final responseDto = await _platformClient.getGrantedPermissions();

      final results = responseDto.toDomain();

      // Filter only granted permissions
      final grantedPermissions = results
          .where((result) => result.status == PermissionStatus.granted)
          .map((result) => result.permission)
          .toList();

      // Add all nutrient health data type permissions if there is proper
      // read or write permission of `HealthDataType.nutrition`.
      _addNutrientPermissionsIfNutritionGranted(grantedPermissions);

      HealthConnectorLogger.info(
        _tag,
        operation: 'getGrantedPermissions',
        phase: 'succeeded',
        message: 'Granted Health Connect permissions retrieved',
        context: {
          'granted_health_data_permissions':
              grantedPermissions.healthDataPermissions,
          'granted_feature_permissions': grantedPermissions.featurePermissions,
        },
      );

      return grantedPermissions;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'getGrantedPermissions',
        phase: 'failed',
        message: 'Failed to get granted Health Connect permissions',
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to get granted permissions from platform: '
        '${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  /// Revokes all permissions that have been granted to the app.
  ///
  /// Removes all health data permissions that were previously granted.
  /// After calling this method, the app will need to request permissions
  /// again before accessing health data.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the platform request fails
  Future<void> revokeAllPermissions() async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'revokeAllPermissions',
      phase: 'entry',
      message: 'Revoking all Health Connect permissions',
    );

    try {
      await _platformClient.revokeAllPermissions();

      HealthConnectorLogger.info(
        _tag,
        operation: 'revokeAllPermissions',
        phase: 'succeeded',
        message: 'All Health Connect permissions revoked successfully',
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'revokeAllPermissions',
        phase: 'failed',
        message: 'Failed to revoke all Health Connect permissions',
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to revoke all permissions from platform: '
        '${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  /// Queries the native platform to determine feature availability.
  ///
  /// Checks whether a specific platform feature (e.g., exercise routes,
  /// workout goals) is available and enabled on the device.
  ///
  /// ## Parameters
  ///
  /// - [feature]: The platform feature to check
  ///
  /// ## Returns
  ///
  /// A [HealthPlatformFeatureStatus] indicating whether the feature is
  /// available, unavailable, or requires an update.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the platform request fails
  Future<HealthPlatformFeatureStatus> getFeatureStatus(
    HealthPlatformFeature feature,
  ) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'getFeatureStatus',
      phase: 'entry',
      message: 'Checking Health Connect feature status',
      context: {'feature': feature},
    );

    try {
      final featureDto = feature.toDto();

      final statusDto = await _platformClient.getFeatureStatus(featureDto);

      final status = statusDto.toDomain();

      HealthConnectorLogger.info(
        _tag,
        operation: 'getFeatureStatus',
        phase: 'succeeded',
        message: 'Health Connect feature status retrieved',
        context: {'feature': feature, 'status': status.name},
      );

      return status;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'getFeatureStatus',
        phase: 'failed',
        message: 'Failed to get Health Connect feature status',
        context: {'feature': feature},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to get feature status for $feature: '
        '${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<R?> readRecord<R extends HealthRecord>(
    ReadRecordRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'readRecord',
      phase: 'entry',
      message: 'Reading Health Connect record',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.readRecord(requestDto);

      if (responseDto == null) {
        HealthConnectorLogger.info(
          _tag,
          operation: 'readRecord',
          phase: 'succeeded',
          message: 'Health Connect record not found',
          context: {'request': request, 'response': null},
        );

        return null; // Record not found
      }

      final record = responseDto.record?.toDomain() as R?;

      HealthConnectorLogger.info(
        _tag,
        operation: 'readRecord',
        phase: 'succeeded',
        message: 'Health Connect record read successfully',
        context: {'request': request, 'response': record},
      );

      return record;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'readRecord',
        phase: 'failed',
        message: 'Failed to read Health Connect record',
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
      _tag,
      operation: 'readRecords',
      phase: 'entry',
      message: 'Reading Health Connect records',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.readRecords(requestDto);

      final response = responseDto.toDomain<R>(request);

      HealthConnectorLogger.info(
        _tag,
        operation: 'readRecords',
        phase: 'succeeded',
        message: 'Health Connect records read successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'readRecords',
        phase: 'failed',
        message: 'Failed to read Health Connect records',
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
      _tag,
      operation: 'writeRecord',
      phase: 'entry',
      message: 'Writing Health Connect record',
      context: {'record': record},
    );

    try {
      final requestDto = record.toWriteRecordRequestDto();

      final responseDto = await _platformClient.writeRecord(requestDto);

      final assignedRecordId = responseDto.recordId.toHealthRecordId();

      HealthConnectorLogger.info(
        _tag,
        operation: 'writeRecord',
        phase: 'succeeded',
        message: 'Health Connect record written successfully',
        context: {'record': record, 'assignedRecordId': assignedRecordId},
      );

      return assignedRecordId;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'writeRecord',
        phase: 'failed',
        message: 'Failed to write Health Connect record',
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
      _tag,
      operation: 'writeRecords',
      phase: 'entry',
      message: 'Writing Health Connect records',
      context: {'records': records},
    );

    if (records.isEmpty) {
      HealthConnectorLogger.warning(
        _tag,
        operation: 'writeRecords',
        phase: 'succeeded',
        message: 'No records to write (empty list)',
      );

      return [];
    }

    try {
      final requestDto = records.toWriteRecordsRequestDto();

      final responseDto = await _platformClient.writeRecords(requestDto);

      final recordIds = responseDto.recordIds
          .map((id) => id.toHealthRecordId())
          .toList();

      HealthConnectorLogger.info(
        _tag,
        operation: 'writeRecords',
        phase: 'succeeded',
        message: 'Health Connect records written successfully',
        context: {'records': records, 'assignedRecordIds': recordIds},
      );

      return recordIds;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'writeRecords',
        phase: 'failed',
        message: 'Failed to write Health Connect records',
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
      _tag,
      operation: 'updateRecord',
      phase: 'entry',
      message: 'Updating Health Connect record',
      context: {'record': record},
    );

    try {
      final requestDto = record.toUpdateRecordRequestDto();

      final responseDto = await _platformClient.updateRecord(requestDto);

      final updatedRecordId = responseDto.recordId.toHealthRecordId();

      HealthConnectorLogger.info(
        _tag,
        operation: 'updateRecord',
        phase: 'succeeded',
        message: 'Health Connect record updated successfully',
        context: {'record': record},
      );

      return updatedRecordId;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'updateRecord',
        phase: 'failed',
        message: 'Failed to update Health Connect record',
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
      _tag,
      operation: 'aggregate',
      phase: 'entry',
      message: 'Aggregating Health Connect data',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.aggregate(requestDto);

      final response = responseDto.toDomain<R, U>(request.dataType);

      HealthConnectorLogger.info(
        _tag,
        operation: 'aggregate',
        phase: 'succeeded',
        message: 'Health Connect data aggregated successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'aggregate',
        phase: 'failed',
        message: 'Failed to aggregate Health Connect data',
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
      _tag,
      operation: 'deleteRecords',
      phase: 'entry',
      message: 'Deleting Health Connect records by time range',
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
        _tag,
        operation: 'deleteRecords',
        phase: 'succeeded',
        message: 'Health Connect records deleted successfully',
        context: {'request': request},
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'deleteRecords',
        phase: 'failed',
        message: 'Failed to delete Health Connect records',
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
      _tag,
      operation: 'deleteRecordsByIds',
      phase: 'entry',
      message: 'Deleting Health Connect records by IDs',
      context: {'request': request},
    );

    if (recordIds.isEmpty) {
      HealthConnectorLogger.warning(
        _tag,
        operation: 'deleteRecordsByIds',
        phase: 'succeeded',
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
        _tag,
        operation: 'deleteRecordsByIds',
        phase: 'succeeded',
        message: 'Health Connect records deleted successfully',
        context: {'request': request},
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'deleteRecordsByIds',
        phase: 'failed',
        message: 'Failed to delete Health Connect records by IDs',
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

  /// Handles the special case where Health Connect uses a single permission
  /// for nutrition and all nutrient data types.
  List<PermissionRequestResult> _handleNutritionNutrientPermissions({
    required List<Permission> requestedPermissions,
    required List<PermissionRequestResult> results,
  }) {
    final requestedNutritionNutrientPermissions = requestedPermissions
        .whereType<HealthDataPermission>()
        .where(
          (permission) =>
              permission.dataType == HealthDataType.nutrition ||
              _nutrientDataTypes.contains(permission.dataType),
        )
        .toList();

    if (requestedNutritionNutrientPermissions.isEmpty) {
      return results;
    }

    final nutritionResultsByAccessType = Map.fromEntries(
      results
          .where(
            (result) =>
                result.permission is HealthDataPermission &&
                (result.permission as HealthDataPermission).dataType ==
                    HealthDataType.nutrition,
          )
          .map((result) {
            final permission = result.permission as HealthDataPermission;
            return MapEntry(permission.accessType, result);
          }),
    );

    return results.map((result) {
      return _mapPermissionResult(
        result: result,
        requestedNutritionNutrientPermissions:
            requestedNutritionNutrientPermissions,
        nutritionResultsByAccessType: nutritionResultsByAccessType,
      );
    }).toList();
  }

  PermissionRequestResult _mapPermissionResult({
    required PermissionRequestResult result,
    required List<HealthDataPermission> requestedNutritionNutrientPermissions,
    required Map<HealthDataPermissionAccessType, PermissionRequestResult>
    nutritionResultsByAccessType,
  }) {
    final permission = result.permission;

    if (permission is! HealthDataPermission ||
        !requestedNutritionNutrientPermissions.contains(permission)) {
      return result;
    }

    if (permission.dataType == HealthDataType.nutrition) {
      return result;
    }

    if (!_nutrientDataTypes.contains(permission.dataType)) {
      return result;
    }

    // Map nutrient permission to nutrition permission result
    return _createNutrientPermissionResult(
      permission: permission,
      nutritionResultsByAccessType: nutritionResultsByAccessType,
    );
  }

  PermissionRequestResult _createNutrientPermissionResult({
    required HealthDataPermission permission,
    required Map<HealthDataPermissionAccessType, PermissionRequestResult>
    nutritionResultsByAccessType,
  }) {
    // Only map to nutrition's result if SAME access type exists
    final nutritionResult = nutritionResultsByAccessType[permission.accessType];

    return PermissionRequestResult(
      permission: permission,
      status: nutritionResult?.status ?? PermissionStatus.denied,
    );
  }

  /// Adds all nutrient health data type permissions to [grantedPermissions]
  /// if there is a read/write permission for [HealthDataType.nutrition].
  ///
  /// Health Connect uses a single permission for nutrition and all nutrient
  /// health data types. This method ensures that when nutrition permission is
  void _addNutrientPermissionsIfNutritionGranted(
    List<Permission> grantedPermissions,
  ) {
    // Find all nutrition permissions
    final nutritionPermissions = grantedPermissions
        .whereType<HealthDataPermission>()
        .where(
          (permission) => permission.dataType == HealthDataType.nutrition,
        );

    if (nutritionPermissions.isEmpty) {
      return;
    }

    // Determine which access types to add
    final hasReadPermission = nutritionPermissions.any(
      (permission) =>
          permission.accessType == HealthDataPermissionAccessType.read,
    );
    final hasWritePermission = nutritionPermissions.any(
      (permission) =>
          permission.accessType == HealthDataPermissionAccessType.write,
    );

    // Add nutrient permissions for the same access types as nutrition
    final nutrientPermissionsToAdd = _nutrientDataTypes.expand(
      (dataType) => [
        if (hasReadPermission)
          HealthDataPermission(
            dataType: dataType,
            accessType: HealthDataPermissionAccessType.read,
          ),
        if (hasWritePermission)
          HealthDataPermission(
            dataType: dataType,
            accessType: HealthDataPermissionAccessType.write,
          ),
      ],
    );

    grantedPermissions.addAll(nutrientPermissionsToAdd);
  }
}
