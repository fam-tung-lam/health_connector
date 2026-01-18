part of 'health_data_type.dart';

/// Body mass index (BMI) data type.
///
/// Tracks body mass index, a measure of body fat based on height and weight.
/// BMI is calculated as weight in kilograms divided by height in meters squared
/// (kg/m²). It is commonly used to screen for weight categories that may lead
/// to health problems.
///
/// ## Measurement Unit
///
/// Values are measured as dimensionless [Number] (kg/m²).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bodyMassIndex`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymassindex)
///
/// ## Capabilities
///
/// - Readable: Query BMI records
/// - Writeable: Write BMI records
/// - Aggregatable: Calculate min, max, avg, and sum of BMI
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [BodyMassIndexRecord]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class BodyMassIndexDataType
    extends HealthDataType<BodyMassIndexRecord, Number>
    implements
        MinAggregatableHealthDataType<Number>,
        MaxAggregatableHealthDataType<Number>,
        AvgAggregatableHealthDataType<Number>,
        SumAggregatableHealthDataType<Number>,
        ReadableByIdHealthDataType<BodyMassIndexRecord>,
        ReadableInTimeRangeHealthDataType<BodyMassIndexRecord>,
        WriteableHealthDataType<BodyMassIndexRecord>,
        DeletableByIdsHealthDataType<BodyMassIndexRecord>,
        DeletableInTimeRangeHealthDataType<BodyMassIndexRecord> {
  /// Creates a body mass index data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BodyMassIndexDataType();

  @override
  String get id => 'body_mass_index';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.min,
    AggregationMetric.max,
    AggregationMetric.avg,
    AggregationMetric.sum,
  ];

  @override
  AggregateRequest<Number> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.min,
    );
  }

  @override
  AggregateRequest<Number> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.max,
    );
  }

  @override
  AggregateRequest<Number> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.avg,
    );
  }

  @override
  AggregateRequest<Number> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.sum,
    );
  }

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.bodyMeasurement;

  @override
  ReadRecordByIdRequest<BodyMassIndexRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BodyMassIndexRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
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
