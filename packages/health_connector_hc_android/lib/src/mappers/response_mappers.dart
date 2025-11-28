import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        HealthConnectorErrorCode,
        HealthConnectorException,
        HealthDataType,
        DistanceHealthDataType,
        FloorsClimbedHealthDataType,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        LeanBodyMassHealthDataType,
        StepsHealthDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        HealthRecord,
        ReadRecordsRequest,
        AggregateResponse,
        ReadRecordsResponse,
        MeasurementUnit,
        Numeric;
import 'package:health_connector_hc_android/src/mappers/'
    'health_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/'
    'measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show AggregateResponseDto, ReadRecordResponseDto, ReadRecordsResponseDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ReadRecordsResponseDto] to [ReadRecordsResponse].
@internal
extension ReadRecordsResponseDtoToDomain on ReadRecordsResponseDto {
  ReadRecordsResponse<R> toDomain<R extends HealthRecord>(
    ReadRecordsRequest<R> originalRequest,
  ) {
    // Extract records from typed fields based on the request's data type
    // This ensures type safety: all records in the returned list are of type R
    final records = _extractRecordsFromResponse<R>(
      this,
      originalRequest.dataType,
    );

    // Create next page request if token is present and not empty
    final nextPageRequest = nextPageToken?.isNotEmpty ?? false
        ? originalRequest.copyWith(pageToken: nextPageToken)
        : null;

    return ReadRecordsResponse(
      records: records,
      nextPageRequest: nextPageRequest,
    );
  }

  /// Extracts multiple records from typed response DTO.
  List<R> _extractRecordsFromResponse<R extends HealthRecord>(
    ReadRecordsResponseDto responseDto,
    HealthDataType<R, MeasurementUnit> dataType,
  ) {
    switch (dataType) {
      case ActiveCaloriesBurnedHealthDataType _:
        final activeCaloriesBurnedRecords =
            responseDto.activeCaloriesBurnedRecords;
        if (activeCaloriesBurnedRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected activeCaloriesBurnedRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return activeCaloriesBurnedRecords
            .map((dto) => dto.toDomain())
            .cast<R>()
            .toList();

      case DistanceHealthDataType _:
        final distanceRecords = responseDto.distanceRecords;
        if (distanceRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected distanceRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return distanceRecords.map((dto) => dto.toDomain()).cast<R>().toList();

      case FloorsClimbedHealthDataType _:
        final floorsClimbedRecords = responseDto.floorsClimbedRecords;
        if (floorsClimbedRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected floorsClimbedRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return floorsClimbedRecords
            .map((dto) => dto.toDomain())
            .cast<R>()
            .toList();

      case HeightHealthDataType _:
        final heightRecords = responseDto.heightRecords;
        if (heightRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected heightRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return heightRecords.map((dto) => dto.toDomain()).cast<R>().toList();

      case HydrationHealthDataType _:
        final hydrationRecords = responseDto.hydrationRecords;
        if (hydrationRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected hydrationRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return hydrationRecords.map((dto) => dto.toDomain()).cast<R>().toList();

      case LeanBodyMassHealthDataType _:
        final leanBodyMassRecords = responseDto.leanBodyMassRecords;
        if (leanBodyMassRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected leanBodyMassRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return leanBodyMassRecords
            .map((dto) => dto.toDomain())
            .cast<R>()
            .toList();

      case BodyFatPercentageHealthDataType _:
        final bodyFatPercentageRecords = responseDto.bodyFatPercentageRecords;
        if (bodyFatPercentageRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected bodyFatPercentageRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return bodyFatPercentageRecords
            .map((dto) => dto.toDomain())
            .cast<R>()
            .toList();

      case BodyTemperatureHealthDataType _:
        final bodyTemperatureRecords = responseDto.bodyTemperatureRecords;
        if (bodyTemperatureRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected bodyTemperatureRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return bodyTemperatureRecords
            .map((dto) => dto.toDomain())
            .cast<R>()
            .toList();

      case StepsHealthDataType _:
        final stepsRecords = responseDto.stepsRecords;
        if (stepsRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected stepsRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return stepsRecords.map((dto) => dto.toDomain()).cast<R>().toList();

      case WeightHealthDataType _:
        final weightRecords = responseDto.weightRecords;
        if (weightRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected weightRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return weightRecords.map((dto) => dto.toDomain()).cast<R>().toList();

      case WheelchairPushesHealthDataType _:
        final wheelchairPushesRecords = responseDto.wheelchairPushesRecords;
        if (wheelchairPushesRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected wheelchairPushesRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return wheelchairPushesRecords
            .map((dto) => dto.toDomain())
            .cast<R>()
            .toList();

      case HeartRateSeriesRecordHealthDataType _:
        final heartRateSeriesRecords = responseDto.heartRateSeriesRecords;
        if (heartRateSeriesRecords == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected heartRateSeriesRecords but got null in '
            'ReadRecordsResponseDto for dataType: $dataType',
          );
        }
        return heartRateSeriesRecords
            .map((dto) => dto.toDomain())
            .cast<R>()
            .toList();

      case HeartRateMeasurementRecordHealthDataType _:
        throw UnsupportedError(
          'HeartRateMeasurementRecordHealthDataType is not supported on Android. '
          'Use HeartRateSeriesRecordHealthDataType instead.',
        );
    }
  }
}

/// Converts [AggregateResponseDto] to [AggregateResponse].
@internal
extension AggregateResponseDtoToDomain on AggregateResponseDto {
  AggregateResponse<R, U> toDomain<
    R extends HealthRecord,
    U extends MeasurementUnit
  >(HealthDataType<R, U> dataType) {
    // Extract value from typed fields based on the data type
    final extractedValue = _extractValueFromResponse<R, U>(dataType);

    if (extractedValue == null) {
      throw HealthConnectorException(
        HealthConnectorErrorCode.parsingError,
        'Cannot create AggregateResponse with null value for '
        'dataType: $dataType',
      );
    }

    return AggregateResponse(extractedValue);
  }

  /// Extracts aggregate value from typed response DTO.
  U? _extractValueFromResponse<
    R extends HealthRecord,
    U extends MeasurementUnit
  >(HealthDataType<R, U> dataType) {
    switch (dataType) {
      case ActiveCaloriesBurnedHealthDataType _:
        final value = activeCaloriesBurnedValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected activeCaloriesBurnedValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return value.toDomain() as U;

      case DistanceHealthDataType _:
        final value = lengthValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected lengthValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return value.toDomain() as U;

      case HeightHealthDataType _:
        final value = lengthValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected lengthValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return value.toDomain() as U;

      case HydrationHealthDataType _:
        final value = hydrationValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected hydrationValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return value.toDomain() as U;

      case BodyFatPercentageHealthDataType _:
        throw const HealthConnectorException(
          HealthConnectorErrorCode.parsingError,
          'Body fat percentage does not support aggregation',
        );

      case BodyTemperatureHealthDataType _:
        final value = bodyTemperatureValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected bodyTemperatureValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return value.toDomain() as U;

      case FloorsClimbedHealthDataType _:
        final value = doubleValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected doubleValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return Numeric(value) as U;

      case StepsHealthDataType _:
        final value = doubleValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected doubleValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return Numeric(value) as U;

      case WeightHealthDataType _:
        final value = massValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected massValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return value.toDomain() as U;

      case LeanBodyMassHealthDataType _:
        final value = leanBodyMassValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected leanBodyMassValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return value.toDomain() as U;

      case WheelchairPushesHealthDataType _:
        final value = wheelchairPushesValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected wheelchairPushesValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return value.toDomain() as U;

      case HeartRateSeriesRecordHealthDataType _:
        final value = heartRateBeatsPerMinuteValue;
        if (value == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected heartRateBeatsPerMinuteValue but got null in '
            'AggregateResponseDto for dataType: $dataType',
          );
        }
        return value.toDomain() as U;

      case HeartRateMeasurementRecordHealthDataType _:
        throw UnsupportedError(
          'HeartRateMeasurementRecordHealthDataType is not supported on Android. '
          'Use HeartRateSeriesRecordHealthDataType instead.',
        );
    }
  }
}

/// Converts [ReadRecordResponseDto] to [HealthRecord].
@internal
extension ReadRecordResponseDtoToDomain on ReadRecordResponseDto {
  R toDomain<R extends HealthRecord>(
    HealthDataType<R, MeasurementUnit> dataType,
  ) {
    switch (dataType) {
      case ActiveCaloriesBurnedHealthDataType _:
        final record = activeCaloriesBurnedRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected activeCaloriesBurnedRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case DistanceHealthDataType _:
        final record = distanceRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected distanceRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case FloorsClimbedHealthDataType _:
        final record = floorsClimbedRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected floorsClimbedRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case HeightHealthDataType _:
        final record = heightRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected heightRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case HydrationHealthDataType _:
        final record = hydrationRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected hydrationRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case LeanBodyMassHealthDataType _:
        final record = leanBodyMassRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected leanBodyMassRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case BodyFatPercentageHealthDataType _:
        final record = bodyFatPercentageRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected bodyFatPercentageRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case BodyTemperatureHealthDataType _:
        final record = bodyTemperatureRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected bodyTemperatureRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case StepsHealthDataType _:
        final record = stepsRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected stepsRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case WeightHealthDataType _:
        final record = weightRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected weightRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case WheelchairPushesHealthDataType _:
        final record = wheelchairPushesRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected wheelchairPushesRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case HeartRateSeriesRecordHealthDataType _:
        final record = heartRateSeriesRecord;
        if (record == null) {
          throw HealthConnectorException(
            HealthConnectorErrorCode.parsingError,
            'Expected heartRateSeriesRecord but got null in '
            'ReadRecordResponseDto for dataType: $dataType',
          );
        }
        return record.toDomain() as R;

      case HeartRateMeasurementRecordHealthDataType _:
        throw UnsupportedError(
          'HeartRateMeasurementRecordHealthDataType is not supported on Android. '
          'Use HeartRateSeriesRecordHealthDataType instead.',
        );
    }
  }
}
