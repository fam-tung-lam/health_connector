part of '../health_data_type.dart';

/// Sleeping wrist temperature data type.
///
/// Represents the temperature measured at the wrist during sleep.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by Apple Watch during sleep and cannot be written by
/// > third-party applications.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported.
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.appleSleepingWristTemperature`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/applesleepingwristtemperature)
///
/// ## Capabilities
///
/// - Readable: Query sleeping wrist temperature records
/// - Aggregatable: Min, Max, Avg
/// - Read-only: No write or delete support
///
/// ## See also
///
/// - [SleepingWristTemperatureRecord]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealthIOS16Plus
@readOnly
@immutable
final class SleepingWristTemperatureDataType
    extends HealthDataType<SleepingWristTemperatureRecord, Temperature>
    implements
        ReadableByIdHealthDataType<SleepingWristTemperatureRecord>,
        ReadableInTimeRangeHealthDataType<SleepingWristTemperatureRecord>,
        MinAggregatableHealthDataType<Temperature>,
        MaxAggregatableHealthDataType<Temperature>,
        AvgAggregatableHealthDataType<Temperature> {
  /// Creates a sleeping wrist temperature data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SleepingWristTemperatureDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'sleeping_wrist_temperature';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepingWristTemperatureDataType &&
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
  ReadRecordByIdRequest<SleepingWristTemperatureRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SleepingWristTemperatureRecord>
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
  List<Permission> get permissions => [readPermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  AggregateRequest<Temperature> aggregateAvg({
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
  AggregateRequest<Temperature> aggregateMax({
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
  AggregateRequest<Temperature> aggregateMin({
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
}
