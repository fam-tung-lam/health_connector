part of '../health_data_type.dart';

/// Pregnancy data type.
///
/// Pregnancy records track the state of pregnancy.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.pregnancy`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/pregnancy)
///
/// ## Capabilities
///
/// - Readable: Query pregnancy records
/// - Writeable: Write pregnancy records
/// - Deletable: Delete records by IDs or time range
/// - Aggregation: Not supported (categorical data)
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.pregnancy.readPermission,
///   HealthDataType.pregnancy.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.pregnancy.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 300)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest = HealthDataType.pregnancy.deleteByIds([id1]);
/// await connector.deleteRecords(deleteRequest);
/// ```
///
/// ## See also
///
/// - [PregnancyRecord]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class PregnancyDataType
    extends HealthDataType<PregnancyRecord, TimeDuration>
    implements
        ReadableByIdHealthDataType<PregnancyRecord>,
        ReadableInTimeRangeHealthDataType<PregnancyRecord>,
        WriteableHealthDataType<PregnancyRecord>,
        DeletableByIdsHealthDataType<PregnancyRecord>,
        DeletableInTimeRangeHealthDataType<PregnancyRecord> {
  /// Creates a pregnancy data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const PregnancyDataType() : super();

  @override
  String get id => 'pregnancy';

  @override
  HealthDataTypeCategory get category =>
      HealthDataTypeCategory.reproductiveHealth;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  List<HealthPlatform> get supportedHealthPlatforms => const [
    HealthPlatform.appleHealth,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<PregnancyRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PregnancyRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<PregnancyRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<PregnancyRecord> deleteInTimeRange({
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
