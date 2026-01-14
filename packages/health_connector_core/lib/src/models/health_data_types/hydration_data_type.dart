part of 'health_data_type.dart';

/// Health data type for hydration (water intake) information.
///
/// Tracks water consumption over time, enabling users to monitor daily
/// hydration levels and maintain healthy fluid intake.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`HydrationRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HydrationRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.dietaryWater`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarywater)
///
/// ## Capabilities
/// - Read: Query historical hydration records
/// - Write: Create new hydration records
/// - Aggregate: Sum (total intake)
/// - Deletable: Delete records by IDs or time range
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.hydration.readPermission,
///   HealthDataType.hydration.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Write a hydration record
/// final record = HydrationRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime.now().subtract(Duration(minutes: 10)),
///   endTime: DateTime.now(),
///   volume: Volume.milliliters(250),
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// await connector.writeRecord(record);
///
/// // Read records
/// final request = HealthDataType.hydration.readRecords(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Aggregate total intake
/// final aggRequest = HealthDataType.hydration.aggregateSum(
///   startTime: DateTime.now().subtract(Duration(days: 1)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Total water intake: ${aggResponse.value?.inLiters} L');
/// ```
///
/// ## See also
///
/// - [HydrationRecord]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class HydrationDataType extends HealthDataType<HydrationRecord, Volume>
    implements
        ReadableHealthDataType<HydrationRecord>,
        WriteableHealthDataType<HydrationRecord>,
        SumAggregatableHealthDataType<HydrationRecord, Volume>,
        DeletableHealthDataType<HydrationRecord> {
  /// Creates a hydration data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const HydrationDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'hydration';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HydrationDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<HydrationRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HydrationRecord> readInTimeRange({
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
  AggregateRequest<HydrationRecord, Volume> aggregateSum({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.nutrition;

  @override
  DeleteRecordsByIdsRequest<HydrationRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<HydrationRecord> deleteInTimeRange({
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
