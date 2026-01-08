part of '../health_data_type.dart';

/// Ovulation test data type.
///
/// Ovulation test records track the results of tests that detect
/// hormonal changes to identify fertility windows.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`OvulationTestRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/OvulationTestRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.ovulationTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/ovulationtestresult)
///
/// ## Capabilities
///
/// - Readable: Query ovulation test records
/// - Writeable: Write ovulation test records
/// - Deletable: Delete records by IDs or time range
/// - Aggregation: Not supported (categorical data)
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.ovulationTest.readPermission,
///   HealthDataType.ovulationTest.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.ovulationTest.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest = HealthDataType.ovulationTest.deleteByIds([id1, id2]);
/// await connector.deleteRecords(deleteRequest);
///
/// // Delete records in time range
/// final deleteRangeRequest = HealthDataType.ovulationTest.deleteInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// await connector.deleteRecords(deleteRangeRequest);
/// ```
///
/// ## See also
///
/// - [OvulationTestRecord]
/// - [OvulationTestResultType]
///
/// {@category Health Data Types}
@sinceV2_2_0
@immutable
final class OvulationTestDataType
    extends HealthDataType<OvulationTestRecord, TimeDuration>
    implements
        ReadableHealthDataType<OvulationTestRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<OvulationTestRecord> {
  /// Creates an ovulation test data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const OvulationTestDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OvulationTestDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<OvulationTestRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<OvulationTestRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<OvulationTestRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<OvulationTestRecord> deleteInTimeRange({
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
