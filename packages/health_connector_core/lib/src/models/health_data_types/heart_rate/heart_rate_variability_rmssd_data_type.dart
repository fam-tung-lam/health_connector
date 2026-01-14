part of '../health_data_type.dart';

/// Heart rate variability (RMSSD) data type.
///
/// Represents the Root Mean Square of Successive Differences (RMSSD) between
/// heartbeats. This is a common measure of heart rate variability.
///
/// ## Measurement Unit
///
/// Values are measured in milliseconds ([Number]).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`HeartRateVariabilityRMSSDRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateVariabilityRMSSDRecord)
/// - **iOS HealthKit**: Not supported.
///
/// ## Capabilities
///
/// - Readable: Query HRV RMSSD records
/// - Writeable: Write HRV RMSSD records
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [HeartRateVariabilityRMSSDRecord]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class HeartRateVariabilityRMSSDDataType
    extends HealthDataType<HeartRateVariabilityRMSSDRecord, Number>
    implements
        ReadableHealthDataType<HeartRateVariabilityRMSSDRecord>,
        WriteableHealthDataType<HeartRateVariabilityRMSSDRecord>,
        DeletableHealthDataType<HeartRateVariabilityRMSSDRecord> {
  /// Creates a heart rate variability (RMSSD) data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  const HeartRateVariabilityRMSSDDataType();

  @override
  String get id => 'heart_rate_variability_rmssd';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<HeartRateVariabilityRMSSDRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HeartRateVariabilityRMSSDRecord>
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
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  DeleteRecordsByIdsRequest<HeartRateVariabilityRMSSDRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<HeartRateVariabilityRMSSDRecord>
  deleteInTimeRange({
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateVariabilityRMSSDDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
