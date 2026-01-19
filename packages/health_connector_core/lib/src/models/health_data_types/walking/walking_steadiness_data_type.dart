part of '../health_data_type.dart';

/// Apple Walking Steadiness data type.
///
/// Tracks the user's walking steadiness as a percentage, which measures the
/// stability and regularity of a person's gait. This metric helps assess
/// balance and fall risk, with higher percentages indicating more stable
/// walking patterns.
///
/// > **Note**: This data type is read-only. Apple Walking Steadiness is
/// > calculated by Apple's internal algorithms and cannot be written or
/// > deleted by third-party apps.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.appleWalkingSteadiness`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/applewalkingsteadiness)
///
/// ## Example
///
/// ```dart
/// // Request read permission
/// final permissions = [
///   HealthDataType.walkingSteadiness.readPermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.walkingSteadiness.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Walking steadiness: ${record.percentage.asWhole}%');
/// }
///
/// // Aggregate average walking steadiness
/// final aggRequest = HealthDataType.walkingSteadiness.aggregateAvg(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Average walking steadiness: ${aggResponse.value?.asWhole}%');
/// ```
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@readOnly
@immutable
final class WalkingSteadinessDataType
    extends HealthDataType<WalkingSteadinessRecord, Percentage>
    implements
        ReadableByIdHealthDataType<WalkingSteadinessRecord>,
        ReadableInTimeRangeHealthDataType<WalkingSteadinessRecord>,
        MinAggregatableHealthDataType<Percentage>,
        MaxAggregatableHealthDataType<Percentage>,
        AvgAggregatableHealthDataType<Percentage> {
  /// Creates an Apple Walking Steadiness data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WalkingSteadinessDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'apple_walking_steadiness';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingSteadinessDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<WalkingSteadinessRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WalkingSteadinessRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.mobility;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.min,
    AggregationMetric.max,
    AggregationMetric.avg,
  ];

  @override
  AggregateRequest<Percentage> aggregateMin({
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
  AggregateRequest<Percentage> aggregateMax({
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
  AggregateRequest<Percentage> aggregateAvg({
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
