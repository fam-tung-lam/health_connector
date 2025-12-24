part of 'health_data_type.dart';

/// Active calories burned data type.
///
/// Tracks calories burned through physical activity and exercise,
/// excluding basal metabolic rate (BMR). Active calories represent energy
/// expended beyond resting metabolism.
///
/// ## Measurement Unit
///
/// Values are measured in [Energy] units (kilocalories, kilojoules, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `ActiveCaloriesBurnedRecord`
/// - **iOS HealthKit**: `HKQuantityType(.activeEnergyBurned)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query active calorie records
/// - ✅ Writeable: Write active calorie records
/// - ✅ Aggregatable: Sum total active calories
/// - ✅ Deletable: Delete records by IDs or time range
///
/// {@category Health Data Types}
@sinceV1_0_0
@immutable
final class ActiveCaloriesBurnedHealthDataType
    extends HealthDataType<ActiveCaloriesBurnedRecord, Energy>
    implements
        ReadableHealthDataType<ActiveCaloriesBurnedRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ActiveCaloriesBurnedRecord, Energy>,
        DeletableHealthDataType<ActiveCaloriesBurnedRecord> {
  /// Creates an active calories burned data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const ActiveCaloriesBurnedHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveCaloriesBurnedHealthDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ActiveCaloriesBurnedRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ActiveCaloriesBurnedRecord> readInTimeRange({
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
  AggregateRequest<ActiveCaloriesBurnedRecord, Energy> aggregateSum({
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
  DeleteRecordsByIdsRequest<ActiveCaloriesBurnedRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<ActiveCaloriesBurnedRecord>
  deleteInTimeRange({
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
