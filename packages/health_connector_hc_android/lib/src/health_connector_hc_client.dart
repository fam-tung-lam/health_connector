import 'package:flutter/services.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/health_connector_hc_native_log_api.dart';
import 'package:health_connector_hc_android/src/mappers/exception_mappers/health_connector_error_code_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_connector_config_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_data_sync/health_data_sync_result_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_data_sync/health_data_sync_token_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_platform_feature_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers/permission_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers/permission_status_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/permission_mappers/permissions_list_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/permission_request_result_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/request_and_response_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart';

/// Platform client that communicates with native Android Health Connect code.
///
/// This class acts as a bridge between Dart and platform-specific native code,
/// using generated Pigeon code for type-safe method channel communication.
@sinceV1_0_0
@internalUse
@immutable
class HealthConnectorHCClient implements HealthConnectorPlatformClient {
  static const _tag = 'HealthConnectorHKClient';

  /// The Pigeon-generated platform API client for native communication.
  static HealthConnectorHCAndroidApi _platformClient =
      HealthConnectorHCAndroidApi();

  /// Sets the platform client for testing purposes.
  ///
  /// This allows injecting a mock [HealthConnectorHCAndroidApi] in unit tests.
  @visibleForTesting
  @internal
  static set platformClient(HealthConnectorHCAndroidApi client) {
    _platformClient = client;
  }

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
    if (config.loggerConfig.enableNativeLogging) {
      HealthConnectorHCNativeLogApi.init();
    }

    await _platformClient.initialize(config.toDto());

    return HealthConnectorHCClient._(config);
  }

  /// All nutrient health data types that share the same permission as
  /// [HealthDataType.nutrition] in Health Connect.
  ///
  /// Health Connect uses a single permission for nutrition and all nutrient
  /// health data types. This list excludes nutrition itself.
  static const List<HealthDataType<HealthRecord, MeasurementUnit>>
  _nutrientDataTypes = [
    HealthDataType.dietaryEnergyConsumed,
    HealthDataType.dietaryCaffeine,
    HealthDataType.dietaryProtein,
    HealthDataType.dietaryTotalCarbohydrate,
    HealthDataType.dietaryTotalFat,
    HealthDataType.dietarySaturatedFat,
    HealthDataType.dietaryMonounsaturatedFat,
    HealthDataType.dietaryPolyunsaturatedFat,
    HealthDataType.dietaryCholesterol,
    HealthDataType.dietaryFiber,
    HealthDataType.dietarySugar,
    HealthDataType.dietaryCalcium,
    HealthDataType.dietaryIron,
    HealthDataType.dietaryMagnesium,
    HealthDataType.dietaryManganese,
    HealthDataType.dietaryPhosphorus,
    HealthDataType.dietaryPotassium,
    HealthDataType.dietarySelenium,
    HealthDataType.dietarySodium,
    HealthDataType.dietaryZinc,
    HealthDataType.dietaryVitaminA,
    HealthDataType.dietaryVitaminB6,
    HealthDataType.dietaryVitaminB12,
    HealthDataType.dietaryVitaminC,
    HealthDataType.dietaryVitaminD,
    HealthDataType.dietaryVitaminE,
    HealthDataType.dietaryVitaminK,
    HealthDataType.dietaryThiamin,
    HealthDataType.dietaryRiboflavin,
    HealthDataType.dietaryNiacin,
    HealthDataType.dietaryFolate,
    HealthDataType.dietaryBiotin,
    HealthDataType.dietaryPantothenicAcid,
  ];

  /// Gets the current status of the Health Connect platform.
  ///
  /// ## Returns
  ///
  /// - The current [HealthPlatformStatus] indicating whether Health Connect is
  ///   available, unavailable, or requires installation/update.
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the platform request fails.
  static Future<HealthPlatformStatus> getHealthPlatformStatus() async {
    HealthConnectorLogger.debug(
      _tag,
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
        _tag,
        operation: 'getHealthPlatformStatus',
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
        message: 'Failed to get Health Connect platform status',
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to get health platform status: '
        '${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  /// Launches the Health Connect app page in Google Play Store.
  ///
  /// Opens the Google Play Store page for the Health Connect app, allowing
  /// users to install or update it. This method should be called when
  /// [getHealthPlatformStatus] returns
  /// [HealthPlatformStatus.installationOrUpdateRequired].
  ///
  /// ## Throws
  ///
  /// - [HealthConnectorException] if the Google Play Store cannot be launched
  ///   or is not available on the device.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final status = await HealthConnectorHCClient.getHealthPlatformStatus();
  /// if (status == HealthPlatformStatus.installationOrUpdateRequired) {
  ///   try {
  ///     await HealthConnectorHCClient.launchHealthConnectPageInGooglePlay();
  ///   } on HealthConnectorException catch (e) {
  ///     print('Failed to launch Google Play: ${e.message}');
  ///   }
  /// }
  /// ```
  @sinceV2_3_0
  static Future<void> launchHealthConnectPageInGooglePlay() async {
    HealthConnectorLogger.debug(
      _tag,
      operation: 'launch_health_connect_app_page_in_google_play',
      message: 'Launching Health Connect app page in Google Play',
    );

    try {
      await _platformClient.launchHealthConnectPageInGooglePlay();

      HealthConnectorLogger.info(
        _tag,
        operation: 'launch_health_connect_app_page_in_google_play',
        message: 'Launched Health Connect app page in Google Play',
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        _tag,
        operation: 'launch_health_connect_app_page_in_google_play',
        message: 'Failed to launch Health Connect app page in Google Play',
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to launch Health Connect app page in Google Play: '
        '${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  const HealthConnectorHCClient._(this._config);

  final HealthConnectorConfig _config;

  @override
  HealthConnectorConfig get config => _config;

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
      message: 'Requesting Health Connect permissions',
      context: context,
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
      final permissionRequestDtos = permissions.toDto();

      final resultDtos = await _platformClient.requestPermissions(
        permissionRequestDtos,
      );

      final results = resultDtos.toDomain();

      // Add all nutrient health data type permissions if there is proper
      // read or write permission of `HealthDataType.nutrition`.
      final finalResults = _handleNutritionNutrientPermissions(
        requestedPermissions: permissions,
        results: results,
      );

      HealthConnectorLogger.info(
        tag,
        operation: 'requestPermissions',
        message: 'Health Connect permissions requested successfully',
        context: {
          ...context,
          'result_count': finalResults.length,
          'granted_count': finalResults
              .where((r) => r.status == PermissionStatus.granted)
              .length,
          'denied_count': finalResults
              .where((r) => r.status == PermissionStatus.denied)
              .length,
          'unknown_count': finalResults
              .where((r) => r.status == PermissionStatus.unknown)
              .length,
        },
      );

      return finalResults;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'requestPermissions',
        message: 'Failed to request Health Connect permissions',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
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
      final resultDtos = await _platformClient.getGrantedPermissions();

      final results = resultDtos.toDomain();

      // Just in case, filter only granted permissions.
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
          'permission_count': grantedPermissions.length,
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

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to get granted permissions from platform: '
        '${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
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
      final permissionDto = permission.toDto();

      final statusDto = await _platformClient.getPermissionStatus(
        permissionDto,
      );

      final status = statusDto.toDomain();

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
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'getPermissionStatus',
        message: 'Failed to get permission status',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to get permission status: ${e.message ?? 'Unknown error'}',
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

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to revoke all permissions from platform: '
        '${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  /// Queries the native platform to determine feature availability.
  ///
  /// Checks whether a platform feature is available and enabled on the device.
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
    final context = {'feature': feature.toString()};
    HealthConnectorLogger.debug(
      tag,
      operation: 'getFeatureStatus',

      message: 'Checking Health Connect feature status',
      context: context,
    );

    try {
      final featureDto = feature.toDto();

      final statusDto = await _platformClient.getFeatureStatus(featureDto);

      final status = statusDto.toDomain();

      HealthConnectorLogger.info(
        tag,
        operation: 'getFeatureStatus',
        message: 'Health Connect feature status retrieved',
        context: {...context, 'status': status.name},
      );

      return status;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'getFeatureStatus',
        message: 'Failed to get Health Connect feature status',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
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
    final context = {
      'data_type': request.dataType.runtimeType.toString(),
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecord',
      message: 'Reading Health Connect record',
      context: context,
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.readRecord(requestDto);
      final record = responseDto?.toDomain() as R?;

      if (record == null) {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'Health Connect record not found',
          context: {
            ...context,
            'record_found': false,
          },
        );
      } else {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'Health Connect record read successfully',
          context: {
            ...context,
            'record_found': true,
            'record_type': record.runtimeType.toString(),
          },
        );
      }

      return record;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecord',
        message: 'Failed to read Health Connect record',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
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
    final context = {
      'data_type': request.dataType.runtimeType.toString(),
      'query_span_days': request.endTime.difference(request.startTime).inDays,
      'page_size': request.pageSize,
      'has_page_token': request.pageToken != null,
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecords',
      message: 'Reading Health Connect records',
      context: context,
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.readRecords(requestDto);

      final response = responseDto.toDomain<R>(request);

      HealthConnectorLogger.info(
        tag,
        operation: 'readRecords',
        message: 'Health Connect records read successfully',
        context: {
          ...context,
          'record_count': response.records.length,
          'has_next_page': response.hasMorePages,
        },
      );

      return response;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'readRecords',
        message: 'Failed to read Health Connect records',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to process $request: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<HealthRecordId> writeRecord<R extends HealthRecord>(R record) async {
    final context = {
      'record_type': record.runtimeType.toString(),
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'write_record',
      message: 'Writing Health Connect record',
      context: context,
    );

    try {
      final idString = await _platformClient.writeRecord(record.toDto());

      final recordId = idString.toDomain();

      HealthConnectorLogger.info(
        tag,
        operation: 'write_record',
        message: 'Health Connect record written successfully',
        context: {
          ...context,
          'record_written': true,
        },
      );

      return recordId;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'write_record',
        message: 'Failed to write Health Connect record',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
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
    final context = {
      'record_count': records.length,
      'record_types': records
          .map((r) => r.runtimeType.toString())
          .toSet()
          .toList(),
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'write_records',
      message: 'Writing Health Connect records',
      context: context,
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
        message: 'Health Connect records written successfully',
        context: {
          ...context,
          'records_written': recordIds.length,
        },
      );

      return recordIds;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'write_records',
        message: 'Failed to write Health Connect records',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to write $records: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
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
      message: 'Updating Health Connect record',
      context: context,
    );

    try {
      await _platformClient.updateRecord(record.toDto());

      HealthConnectorLogger.info(
        tag,
        operation: 'update_record',
        message: 'Health Connect record updated successfully',
        context: context,
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'update_record',
        message: 'Failed to update Health Connect record',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to update $record: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
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
      HealthConnectorLogger.info(
        tag,
        operation: 'update_records',
        message: 'Health records updated successfully',
        context: context,
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'update_records',
        message: 'Failed to update health records',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to update $records: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<U> aggregate<U extends MeasurementUnit>(
    AggregateRequest<U> request,
  ) async {
    final context = {
      'data_type': request.dataType.runtimeType.toString(),
      'metric_type': request.aggregationMetric.runtimeType.toString(),
      'query_span_days': request.endTime.difference(request.startTime).inDays,
    };
    HealthConnectorLogger.debug(
      tag,
      operation: 'aggregate',
      message: 'Aggregating Health Connect data',
      context: context,
    );

    try {
      final requestDto = request.toDto();

      final aggregatedResultDouble = await _platformClient.aggregate(
        requestDto,
      );

      final aggregatedResult =
          aggregatedResultDouble.toMeasurementUnit(
                request.dataType,
              )
              as U;

      HealthConnectorLogger.info(
        tag,
        operation: 'aggregate',
        message: 'Health Connect data aggregated successfully',
        context: {
          ...context,
          'result_type': aggregatedResult.runtimeType.toString(),
        },
      );

      return aggregatedResult;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'aggregate',
        message: 'Failed to aggregate Health Connect data',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to process $request: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> deleteRecords(DeleteRecordsRequest request) async {
    final context = {
      'data_type': request.dataType.runtimeType.toString(),
      if (request is DeleteRecordsInTimeRangeRequest)
        'query_span_days': request.endTime.difference(request.startTime)
      else
        'id_to_delete_count':
            (request as DeleteRecordsByIdsRequest).recordIds.length,
    };

    HealthConnectorLogger.debug(
      tag,
      operation: 'deleteRecords',
      message: 'Deleting Health Connect records',
      context: context,
    );

    try {
      await _platformClient.deleteRecords(request.toDto());

      HealthConnectorLogger.info(
        tag,
        operation: 'deleteRecords',
        message: 'Health Connect records deleted successfully',
        context: context,
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'deleteRecords',
        message: 'Failed to delete Health Connect records',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to delete records by $request: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<HealthDataSyncResult> synchronize({
    required List<HealthDataType> dataTypes,
    required HealthDataSyncToken? syncToken,
  }) async {
    final context = {
      'data_types': dataTypes.map((dt) => dt.tag).toList(),
      'has_sync_token': syncToken != null,
    };

    HealthConnectorLogger.debug(
      tag,
      operation: 'synchronize',
      message: 'Synchronizing Health Connect data',
      context: context,
    );

    try {
      final dataTypeDtos = dataTypes.map((dt) => dt.toDto()).toList();
      final syncTokenDto = syncToken?.toDto();

      final resultDto = await _platformClient.synchronize(
        dataTypeDtos,
        syncTokenDto,
      );

      final result = resultDto.toDomain();

      HealthConnectorLogger.info(
        tag,
        operation: 'synchronize',
        message: 'Health Connect data synchronized successfully',
        context: {
          ...context,
          'upserted_count': result.upsertedRecords.length,
          'deleted_count': result.deletedRecordIds.length,
          'has_more': result.hasMore,
        },
      );

      return result;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'synchronize',
        message: 'Failed to synchronize Health Connect data',
        context: context,
        exception: e,
        stackTrace: st,
      );

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
        'Failed to synchronize: ${e.message ?? 'Unknown error'}',
        cause: e,
        stackTrace: st,
      );
    }
  }

  /// Handles the special case where Health Connect uses a single permission
  /// for nutrition and all data types.
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
