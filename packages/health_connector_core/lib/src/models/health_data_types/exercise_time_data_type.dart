part of 'health_data_type.dart';

/// Apple Exercise Time data type.
///
/// Tracks the amount of time spent exercising that contributes towards the
/// user's daily exercise goals in Apple Health. This is an iOS-specific metric
/// calculated by Apple's algorithms based on heart rate, movement, and activity
/// intensity.
///
/// > **Note**: This data type is read-only. Apple Exercise Time is calculated
/// > by internal Apple's algorithms and cannot be written or deleted by
/// > third-party apps.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.appleExerciseTime`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/appleexercisetime)
///
/// ## Example
///
/// ```dart
/// // Request read permission
/// final permissions = [
///   HealthDataType.exerciseTime.readPermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.exerciseTime.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Exercise time: ${record.exerciseTime.inMinutes} minutes');
/// }
///
/// // Aggregate total exercise time
/// final aggRequest = HealthDataType.exerciseTime.aggregateSum(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Total exercise: ${aggResponse.value?.inMinutes} minutes');
/// ```
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@immutable
final class ExerciseTimeDataType
    extends HealthDataType<ExerciseTimeRecord, TimeDuration>
    implements
        ReadableByIdHealthDataType<ExerciseTimeRecord>,
        ReadableInTimeRangeHealthDataType<ExerciseTimeRecord>,
        SumAggregatableHealthDataType<TimeDuration> {
  /// Creates an Apple Exercise Time data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const ExerciseTimeDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'apple_exercise_time';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseTimeDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ExerciseTimeRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ExerciseTimeRecord> readInTimeRange({
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
