import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        AggregateResponse,
        HealthConnectorConfig,
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
        ReadRecordByIdRequest,
        ReadRecordsInTimeRangeRequest,
        ReadRecordsInTimeRangeResponse,
        PermissionListExtension,
        sinceV1_0_0,
        internalUse,
        DeleteRecordsRequest;
import 'package:health_connector_hc_android/src/mappers/config_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_connector_error_code_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_platform_feature_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/request_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/response_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HealthConnectorHCAndroidApi, HealthPlatformStatusDto;
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart' show immutable;

/// Platform client that communicates with native Android Health Connect code.
///
/// This class acts as a bridge between Dart and platform-specific native code,
/// using generated Pigeon code for type-safe method channel communication.
@sinceV1_0_0
@internalUse
@immutable
final class HealthConnectorHCClient implements HealthConnectorPlatformClient {
  const HealthConnectorHCClient._();

  /// The Pigeon-generated platform API client for native communication.
  static final HealthConnectorHCAndroidApi _platformClient =
      HealthConnectorHCAndroidApi();

  /// Creates a new [HealthConnectorHCClient] instance with the given config.
  ///
  /// This factory method initializes the native Android Health Connect
  /// platform code with the provided configuration before returning the
  /// client instance.
  ///
  /// ## Parameters
  ///
  /// - [config]: The configuration to use for initializing the client.
  ///
  /// ## Returns
  ///
  /// A configured [HealthConnectorHCClient] instance ready for use.
  static Future<HealthConnectorHCClient> create([
    HealthConnectorConfig config = const HealthConnectorConfig(),
  ]) async {
    await _platformClient.initialize(config.toDto());
    return const HealthConnectorHCClient._();
  }

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
      tag,
      operation: 'getHealthPlatformStatus',
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
        tag,
        operation: 'getHealthPlatformStatus',
        message: 'Health Connect platform status retrieved',
        context: {
          'health_platform_status': status.name,
        },
      );

      return status;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'getHealthPlatformStatus',
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
      tag,
      operation: 'requestPermissions',
      message: 'Requesting Health Connect permissions',
      context: {
        'requested_health_data_permissions': permissions.healthDataPermissions,
        'requested_feature_permissions': permissions.featurePermissions,
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
        tag,
        operation: 'requestPermissions',
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
        tag,
        operation: 'requestPermissions',
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
      tag,
      operation: 'getGrantedPermissions',
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
        tag,
        operation: 'getGrantedPermissions',
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
        tag,
        operation: 'getGrantedPermissions',
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
      tag,
      operation: 'revokeAllPermissions',

      message: 'Revoking all Health Connect permissions',
    );

    try {
      await _platformClient.revokeAllPermissions();

      HealthConnectorLogger.info(
        tag,
        operation: 'revokeAllPermissions',
        message: 'All Health Connect permissions revoked successfully',
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'revokeAllPermissions',
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
      tag,
      operation: 'getFeatureStatus',

      message: 'Checking Health Connect feature status',
      context: {'feature': feature},
    );

    try {
      final featureDto = feature.toDto();

      final statusDto = await _platformClient.getFeatureStatus(featureDto);

      final status = statusDto.toDomain();

      HealthConnectorLogger.info(
        tag,
        operation: 'getFeatureStatus',
        message: 'Health Connect feature status retrieved',
        context: {'feature': feature, 'status': status.name},
      );

      return status;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'getFeatureStatus',
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
    ReadRecordByIdRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecord',

      message: 'Reading Health Connect record',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.readRecord(requestDto);

      if (responseDto == null) {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',

          message: 'Health Connect record not found',
          context: {'request': request, 'response': null},
        );

        return null; // Record not found
      }

      final record = responseDto.record?.toDomain() as R?;

      HealthConnectorLogger.info(
        tag,
        operation: 'readRecord',
        message: 'Health Connect record read successfully',
        context: {'request': request, 'response': record},
      );

      return record;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecord',
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
  Future<ReadRecordsInTimeRangeResponse<R>> readRecords<R extends HealthRecord>(
    ReadRecordsInTimeRangeRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecords',

      message: 'Reading Health Connect records',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.readRecords(requestDto);

      final response = responseDto.toDomain<R>(request);

      HealthConnectorLogger.info(
        tag,
        operation: 'readRecords',
        message: 'Health Connect records read successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecords',
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
      tag,
      operation: 'writeRecord',

      message: 'Writing Health Connect record',
      context: {'record': record},
    );

    try {
      final requestDto = record.toWriteRecordRequestDto();

      final responseDto = await _platformClient.writeRecord(requestDto);

      final assignedRecordId = responseDto.recordId.toHealthRecordId();

      HealthConnectorLogger.info(
        tag,
        operation: 'writeRecord',
        message: 'Health Connect record written successfully',
        context: {'record': record, 'assignedRecordId': assignedRecordId},
      );

      return assignedRecordId;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecord',
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
      tag,
      operation: 'writeRecords',

      message: 'Writing Health Connect records',
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
          .map((id) => id.toHealthRecordId())
          .toList();

      HealthConnectorLogger.info(
        tag,
        operation: 'writeRecords',
        message: 'Health Connect records written successfully',
        context: {'records': records, 'assignedRecordIds': recordIds},
      );

      return recordIds;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'writeRecords',
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
  Future<void> updateRecord<R extends HealthRecord>(R record) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'update_record',

      message: 'Updating Health Connect record',
      context: {'record': record},
    );

    try {
      final requestDto = record.toUpdateRecordRequestDto();

      await _platformClient.updateRecord(requestDto);

      HealthConnectorLogger.info(
        tag,
        operation: 'update_record',
        message: 'Health Connect record updated successfully',
        context: {'record': record},
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'update_record',
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
  Future<void> updateRecords<R extends HealthRecord>(List<R> records) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'update_records',

      message: 'Updating health records',
      context: {'records': records},
    );

    try {
      HealthConnectorLogger.info(
        tag,
        operation: 'update_records',
        message: 'Health records updated successfully',
        context: {'records': records},
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'update_records',
        message: 'Failed to update health records',
        context: {'records': records},
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException(
        e.code.toHealthConnectorErrorCode(),
        'Failed to update $records: ${e.message ?? 'Unknown error'}',
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

      message: 'Aggregating Health Connect data',
      context: {'request': request},
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.aggregate(requestDto);

      final response = responseDto.toDomain<R, U>(request.dataType);

      HealthConnectorLogger.info(
        tag,
        operation: 'aggregate',
        message: 'Health Connect data aggregated successfully',
        context: {'request': request, 'response': response},
      );

      return response;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'aggregate',
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
  Future<void> deleteRecords<R extends HealthRecord>(
    DeleteRecordsRequest<R> request,
  ) async {
    HealthConnectorLogger.debug(
      tag,
      operation: 'deleteRecords',
      message: 'Deleting Health Connect records by time range',
      context: {'request': request},
    );

    try {
      await _platformClient.deleteRecords(request.toDto());

      HealthConnectorLogger.info(
        tag,
        operation: 'deleteRecords',
        message: 'Health Connect records deleted successfully',
        context: {'request': request},
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'deleteRecords',
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
