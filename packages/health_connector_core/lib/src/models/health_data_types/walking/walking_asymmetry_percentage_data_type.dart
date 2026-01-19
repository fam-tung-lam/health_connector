part of '../health_data_type.dart';

/// Walking Asymmetry Percentage data type.
///
/// Tracks the percentage of steps where one footstrike is moving at a
/// different speed than the other. This metric helps assess gait symmetry
/// and can indicate potential mobility issues or injury recovery progress.
///
/// > **Note**: This data type is read-only. Walking Asymmetry Percentage is
/// > calculated by Apple's internal algorithms and cannot be written or
/// > deleted by third-party apps.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.walkingAsymmetryPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingasymmetrypercentage)
///
/// ## Example
///
/// ```dart
/// // Request read permission
/// final permissions = [
///   HealthDataType.walkingAsymmetryPercentage.readPermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request =
///     HealthDataType.walkingAsymmetryPercentage.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Walking asymmetry: ${record.percentage.asWhole}%');
///   print('Device side: ${record.devicePlacementSide}');
/// }
///
/// // Aggregate average walking asymmetry
/// final aggRequest =
///     HealthDataType.walkingAsymmetryPercentage.aggregateAvg(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Average asymmetry: ${aggResponse.value?.asWhole}%');
/// ```
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@immutable
final class WalkingAsymmetryPercentageDataType
    extends HealthDataType<WalkingAsymmetryPercentageRecord, Percentage>
    implements
        ReadableByIdHealthDataType<WalkingAsymmetryPercentageRecord>,
        ReadableInTimeRangeHealthDataType<WalkingAsymmetryPercentageRecord>,
        MinAggregatableHealthDataType<Percentage>,
        MaxAggregatableHealthDataType<Percentage>,
        AvgAggregatableHealthDataType<Percentage> {
  /// Creates a Walking Asymmetry Percentage data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WalkingAsymmetryPercentageDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'walking_asymmetry_percentage';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingAsymmetryPercentageDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<WalkingAsymmetryPercentageRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WalkingAsymmetryPercentageRecord>
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
