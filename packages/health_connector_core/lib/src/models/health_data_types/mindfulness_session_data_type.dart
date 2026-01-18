part of 'health_data_type.dart';

/// Mindfulness session data type.
///
/// Represents mindfulness sessions including meditation, breathing exercises,
/// and other mindfulness activities.
///
/// ## Measurement Unit
///
/// Duration is measured in [TimeDuration] (seconds, minutes, hours).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`MindfulnessSessionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MindfulnessSessionRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.mindfulSession`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/mindfulsession)
///
/// ## Capabilities
///
/// - Readable: Query mindfulness session records
/// - Writeable: Write mindfulness session records
/// - Aggregatable: Sum total mindfulness duration
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [MindfulnessSessionRecord]
/// - [MindfulnessSessionType]
///
/// {@category Health Records}
@sinceV2_1_0
@immutable
final class MindfulnessSessionDataType
    extends HealthDataType<MindfulnessSessionRecord, TimeDuration>
    implements
        ReadableHealthDataType<MindfulnessSessionRecord>,
        ReadableByIdHealthDataType<MindfulnessSessionRecord>,
        ReadableInTimeRangeHealthDataType<MindfulnessSessionRecord>,
        WriteableHealthDataType<MindfulnessSessionRecord>,
        SumAggregatableHealthDataType<TimeDuration>,
        DeletableByIdsHealthDataType<MindfulnessSessionRecord>,
        DeletableInTimeRangeHealthDataType<MindfulnessSessionRecord> {
  /// Creates a mindfulness session data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const MindfulnessSessionDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'mindfulness_session';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MindfulnessSessionDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<MindfulnessSessionRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<MindfulnessSessionRecord> readInTimeRange({
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
  AggregateRequest<TimeDuration> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.mentalHealth;

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
}
