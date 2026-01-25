part of '../health_data_type.dart';

/// Represents the Basal Metabolic Rate health data type.
///
/// This data type captures the BMR of a user. Each record represents the
/// energy a user would burn if at rest all day, based on their height and
/// weight.
///
/// ## Measurement Unit Note
///
/// This data type is parameterized with [Energy] for aggregation purposes.
/// However, the actual [BasalMetabolicRateRecord] uses [Power] as its
/// measurement unit (specifically `Power.kilocaloriesPerDay`), representing
/// the rate at which energy would be burned.
///
/// This design reflects the Android Health Connect API, where aggregation uses
/// an [Energy] metric while individual records store the metabolic rate as a
/// [Power] value.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BasalMetabolicRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalMetabolicRateRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Capabilities
///
/// - Readable: Query basal metabolic rate records
/// - Writeable: Write basal metabolic rate records
/// - Aggregatable: Sum total basal calories (via Energy unit)
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [BasalMetabolicRateRecord]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnHealthConnect
@immutable
final class BasalMetabolicRateDataType
    extends HealthDataType<BasalMetabolicRateRecord, Energy>
    implements
        ReadableByIdHealthDataType<BasalMetabolicRateRecord>,
        ReadableInTimeRangeHealthDataType<BasalMetabolicRateRecord>,
        WriteableHealthDataType<BasalMetabolicRateRecord>,
        DeletableByIdsHealthDataType<BasalMetabolicRateRecord>,
        DeletableInTimeRangeHealthDataType<BasalMetabolicRateRecord>,
        SumAggregatableHealthDataType<Energy> {
  /// Creates a basal metabolic rate data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BasalMetabolicRateDataType();

  @override
  String get id => 'basal_metabolic_rate';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasalMetabolicRateDataType && runtimeType == other.runtimeType;

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
  ReadRecordByIdRequest<BasalMetabolicRateRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BasalMetabolicRateRecord> readInTimeRange({
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
  AggregateRequest<Energy> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
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
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest deleteInTimeRange({
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
