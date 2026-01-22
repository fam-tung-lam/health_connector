import 'package:flutter/services.dart' show PlatformException;
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        AggregateRequest,
        HealthConnectorConfig,
        HealthConnectorException,
        HealthConnectorPlatformClient,
        HealthDataPermission,
        HealthDataSyncResult,
        HealthDataSyncToken,
        HealthDataType,
        HealthPlatformFeaturePermission,
        HealthPlatformStatus,
        HealthRecord,
        HealthRecordId,
        MeasurementUnit,
        Energy,
        Frequency,
        Length,
        Mass,
        Number,
        Percentage,
        Pressure,
        Temperature,
        TimeDuration,
        Volume,
        Permission,
        PermissionRequestResult,
        PermissionStatus,
        ReadRecordByIdRequest,
        ReadRecordsInTimeRangeRequest,
        ReadRecordsInTimeRangeResponse,
        PermissionListExtension,
        sinceV1_0_0,
        internalUse,
        DeleteRecordsRequest,
        UnsupportedOperationException,
        DeleteRecordsInTimeRangeRequest,
        DeleteRecordsByIdsRequest;
import 'package:health_connector_hk_ios/src/health_connector_hk_native_log_api.dart';
import 'package:health_connector_hk_ios/src/mappers/health_connector_config_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_connector_error_code_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_sync/health_data_sync_result_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_sync/health_data_sync_token_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/permission_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/request_and_response_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthConnectorHKIOSApi, HealthDataTypeDto, HealthPlatformStatusDto;
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart' show immutable, visibleForTesting, internal;

/// Platform client that communicates with native iOS HealthKit code.
///
/// This class acts as a bridge between Dart and platform-specific native code,
/// using generated Pigeon code for type-safe method channel communication.
@sinceV1_0_0
@internalUse
@immutable
class HealthConnectorHKClient implements HealthConnectorPlatformClient {
  static const _tag = 'HealthConnectorHKClient';

  /// The Pigeon-generated platform API client for native communication.
  static HealthConnectorHKIOSApi _platformClient = HealthConnectorHKIOSApi();

  /// Test-only setter for injecting a mock platform client.
  @visibleForTesting
  @internal
  static set platformClient(HealthConnectorHKIOSApi client) {
    _platformClient = client;
  }

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
    if (config.loggerConfig.enableNativeLogging) {
      HealthConnectorHKNativeLogApi.init();
    }

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

      throw HealthConnectorException.fromCode(
        e.code.toErrorCode(),
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
    final featureCount = featurePermissions.length;
    final context = {
      'health_data_count': healthDataPermissions.length,
      'feature_count': featureCount,
      'total_permissions': permissions.length,
    };

    HealthConnectorLogger.debug(
      tag,
      operation: 'requestPermissions',
      message: 'Requesting HealthKit permissions',
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
    final grantedDataPermissions = grantedPermissions.healthDataPermissions;

    HealthConnectorLogger.info(
      tag,
      operation: 'requestPermissions',
      message: 'HealthKit permissions requested successfully',
      context: {
        ...context,
        'granted_health_data_count': grantedDataPermissions.length,
        'denied_health_data_count': results
            .where(
              (r) =>
                  r.status == PermissionStatus.denied &&
                  r.permission is HealthDataPermission,
            )
            .length,
        'auto_granted_feature_count': featureCount,
        'total_results': results.length,
      },
    );

    return results;
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

    // Handle feature permissions - automatically granted on iOS
    if (permission is HealthPlatformFeaturePermission) {
      HealthConnectorLogger.info(
        tag,
        operation: 'getPermissionStatus',
        message: 'Feature permission status - automatically granted on iOS',
        context: {
          ...context,
          'status': 'granted',
        },
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

  @override
  Future<R?> readRecord<R extends HealthRecord>(
    ReadRecordByIdRequest<R> request,
  ) async {
    final context = {
      'data_type': request.dataType.runtimeType.toString(),
      'has_record_id': request.id != HealthRecordId.none,
    };

    HealthConnectorLogger.debug(
      tag,
      operation: 'readRecord',
      message: 'Reading HealthKit record',
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
          message: 'HealthKit record not found',
          context: {
            ...context,
            'record_found': false,
          },
        );
      } else {
        HealthConnectorLogger.info(
          tag,
          operation: 'readRecord',
          message: 'HealthKit record read successfully',
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
        message: 'Failed to read HealthKit record',
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
      message: 'Reading HealthKit records',
      context: context,
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.readRecords(requestDto);

      final response = responseDto.toDomain<R>(request);

      HealthConnectorLogger.info(
        tag,
        operation: 'readRecords',
        message: 'HealthKit records read successfully',
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
        message: 'Failed to read HealthKit records',
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
      message: 'Writing HealthKit record',
      context: context,
    );

    try {
      final idString = await _platformClient.writeRecord(record.toDto());

      final recordId = idString.toDomain();

      HealthConnectorLogger.info(
        tag,
        operation: 'write_record',
        message: 'HealthKit record written successfully',
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
        message: 'Failed to write HealthKit record',
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
      message: 'Writing HealthKit records',
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
        message: 'HealthKit records written successfully',
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
        message: 'Failed to write HealthKit records',
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
  Future<HealthRecordId> updateRecord<R extends HealthRecord>(R record) async {
    throw const UnsupportedOperationException(
      'updateRecord API is not supported on iOS HealthKit SDK',
    );
  }

  @override
  Future<void> updateRecords<R extends HealthRecord>(List<R> records) {
    throw const UnsupportedOperationException(
      'updateRecords API is not supported on iOS HealthKit SDK',
    );
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
      message: 'Aggregating HealthKit data',
      context: context,
    );

    try {
      final requestDto = request.toDto();

      final responseDto = await _platformClient.aggregate(requestDto);

      final response =
          responseDto.toMeasurementUnit(request.dataType.toDto()) as U;

      HealthConnectorLogger.info(
        tag,
        operation: 'aggregate',
        message: 'HealthKit data aggregated successfully',
        context: {
          ...context,
          'result_type': response.runtimeType.toString(),
        },
      );

      return response;
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'aggregate',
        message: 'Failed to aggregate HealthKit data',
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
      message: 'Deleting HealthKit records',
      context: context,
    );

    try {
      await _platformClient.deleteRecords(request.toDto());

      HealthConnectorLogger.info(
        tag,
        operation: 'deleteRecords',
        message: 'HealthKit records deleted successfully',
        context: context,
      );
    } on PlatformException catch (e, st) {
      HealthConnectorLogger.error(
        tag,
        operation: 'deleteRecords',
        message: 'Failed to delete HealthKit records',
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
      message: 'Synchronizing HealthKit data',
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
        message: 'HealthKit data synchronized successfully',
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
        message: 'Failed to synchronize HealthKit data',
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
}

extension on double {
  MeasurementUnit toMeasurementUnit(HealthDataTypeDto dataType) {
    return switch (dataType) {
      HealthDataTypeDto.steps ||
      HealthDataTypeDto.floorsClimbed ||
      HealthDataTypeDto.swimmingStrokes ||
      HealthDataTypeDto.numberOfTimesFallen ||
      HealthDataTypeDto.wheelchairPushes ||
      HealthDataTypeDto.insulinDelivery ||
      HealthDataTypeDto.electrodermalActivity ||
      HealthDataTypeDto.inhalerUsage => Number(this),
      HealthDataTypeDto.exerciseTime ||
      HealthDataTypeDto.moveTime ||
      HealthDataTypeDto.standTime ||
      HealthDataTypeDto.runningGroundContactTime => TimeDuration.seconds(this),
      HealthDataTypeDto.activeCaloriesBurned ||
      HealthDataTypeDto.basalEnergyBurned ||
      HealthDataTypeDto.dietaryEnergyConsumed => Energy.kilocalories(this),
      HealthDataTypeDto.distance ||
      HealthDataTypeDto.walkingRunningDistance ||
      HealthDataTypeDto.cyclingDistance ||
      HealthDataTypeDto.wheelchairDistance ||
      HealthDataTypeDto.heartRateRecoveryOneMinute ||
      HealthDataTypeDto.heartRateVariabilitySDNN ||
      HealthDataTypeDto.height ||
      HealthDataTypeDto.waistCircumference ||
      HealthDataTypeDto.swimmingDistance ||
      HealthDataTypeDto.downhillSnowSportsDistance ||
      HealthDataTypeDto.rowingDistance ||
      HealthDataTypeDto.paddleSportsDistance ||
      HealthDataTypeDto.crossCountrySkiingDistance ||
      HealthDataTypeDto.skatingSportsDistance ||
      HealthDataTypeDto.sixMinuteWalkTestDistance ||
      HealthDataTypeDto.walkingStepLength ||
      HealthDataTypeDto.runningStrideLength => Length.meters(this),
      HealthDataTypeDto.weight ||
      HealthDataTypeDto.leanBodyMass ||
      HealthDataTypeDto.calcium ||
      HealthDataTypeDto.iron ||
      HealthDataTypeDto.zinc ||
      HealthDataTypeDto.potassium ||
      HealthDataTypeDto.sodium ||
      HealthDataTypeDto.magnesium ||
      HealthDataTypeDto.manganese ||
      HealthDataTypeDto.selenium ||
      HealthDataTypeDto.caffeine ||
      HealthDataTypeDto.vitaminA ||
      HealthDataTypeDto.thiamin ||
      HealthDataTypeDto.riboflavin ||
      HealthDataTypeDto.niacin ||
      HealthDataTypeDto.pantothenicAcid ||
      HealthDataTypeDto.vitaminB6 ||
      HealthDataTypeDto.biotin ||
      HealthDataTypeDto.vitaminB12 ||
      HealthDataTypeDto.folate ||
      HealthDataTypeDto.vitaminC ||
      HealthDataTypeDto.vitaminD ||
      HealthDataTypeDto.vitaminE ||
      HealthDataTypeDto.vitaminK ||
      HealthDataTypeDto.sugar ||
      HealthDataTypeDto.dietaryFiber ||
      HealthDataTypeDto.cholesterol ||
      HealthDataTypeDto.totalFat ||
      HealthDataTypeDto.saturatedFat ||
      HealthDataTypeDto.monounsaturatedFat ||
      HealthDataTypeDto.polyunsaturatedFat ||
      HealthDataTypeDto.protein ||
      HealthDataTypeDto.totalCarbohydrate => Mass.grams(this),
      HealthDataTypeDto.hydration ||
      HealthDataTypeDto.forcedExpiratoryVolume => Volume.liters(this),
      HealthDataTypeDto.bodyFatPercentage ||
      HealthDataTypeDto.bloodAlcoholContent ||
      HealthDataTypeDto.peripheralPerfusionIndex ||
      HealthDataTypeDto.walkingSteadiness ||
      HealthDataTypeDto.walkingAsymmetryPercentage ||
      HealthDataTypeDto.walkingDoubleSupportPercentage ||
      HealthDataTypeDto.oxygenSaturation ||
      HealthDataTypeDto.atrialFibrillationBurden => Percentage.fromDecimal(
        this,
      ),
      HealthDataTypeDto.heartRateMeasurementRecord ||
      HealthDataTypeDto.restingHeartRate ||
      HealthDataTypeDto.respiratoryRate ||
      HealthDataTypeDto.cyclingPedalingCadence ||
      HealthDataTypeDto.lowHeartRateEvent ||
      HealthDataTypeDto.irregularHeartRhythmEvent ||
      HealthDataTypeDto.highHeartRateEvent ||
      HealthDataTypeDto.walkingHeartRateAverage => Frequency.perMinute(this),
      HealthDataTypeDto.systolicBloodPressure ||
      HealthDataTypeDto.diastolicBloodPressure ||
      HealthDataTypeDto.bloodPressure => Pressure.millimetersOfMercury(this),
      HealthDataTypeDto.bodyTemperature ||
      HealthDataTypeDto.basalBodyTemperature ||
      HealthDataTypeDto.sleepingWristTemperature => Temperature.celsius(this),
      HealthDataTypeDto.alcoholicBeverages ||
      HealthDataTypeDto.bloodAlcoholContent ||
      HealthDataTypeDto.cyclingPower ||
      HealthDataTypeDto.runningPower ||
      HealthDataTypeDto.cervicalMucus ||
      HealthDataTypeDto.sleepStageRecord ||
      HealthDataTypeDto.sexualActivity ||
      HealthDataTypeDto.peripheralPerfusionIndex ||
      HealthDataTypeDto.walkingSpeed ||
      HealthDataTypeDto.runningSpeed ||
      HealthDataTypeDto.stairAscentSpeed ||
      HealthDataTypeDto.stairDescentSpeed ||
      HealthDataTypeDto.phosphorus ||
      HealthDataTypeDto.nutrition ||
      HealthDataTypeDto.ovulationTest ||
      HealthDataTypeDto.pregnancyTest ||
      HealthDataTypeDto.pregnancy ||
      HealthDataTypeDto.contraceptive ||
      HealthDataTypeDto.progesteroneTest ||
      HealthDataTypeDto.lactation ||
      HealthDataTypeDto.ovulationTestResult ||
      HealthDataTypeDto.progesteroneTestResult ||
      HealthDataTypeDto.sleepStage ||
      HealthDataTypeDto.intermenstrualBleeding ||
      HealthDataTypeDto.menstrualFlow ||
      HealthDataTypeDto.vo2Max ||
      HealthDataTypeDto.bloodGlucose ||
      HealthDataTypeDto.exerciseSession ||
      HealthDataTypeDto.mindfulnessSession ||
      HealthDataTypeDto.bodyMassIndex ||
      HealthDataTypeDto.forcedVitalCapacity ||
      HealthDataTypeDto.heartRateVariabilitySDNN => Number(this),
      HealthDataTypeDto.infrequentMenstrualCycleEvent => throw ArgumentError(
        '$InfrequentMenstrualCycleEventDataType is not aggregatable.',
      ),
      HealthDataTypeDto.walkingSteadinessEvent => throw ArgumentError(
        '$WalkingSteadinessEventDataType is not aggregatable.',
      ),
      HealthDataTypeDto.persistentIntermenstrualBleedingEvent =>
        throw ArgumentError(
          '$PersistentIntermenstrualBleedingEventDataType is not aggregatable.',
        ),
      HealthDataTypeDto.irregularMenstrualCycleEvent => throw ArgumentError(
        '$IrregularMenstrualCycleEventDataType is not aggregatable.',
      ),
      HealthDataTypeDto.prolongedMenstrualPeriodEvent => throw ArgumentError(
        '$ProlongedMenstrualPeriodEventDataType is not aggregatable.',
      ),
    };
  }
}
