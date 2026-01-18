part of 'health_data_type.dart';

/// Activity intensity data type.
///
/// Tracks periods of moderate and vigorous physical activity.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`ActivityIntensityRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ActivityIntensityRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Capabilities
///
/// - Readable: Query activity intensity records
/// - Writeable: Write activity intensity records
/// - Aggregatable: Calculate sum of activity duration
/// - Deletable: Delete records by IDs or time range
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.activityIntensity.readPermission,
///   HealthDataType.activityIntensity.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Write a record
/// final record = ActivityIntensityRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   activityIntensityType: ActivityIntensityType.vigorous,
///   title: 'Evening Run',
///   metadata: Metadata.automaticallyRecorded(),
/// );
/// await connector.writeRecords([record]);
///
/// // Read records
/// final request = HealthDataType.activityIntensity.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Aggregate total duration
/// final aggRequest = HealthDataType.activityIntensity.aggregateSum(
///   intensityType: null,  // Total across all intensities
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// ```
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnHealthConnect
@immutable
final class ActivityIntensityDataType
    extends HealthDataType<ActivityIntensityRecord, TimeDuration>
    implements
        ReadableByIdHealthDataType<ActivityIntensityRecord>,
        ReadableInTimeRangeHealthDataType<ActivityIntensityRecord>,
        WriteableHealthDataType<ActivityIntensityRecord>,
        DeletableByIdsHealthDataType<ActivityIntensityRecord>,
        DeletableInTimeRangeHealthDataType<ActivityIntensityRecord> {
  /// Creates an activity intensity data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const ActivityIntensityDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  String get id => 'activity_intensity';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityIntensityDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ActivityIntensityRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ActivityIntensityRecord> readInTimeRange({
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
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  /// Creates a request to calculate sum of activity duration.
  ///
  /// The [intensityType] parameter determines the aggregation metric:
  /// - `null`: Total duration across all intensity types
  /// - `ActivityIntensityType.moderate`: Moderate intensity duration only
  /// - `ActivityIntensityType.vigorous`: Vigorous intensity duration only
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Aggregate total activity duration
  /// final totalRequest = HealthDataType.activityIntensity.aggregateSum(
  ///   intensityType: null,
  ///   startTime: DateTime.now().subtract(Duration(days: 7)),
  ///   endTime: DateTime.now(),
  /// );
  /// final totalResponse = await connector.aggregate(totalRequest);
  /// print('Total activity: ${totalResponse.value?.inMinutes} minutes');
  ///
  /// // Aggregate vigorous activity duration
  /// final vigorousRequest = HealthDataType.activityIntensity.aggregateSum(
  ///   intensityType: ActivityIntensityType.vigorous,
  ///   startTime: DateTime.now().subtract(Duration(days: 7)),
  ///   endTime: DateTime.now(),
  /// );
  /// final vigorousResponse = await connector.aggregate(vigorousRequest);
  /// print('Vigorous activity: ${vigorousResponse.value?.inMinutes} minutes');
  /// ```
  ActivityIntensityAggregateRequest aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
    ActivityIntensityType? intensityType,
  }) {
    return ActivityIntensityAggregateRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      intensityType: intensityType,
    );
  }

  @override
  DeleteRecordsByIdsRequest deleteByIds(List<HealthRecordId> recordIds) {
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
}
