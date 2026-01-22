part of 'health_data_type.dart';

/// Insulin delivery data type.
///
/// Tracks the amount of insulin delivered to the user. This is typically
/// recorded by insulin pumps and other diabetes management devices.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.insulinDelivery`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/insulindelivery)
///
/// ## Capabilities
///
/// - Readable: Query insulin delivery records
/// - Writeable: Write insulin delivery records
/// - Aggregatable: Sum total insulin delivered
/// - Deletable: Delete insulin delivery records by IDs or time range
///
/// ## See also
///
/// - [InsulinDeliveryRecord]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealth
@immutable
final class InsulinDeliveryDataType
    extends HealthDataType<InsulinDeliveryRecord, Number>
    implements
        ReadableByIdHealthDataType<InsulinDeliveryRecord>,
        ReadableInTimeRangeHealthDataType<InsulinDeliveryRecord>,
        WriteableHealthDataType<InsulinDeliveryRecord>,
        SumAggregatableHealthDataType<Number>,
        DeletableByIdsHealthDataType<InsulinDeliveryRecord>,
        DeletableInTimeRangeHealthDataType<InsulinDeliveryRecord> {
  /// Creates an insulin delivery data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const InsulinDeliveryDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'insulin_delivery';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsulinDeliveryDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<InsulinDeliveryRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<InsulinDeliveryRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.clinical;
}
