part of 'health_data_type.dart';

/// Alcoholic beverages data type.
///
/// Tracks the number of alcoholic beverages consumed, typically recorded
/// manually by users for health monitoring purposes.
///
/// ## Measurement Unit
///
/// Values are measured as [Number] (count of alcoholic beverages).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.numberOfAlcoholicBeverages`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/numberofalcoholicbeverages)
///
/// ## Capabilities
///
/// - Readable: Query alcoholic beverages records
/// - Writeable: Write alcoholic beverages records
/// - Aggregatable: Sum total alcoholic beverages
/// - Deletable: Delete alcoholic beverages records by IDs or time range
///
/// ## See also
///
/// - [AlcoholicBeveragesRecord]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class AlcoholicBeveragesDataType
    extends HealthDataType<AlcoholicBeveragesRecord, Number>
    implements
        ReadableByIdHealthDataType<AlcoholicBeveragesRecord>,
        ReadableInTimeRangeHealthDataType<AlcoholicBeveragesRecord>,
        WriteableHealthDataType<AlcoholicBeveragesRecord>,
        SumAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<AlcoholicBeveragesRecord>,
        DeletableInTimeRangeHealthDataType<AlcoholicBeveragesRecord> {
  /// Creates an alcoholic beverages data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const AlcoholicBeveragesDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'alcoholic_beverages';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlcoholicBeveragesDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<AlcoholicBeveragesRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<AlcoholicBeveragesRecord> readInTimeRange({
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
  AggregateRequest<Number> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.nutrition;
}
