part of '../health_data_type.dart';

/// Represents the HeartbeatSeries health data type.
///
/// HeartbeatSeries stores the precise timing of every single heartbeat (R-R
/// intervals) measured over a time interval. This data is primarily used to
/// calculate Heart Rate Variability (HRV) and detect irregularities.
///
/// Unlike [HeartRateSeriesRecord], which stores the *frequency* of beats (BPM),
/// this record stores the precise *timing* of every single heartbeat.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKDataTypeIdentifierHeartbeatSeries`](https://developer.apple.com/documentation/healthkit/hkdatatypeidentifierheartbeatseries)
/// - **Android Health Connect**: Not supported (Use [HeartRateSeriesDataType])
///
/// ## Capabilities
///
/// - Readable: Query heartbeat series records
/// - Writeable: Write heartbeat series records
/// - Deletable: Delete records by IDs or time range
/// - Aggregation: Not supported
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.heartbeatSeries.readPermission,
///   HealthDataType.heartbeatSeries.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.heartbeatSeries.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest1 = HealthDataType.heartbeatSeries.deleteByIds([
///   id1,
///   id2,
/// ]);
/// await connector.deleteRecords(deleteRequest1);
///
/// // Delete records in time range
/// final deleteRequest2 = HealthDataType.heartbeatSeries.deleteInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// await connector.deleteRecords(deleteRequest2);
/// ```
///
/// ## See also
///
/// - [HeartbeatSeriesRecord]
/// - [HeartRateSeriesDataType]
/// - [HeartRateSeriesRecord]
///
/// {@category Health Records}
@sinceV3_7_0
@supportedOnAppleHealth
@immutable
final class HeartbeatSeriesDataType
    extends HealthDataType<HeartbeatSeriesRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<HeartbeatSeriesRecord>,
        ReadableInTimeRangeHealthDataType<HeartbeatSeriesRecord>,
        WriteableHealthDataType<HeartbeatSeriesRecord>,
        DeletableByIdsHealthDataType<HeartbeatSeriesRecord>,
        DeletableInTimeRangeHealthDataType<HeartbeatSeriesRecord> {
  /// Creates a heartbeat series data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const HeartbeatSeriesDataType();

  @override
  String get id => 'heartbeat_series';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartbeatSeriesDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<HeartbeatSeriesRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HeartbeatSeriesRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

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
