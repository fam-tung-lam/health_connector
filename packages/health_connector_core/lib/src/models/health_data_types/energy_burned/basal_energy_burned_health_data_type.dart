part of '../health_data_type.dart';

/// Represents the Basal Energy Burned health data type.
///
/// This data type captures the energy burned by the body at rest (BMR).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.basalEnergyBurned`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalenergyburned)
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
/// - [ActiveCaloriesBurnedRecord]
///
/// {@category Health Data Types}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class BasalEnergyBurnedHealthDataType
    extends HealthDataType<BasalEnergyBurnedRecord, Energy>
    implements
        ReadableHealthDataType<BasalEnergyBurnedRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<BasalEnergyBurnedRecord>,
        SumAggregatableHealthDataType<BasalEnergyBurnedRecord, Energy> {
  /// Creates a basal energy burned data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BasalEnergyBurnedHealthDataType();

  @override
  String get id => 'basal_energy_burned';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasalEnergyBurnedHealthDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BasalEnergyBurnedRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BasalEnergyBurnedRecord> readInTimeRange({
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
  AggregateRequest<BasalEnergyBurnedRecord, Energy> aggregateSum({
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
  DeleteRecordsByIdsRequest<BasalEnergyBurnedRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<BasalEnergyBurnedRecord> deleteInTimeRange({
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
