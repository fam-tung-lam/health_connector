part of 'health_data_type.dart';

/// Health data type for hydration (water intake) information.
///
/// Tracks water consumption over time, enabling users to monitor daily
/// hydration levels and maintain healthy fluid intake.
///
/// ## Platform Support
/// - ✅ Android (Health Connect): Fully supported via `HydrationRecord`
/// - ✅ iOS (HealthKit): Fully supported via `dietaryWater`
///
/// ## Capabilities
/// - ✅ Read: Query historical hydration records
/// - ✅ Write: Create new hydration records
/// - ✅ Aggregate: Sum (total intake)
///
/// ## Example
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
@sinceV1_0_0
@immutable
final class HydrationHealthDataType
    extends HealthDataType<HydrationRecord, Volume>
    implements
        ReadableHealthDataType<HydrationRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<HydrationRecord, Volume> {
  @internal
  const HydrationHealthDataType();

  @override
  String get identifier => 'hydration';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HydrationHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'hydration_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordByIdRequest<HydrationRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<HydrationRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

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
}
