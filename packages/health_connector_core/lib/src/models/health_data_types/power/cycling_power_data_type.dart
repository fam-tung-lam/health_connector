part of '../health_data_type.dart';

/// Cycling power data type.
///
/// Tracks the power output during cycling activity, useful for monitoring
/// cycling performance and training intensity.
///
/// ## Measurement Unit
///
/// Values are measured in [Power] units (watts, kilowatts).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only** (iOS 16.0+): [`HKQuantityTypeIdentifier.cyclingPower`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingpower)
/// - **Android Health Connect**: Not directly supported (use
/// [PowerSeriesDataType])
///
/// ## Capabilities
///
/// - Readable: Query cycling power records
/// - Writeable: Write cycling power records
/// - Aggregatable: Calculate average, minimum, and maximum cycling power
/// - Deletable: Delete records by IDs or time range
///
/// {@category Health Data Types}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class CyclingPowerDataType
    extends HealthDataType<CyclingPowerRecord, Power>
    implements
        ReadableHealthDataType<CyclingPowerRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType,
        AvgAggregatableHealthDataType<CyclingPowerRecord, Power>,
        MinAggregatableHealthDataType<CyclingPowerRecord, Power>,
        MaxAggregatableHealthDataType<CyclingPowerRecord, Power> {
  /// Creates a cycling power data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CyclingPowerDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPowerDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  ReadRecordByIdRequest<CyclingPowerRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CyclingPowerRecord> readInTimeRange({
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
  AggregateRequest<CyclingPowerRecord, Power> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<CyclingPowerRecord, Power> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<CyclingPowerRecord, Power> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  DeleteRecordsByIdsRequest<CyclingPowerRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<CyclingPowerRecord> deleteInTimeRange({
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
