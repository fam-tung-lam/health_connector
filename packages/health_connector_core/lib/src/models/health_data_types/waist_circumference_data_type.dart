part of 'health_data_type.dart';

/// Waist circumference data type.
///
/// Tracks waist circumference measurements, an important indicator of
/// abdominal obesity and associated health risks. Waist circumference is
/// measured at the narrowest point of the torso, typically at the level
/// of the navel.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters, centimeters, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not currently supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.waistCircumference`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/waistcircumference)
///
/// ## Capabilities
///
/// - Readable: Query waist circumference records
/// - Writeable: Write waist circumference records
/// - Aggregatable: Calculate min, max, avg, and sum of measurements
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [WaistCircumferenceRecord]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class WaistCircumferenceDataType
    extends HealthDataType<WaistCircumferenceRecord, Length>
    implements
        MinAggregatableHealthDataType<WaistCircumferenceRecord, Length>,
        MaxAggregatableHealthDataType<WaistCircumferenceRecord, Length>,
        AvgAggregatableHealthDataType<WaistCircumferenceRecord, Length>,
        SumAggregatableHealthDataType<WaistCircumferenceRecord, Length>,
        ReadableHealthDataType<WaistCircumferenceRecord>,
        WriteableHealthDataType<WaistCircumferenceRecord>,
        DeletableHealthDataType<WaistCircumferenceRecord> {
  /// Creates a waist circumference data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WaistCircumferenceDataType();

  @override
  String get id => 'waist_circumference';

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
  AggregateRequest<WaistCircumferenceRecord, Length> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.min,
    );
  }

  @override
  AggregateRequest<WaistCircumferenceRecord, Length> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.max,
    );
  }

  @override
  AggregateRequest<WaistCircumferenceRecord, Length> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      aggregationMetric: AggregationMetric.avg,
    );
  }

  @override
  AggregateRequest<WaistCircumferenceRecord, Length> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
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
  ReadRecordByIdRequest<WaistCircumferenceRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WaistCircumferenceRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<WaistCircumferenceRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(dataType: this, recordIds: recordIds);
  }

  @override
  DeleteRecordsInTimeRangeRequest<WaistCircumferenceRecord> deleteInTimeRange({
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
