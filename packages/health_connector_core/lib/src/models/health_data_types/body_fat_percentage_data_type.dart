part of 'health_data_type.dart';

/// Body fat percentage data type.
///
/// Represents the percentage of body weight that is fat tissue, used for
/// tracking body composition and fitness progress.
///
/// ## Measurement Unit
///
/// Values are measured as [Percentage] (decimal from 0-1).
/// For example, 0.25 represents 25% body fat.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BodyFatRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyFatRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bodyFatPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodyfatpercentage)
///
/// ## Capabilities
///
/// - Readable: Query body fat percentage records
/// - Writeable: Write body fat percentage records
/// - Deletable: Delete records by IDs or time range
/// - Not aggregatable
///
/// ## See also
///
/// - [BodyFatPercentageRecord]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class BodyFatPercentageDataType
    extends HealthDataType<BodyFatPercentageRecord, Percentage>
    implements
        ReadableHealthDataType<BodyFatPercentageRecord>,
        WriteableHealthDataType<BodyFatPercentageRecord>,
        DeletableHealthDataType<BodyFatPercentageRecord> {
  /// Creates a body fat percentage data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const BodyFatPercentageDataType();

  @override
  String get id => 'body_fat_percentage';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyFatPercentageDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BodyFatPercentageRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BodyFatPercentageRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<BodyFatPercentageRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<BodyFatPercentageRecord> deleteInTimeRange({
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
