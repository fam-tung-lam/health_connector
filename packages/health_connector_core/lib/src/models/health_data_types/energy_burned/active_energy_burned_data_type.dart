part of '../health_data_type.dart';

/// Active energy burned data type.
///
/// Tracks energy burned through physical activity and exercise,
/// excluding basal metabolic rate (BMR). Active calories represent energy
/// expended beyond resting metabolism.
///
/// ## Measurement Unit
///
/// Values are measured in [Energy] units (kilocalories, kilojoules, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`ActiveEnergyBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ActiveEnergyBurnedRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.activeEnergyBurned`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/activeenergyburned)
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
/// - [ActiveEnergyBurnedRecord]
///
/// {@category Health Data Types}
@sinceV1_0_0
@immutable
final class ActiveEnergyBurnedDataType
    extends HealthDataType<ActiveEnergyBurnedRecord, Energy>
    implements
        ReadableHealthDataType<ActiveEnergyBurnedRecord>,
        WriteableHealthDataType<ActiveEnergyBurnedRecord>,
        SumAggregatableHealthDataType<ActiveEnergyBurnedRecord, Energy>,
        DeletableHealthDataType<ActiveEnergyBurnedRecord> {
  /// Creates an active energy burned data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const ActiveEnergyBurnedDataType();

  @override
  String get id => 'active_calories_burned';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveEnergyBurnedDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ActiveEnergyBurnedRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ActiveEnergyBurnedRecord> readInTimeRange({
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
  AggregateRequest<ActiveEnergyBurnedRecord, Energy> aggregateSum({
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
  DeleteRecordsByIdsRequest<ActiveEnergyBurnedRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<ActiveEnergyBurnedRecord> deleteInTimeRange({
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
