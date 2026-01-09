part of '../health_data_type.dart';

/// Distance data type.
///
/// Represents generic distance measurements on Android Health Connect.
/// Tracks distance covered during any activity.
///
/// ## Measurement Unit
///
/// Values are measured in [Length] units (meters, kilometers, miles, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`DistanceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/DistanceRecord)
/// - **iOS HealthKit**: Not directly supported (use activity-specific types
/// like [CyclingDistanceDataType])
///
/// ## Capabilities
///
/// - Readable: Query distance records
/// - Writeable: Write distance records
/// - Aggregatable: Sum total distance
///
/// > [!NOTE]
/// > This data type is only supported on Android Health Connect. For iOS,
/// > use activity-specific distance types.
///
/// {@category Health Data Types}
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class DistanceHealthDataType
    extends HealthDataType<DistanceRecord, Length>
    implements
        ReadableHealthDataType<DistanceRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<DistanceRecord, Length> {
  /// Creates a distance data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DistanceHealthDataType();

  @override
  String get id => 'distance';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistanceHealthDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DistanceRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DistanceRecord> readInTimeRange({
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
  AggregateRequest<DistanceRecord, Length> aggregateSum({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;
}
