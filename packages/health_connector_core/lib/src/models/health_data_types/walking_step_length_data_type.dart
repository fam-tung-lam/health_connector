part of 'health_data_type.dart';

/// Walking Step Length data type.
///
/// Tracks the distance between the point of initial contact of one foot
/// and the point of initial contact of the opposite foot.
///
/// > **Note**: This data type is read-only. Walking Step Length is often
/// > calculated by Apple's internal algorithms and is typically read-only
/// > for third-party apps.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.walkingStepLength`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingsteplength)
///
/// ## Example
///
/// ```dart
/// // Request read permission
/// final permissions = [
///   HealthDataType.walkingStepLength.readPermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.walkingStepLength.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Step length: ${record.length.inMeters} meters');
///   print('Device side: ${record.devicePlacementSide}');
/// }
///
/// // Aggregate average walking step length
/// final aggRequest = HealthDataType.walkingStepLength.aggregateAvg(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Average step length: ${aggResponse.value?.inMeters} meters');
/// ```
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@immutable
final class WalkingStepLengthDataType
    extends HealthDataType<WalkingStepLengthRecord, Length>
    implements
        ReadableByIdHealthDataType<WalkingStepLengthRecord>,
        ReadableInTimeRangeHealthDataType<WalkingStepLengthRecord>,
        MinAggregatableHealthDataType<Length>,
        MaxAggregatableHealthDataType<Length>,
        AvgAggregatableHealthDataType<Length> {
  /// Creates a Walking Step Length data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WalkingStepLengthDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'walking_step_length';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingStepLengthDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<WalkingStepLengthRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WalkingStepLengthRecord> readInTimeRange({
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
  AggregateRequest<Length> aggregateMin({
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
  AggregateRequest<Length> aggregateMax({
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
  AggregateRequest<Length> aggregateAvg({
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
