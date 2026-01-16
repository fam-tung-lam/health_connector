part of 'health_data_type.dart';

/// Swimming strokes count data type.
///
/// Tracks the number of strokes taken during swimming.
///
/// ## Measurement Unit
///
/// Values are measured as [Number] (count of strokes).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.swimmingStrokeCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/swimmingStrokeCount)
///
/// ## Capabilities
///
/// - Readable: Query swimming strokes records
/// - Writeable: Write swimming strokes records
/// - Aggregatable: Sum total strokes
/// - Deletable: Delete swimming strokes records by IDs or time range
///
/// ## See also
///
/// - [SwimmingStrokesRecord]
///
/// {@category Health Records}
@sinceV3_1_0
@immutable
final class SwimmingStrokesDataType
    extends HealthDataType<SwimmingStrokesRecord, Number>
    implements
        ReadableHealthDataType<SwimmingStrokesRecord>,
        WriteableHealthDataType<SwimmingStrokesRecord>,
        SumAggregatableHealthDataType<SwimmingStrokesRecord, Number>,
        DeletableHealthDataType<SwimmingStrokesRecord> {
  /// Creates a swimming strokes data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SwimmingStrokesDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'swimmingStrokes';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SwimmingStrokesDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SwimmingStrokesRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SwimmingStrokesRecord> readInTimeRange({
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
  AggregateRequest<SwimmingStrokesRecord, Number> aggregateSum({
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
  DeleteRecordsByIdsRequest<SwimmingStrokesRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<SwimmingStrokesRecord> deleteInTimeRange({
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
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;
}
