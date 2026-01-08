part of '../health_data_type.dart';

/// Represents the Total Calories Burned health data type.
///
/// This data type captures the total energy burned by the user, including both
/// active energy and basal metabolic rate.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`TotalCaloriesBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/TotalCaloriesBurnedRecord)
/// - **iOS HealthKit**: Not supported. iOS separates Active and Basal energy.
///
/// ## Capabilities
///
/// - Readable: Query active calorie records
/// - Writeable: Write active calorie records
/// - Aggregatable: Sum total active calories
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [TotalCaloriesBurnedRecord]
/// - [ActiveCaloriesBurnedRecord]
/// - [ActiveCaloriesBurnedHealthDataType]
/// - [BasalEnergyBurnedRecord]
/// - [BasalEnergyBurnedHealthDataType]
///
/// {@category Health Data Types}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class TotalCaloriesBurnedHealthDataType
    extends HealthDataType<TotalCaloriesBurnedRecord, Energy>
    implements
        ReadableHealthDataType<TotalCaloriesBurnedRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<TotalCaloriesBurnedRecord>,
        SumAggregatableHealthDataType<TotalCaloriesBurnedRecord, Energy> {
  /// Creates a total calories burned data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const TotalCaloriesBurnedHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalCaloriesBurnedHealthDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<TotalCaloriesBurnedRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<TotalCaloriesBurnedRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    List<DataOrigin> dataOrigins = const [],
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
    String? pageToken,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      dataOrigins: dataOrigins,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
      pageToken: pageToken,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<TotalCaloriesBurnedRecord, Energy> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  DeleteRecordsByIdsRequest<TotalCaloriesBurnedRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<TotalCaloriesBurnedRecord> deleteInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return DeleteRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
