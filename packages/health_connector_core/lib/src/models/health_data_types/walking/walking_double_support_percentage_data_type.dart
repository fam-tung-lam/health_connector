part of '../health_data_type.dart';

/// Walking Double Support Percentage data type.
///
/// Tracks the percentage of steps where both feet are on the ground.
/// A lower value generally indicates better balance and stability.
///
/// **Note**: While this data type supports write operations, Walking
/// Double Support Percentage is often calculated by Apple's internal
/// algorithms. Third-party apps can write data, but it may not appear in
/// all Apple Health contexts.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.walkingDoubleSupportPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingdoublesupportpercentage)
///
/// ## Example
///
/// ```dart
/// // Request read and write permissions
/// final permissions = [
///   HealthDataType.walkingDoubleSupportPercentage.readPermission,
///   HealthDataType.walkingDoubleSupportPercentage.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Write a record
/// final record = WalkingDoubleSupportPercentageRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 5)),
///   endTime: DateTime.now(),
///   percentage: Percentage.fromWhole(28.5),
///   devicePlacementSide: DevicePlacementSide.left,
///   metadata: Metadata.manualEntry(),
/// );
/// await connector.writeRecords([record]);
///
/// // Read records
/// final request =
///     HealthDataType.walkingDoubleSupportPercentage.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Double support: ${record.percentage.asWhole}%');
///   print('Device side: ${record.devicePlacementSide}');
/// }
///
/// // Aggregate average walking double support percentage
/// final aggRequest =
///     HealthDataType.walkingDoubleSupportPercentage.aggregateAvg(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Average double support: ${aggResponse.value?.asWhole}%');
///
/// // Delete records
/// final deleteRequest =
///     HealthDataType.walkingDoubleSupportPercentage.deleteByIds(
///   [record.id],
/// );
/// await connector.deleteRecords(deleteRequest);
/// ```
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@immutable
final class WalkingDoubleSupportPercentageDataType
    extends HealthDataType<WalkingDoubleSupportPercentageRecord, Percentage>
    implements
        ReadableByIdHealthDataType<WalkingDoubleSupportPercentageRecord>,
        ReadableInTimeRangeHealthDataType<WalkingDoubleSupportPercentageRecord>,
        WriteableHealthDataType<WalkingDoubleSupportPercentageRecord>,
        MinAggregatableHealthDataType<Percentage>,
        MaxAggregatableHealthDataType<Percentage>,
        AvgAggregatableHealthDataType<Percentage>,
        DeletableByIdsHealthDataType<WalkingDoubleSupportPercentageRecord>,
        DeletableInTimeRangeHealthDataType<
          WalkingDoubleSupportPercentageRecord
        > {
  /// Creates a Walking Double Support Percentage data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const WalkingDoubleSupportPercentageDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'walking_double_support_percentage';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingDoubleSupportPercentageDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  ReadRecordByIdRequest<WalkingDoubleSupportPercentageRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WalkingDoubleSupportPercentageRecord>
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

  @override
  List<Permission> get permissions => [readPermission, writePermission];

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
