part of '../health_data_type.dart';

/// Represents the Total Calories Burned health data type.
///
/// This data type captures the total energy burned by the user, including both
/// active energy and basal metabolic rate.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`TotalEnergyBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/TotalEnergyBurnedRecord)
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
/// - [TotalEnergyBurnedRecord]
/// - [ActiveEnergyBurnedRecord]
/// - [ActiveEnergyBurnedDataType]
/// - [BasalEnergyBurnedRecord]
/// - [BasalEnergyBurnedDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class TotalEnergyBurnedDataType
    extends HealthDataType<TotalEnergyBurnedRecord, Energy>
    implements
        ReadableByIdHealthDataType<TotalEnergyBurnedRecord>,
        ReadableInTimeRangeHealthDataType<TotalEnergyBurnedRecord>,
        WriteableHealthDataType<TotalEnergyBurnedRecord>,
        DeletableByIdsHealthDataType<TotalEnergyBurnedRecord>,
        DeletableInTimeRangeHealthDataType<TotalEnergyBurnedRecord>,
        SumAggregatableHealthDataType<TotalEnergyBurnedRecord, Energy> {
  /// Creates a total energy burned data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const TotalEnergyBurnedDataType();

  @override
  String get id => 'total_calories_burned';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalEnergyBurnedDataType && runtimeType == other.runtimeType;

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
  ReadRecordByIdRequest<TotalEnergyBurnedRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<TotalEnergyBurnedRecord> readInTimeRange({
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
  AggregateRequest<TotalEnergyBurnedRecord, Energy> aggregateSum({
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
  DeleteRecordsByIdsRequest<TotalEnergyBurnedRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<TotalEnergyBurnedRecord> deleteInTimeRange({
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
