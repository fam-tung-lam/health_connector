part of '../health_data_type.dart';

/// Walking heart rate average data type.
///
/// Represents a user's average heart rate while walking. A user’s average
/// heart rate while walking is correlated to their fitness level, because it
/// corresponds to their heart’s efficiency while physically active.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are calculated by
/// > the platform (e.g., Apple Watch on iOS HealthKit) and cannot be
/// > written or deleted by third-party apps.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.walkingHeartRateAverage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingheartrateaverage)
///
/// ## Example
///
/// ```dart
/// // Request read permission
/// final permissions = [
///   HealthDataType.walkingHeartRateAverage.readPermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request =
///     HealthDataType.walkingHeartRateAverage.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Heart rate: ${record.rate}');
/// }
///
/// // Aggregate average walking heart rate
/// final aggRequest =
///     HealthDataType.walkingHeartRateAverage.aggregateAvg(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Average walking HR: ${aggResponse.value}');
/// ```
///
/// ## See also
///
/// - [WalkingHeartRateAverageRecord]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealth
@readOnly
@immutable
final class WalkingHeartRateAverageDataType
    extends HealthDataType<WalkingHeartRateAverageRecord, Frequency>
    implements
        ReadableByIdHealthDataType<WalkingHeartRateAverageRecord>,
        ReadableInTimeRangeHealthDataType<WalkingHeartRateAverageRecord>,
        MinAggregatableHealthDataType<Frequency>,
        MaxAggregatableHealthDataType<Frequency>,
        AvgAggregatableHealthDataType<Frequency> {
  /// Creates a walking heart rate average data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WalkingHeartRateAverageDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'walking_heart_rate_average';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingHeartRateAverageDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<WalkingHeartRateAverageRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WalkingHeartRateAverageRecord> readInTimeRange({
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
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.min,
    AggregationMetric.max,
    AggregationMetric.avg,
  ];

  @override
  AggregateRequest<Frequency> aggregateMin({
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
  AggregateRequest<Frequency> aggregateMax({
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
  AggregateRequest<Frequency> aggregateAvg({
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
}
