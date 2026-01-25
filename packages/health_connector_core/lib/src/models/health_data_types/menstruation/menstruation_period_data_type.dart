part of '../health_data_type.dart';

/// Represents the Menstruation Period health data type.
///
/// This data type captures user's menstruation periods. Each record represents
/// a menstruation period spanning a time interval.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`MenstruationPeriodRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MenstruationPeriodRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Capabilities
///
/// - Readable: Query menstruation period records
/// - Writeable: Write menstruation period records
/// - Deletable: Delete records by IDs or time range
/// - Aggregation: Not supported
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.menstruationPeriod.readPermission,
///   HealthDataType.menstruationPeriod.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.menstruationPeriod.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 90)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Write a record
/// final record = MenstruationPeriodRecord(
///   startTime: DateTime(2024, 1, 1),
///   endTime: DateTime(2024, 1, 5),
///   metadata: Metadata.manuallyRecorded(),
/// );
/// await connector.writeRecord(record);
/// ```
///
/// ## See also
///
/// - [MenstruationPeriodRecord]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnHealthConnect
@immutable
final class MenstruationPeriodDataType
    extends HealthDataType<MenstruationPeriodRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<MenstruationPeriodRecord>,
        ReadableInTimeRangeHealthDataType<MenstruationPeriodRecord>,
        WriteableHealthDataType<MenstruationPeriodRecord>,
        DeletableByIdsHealthDataType<MenstruationPeriodRecord>,
        DeletableInTimeRangeHealthDataType<MenstruationPeriodRecord> {
  /// Creates a menstruation period data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const MenstruationPeriodDataType();

  @override
  String get id => 'menstruation_period';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstruationPeriodDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<MenstruationPeriodRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<MenstruationPeriodRecord> readInTimeRange({
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
  HealthDataTypeCategory get category =>
      HealthDataTypeCategory.reproductiveHealth;

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
