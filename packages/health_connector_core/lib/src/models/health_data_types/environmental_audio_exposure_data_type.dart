part of 'health_data_type.dart';

/// Represents the environmental audio exposure health data type.
///
/// A quantity sample type that measures audio exposure to sounds in the
/// environment.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**:
///   [`HKQuantityTypeIdentifier.environmentalAudioExposure`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/environmentalaudioexposure)
/// - **Android Health Connect**: Not supported
///
/// ## See also
///
/// - [EnvironmentalAudioExposureRecord]
/// - [EnvironmentalAudioExposureEventDataType]
/// - [EnvironmentalAudioExposureEventRecord]
/// - [HeadphoneAudioExposureDataType]
/// - [HeadphoneAudioExposureRecord]
/// - [HeadphoneAudioExposureEventDataType]
/// - [HeadphoneAudioExposureEventRecord]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnAppleHealth
@immutable
final class EnvironmentalAudioExposureDataType
    extends HealthDataType<EnvironmentalAudioExposureRecord, Number>
    implements
        ReadableByIdHealthDataType<EnvironmentalAudioExposureRecord>,
        ReadableInTimeRangeHealthDataType<EnvironmentalAudioExposureRecord>,
        WriteableHealthDataType<EnvironmentalAudioExposureRecord>,
        AvgAggregatableHealthDataType<Number>,
        MinAggregatableHealthDataType<Number>,
        MaxAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<EnvironmentalAudioExposureRecord>,
        DeletableInTimeRangeHealthDataType<EnvironmentalAudioExposureRecord> {
  /// Creates an environmental audio exposure data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.environmentalAudioExposure].
  @internal
  const EnvironmentalAudioExposureDataType();

  @override
  String get id => 'environmental_audio_exposure';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentalAudioExposureDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.min,
    AggregationMetric.max,
    AggregationMetric.avg,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  ReadRecordsInTimeRangeRequest<EnvironmentalAudioExposureRecord>
  readInTimeRange({
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
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  AggregateRequest<Number> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Number> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Number> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }

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

  @override
  ReadRecordByIdRequest<EnvironmentalAudioExposureRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
