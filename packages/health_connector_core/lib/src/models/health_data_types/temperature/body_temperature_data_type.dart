part of '../health_data_type.dart';

/// Body temperature data type.
///
/// Represents body temperature measurements, typically used for monitoring
/// health status, fever detection, and reproductive health tracking.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BodyTemperatureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyTemperatureRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bodyTemperature`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodytemperature)
///
/// ## Capabilities
///
/// - Readable: Query body temperature records
/// - Writeable: Write body temperature records
/// - Deletable: Delete records by IDs or time range
/// - Not aggregatable
///
/// ## See also
///
/// - [BodyTemperatureRecord]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class BodyTemperatureDataType
    extends HealthDataType<BodyTemperatureRecord, Temperature>
    implements
        ReadableByIdHealthDataType<BodyTemperatureRecord>,
        ReadableInTimeRangeHealthDataType<BodyTemperatureRecord>,
        WriteableHealthDataType<BodyTemperatureRecord>,
        DeletableByIdsHealthDataType<BodyTemperatureRecord>,
        DeletableInTimeRangeHealthDataType<BodyTemperatureRecord> {
  /// Creates a body temperature data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BodyTemperatureDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'body_temperature';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyTemperatureDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BodyTemperatureRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BodyTemperatureRecord> readInTimeRange({
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
