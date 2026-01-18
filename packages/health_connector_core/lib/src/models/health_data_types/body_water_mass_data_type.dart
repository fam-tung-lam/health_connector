part of 'health_data_type.dart';

/// Body water mass data type.
///
/// Represents the mass of water in the user's body.
/// This is a point-in-time measure.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (kilograms, pounds, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BodyWaterMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyWaterMassRecord)
/// - **iOS HealthKit**: Not supported.
///
/// ## Capabilities
///
/// - Readable: Query body water mass records
/// - Writeable: Write body water mass records
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [BodyWaterMassRecord]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class BodyWaterMassDataType
    extends HealthDataType<BodyWaterMassRecord, Mass>
    implements
        ReadableByIdHealthDataType<BodyWaterMassRecord>,
        ReadableInTimeRangeHealthDataType<BodyWaterMassRecord>,
        WriteableHealthDataType<BodyWaterMassRecord>,
        DeletableByIdsHealthDataType<BodyWaterMassRecord>,
        DeletableInTimeRangeHealthDataType<BodyWaterMassRecord> {
  /// Creates a body water mass data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  const BodyWaterMassDataType();

  @override
  String get id => 'body_water_mass';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BodyWaterMassRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BodyWaterMassRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.bodyMeasurement;

  @override
  DeleteRecordsByIdsRequest<BodyWaterMassRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<BodyWaterMassRecord> deleteInTimeRange({
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
      other is BodyWaterMassDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
