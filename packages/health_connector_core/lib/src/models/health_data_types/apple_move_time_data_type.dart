part of 'health_data_type.dart';

/// Apple Move Time data type.
///
/// Tracks the amount of time the user has performed activity that contributes
/// towards the user's daily Move goals in Apple Health. This is an iOS-specific
/// metric calculated by Apple's algorithms based on active calories burned.
///
/// > **Note**: This data type is read-only. Apple Move Time is calculated
/// > by internal Apple's algorithms and cannot be written or deleted by
/// > third-party apps.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.appleMoveTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/applemovetime)
///
/// ## Example
///
/// ```dart
/// // Request read permission
/// final permissions = [
///   HealthDataType.appleMoveTime.readPermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.appleMoveTime.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Move time: ${record.moveTime.inMinutes} minutes');
/// }
///
/// // Aggregate total move time
/// final aggRequest = HealthDataType.appleMoveTime.aggregateSum(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Total move time: ${aggResponse.value?.inMinutes} minutes');
/// ```
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@immutable
final class AppleMoveTimeDataType
    extends HealthDataType<AppleMoveTimeRecord, TimeDuration>
    implements
        ReadableByIdHealthDataType<AppleMoveTimeRecord>,
        ReadableInTimeRangeHealthDataType<AppleMoveTimeRecord>,
        SumAggregatableHealthDataType<TimeDuration> {
  /// Creates an Apple Move Time data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const AppleMoveTimeDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'apple_move_time';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppleMoveTimeDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<AppleMoveTimeRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<AppleMoveTimeRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  AggregateRequest<TimeDuration> aggregateSum({
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
}
