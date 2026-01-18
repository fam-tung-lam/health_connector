part of '../health_data_type.dart';

/// Lactation data type.
///
/// Tracks lactation events.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.lactation`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/lactation)
///
/// ## Capabilities
///
/// - Readable: Query lactation records
/// - Writeable: Write lactation records
/// - Deletable: Delete lactation records by IDs or time range
///
/// ## See also
///
/// - [LactationRecord]
///
/// {@category Reproductive Health}
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
class LactationDataType extends HealthDataType<LactationRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<LactationRecord>,
        ReadableInTimeRangeHealthDataType<LactationRecord>,
        WriteableHealthDataType<LactationRecord>,
        DeletableByIdsHealthDataType<LactationRecord>,
        DeletableInTimeRangeHealthDataType<LactationRecord> {
  /// {@macro health_data_type.const}
  const LactationDataType() : super();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'lactation';

  @override
  HealthDataTypeCategory get category =>
      HealthDataTypeCategory.reproductiveHealth;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  ReadRecordByIdRequest<LactationRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<LactationRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<LactationRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<LactationRecord> deleteInTimeRange({
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
