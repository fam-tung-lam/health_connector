part of '../health_data_type.dart';

/// Pregnancy test data type.
///
/// Pregnancy test records track the results of tests that detect the
/// presence of human chorionic gonadotropin (hCG) hormone to determine
/// pregnancy status.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.pregnancyTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/pregnancytestresult)
///
/// ## Capabilities
///
/// - Readable: Query pregnancy test records
/// - Writeable: Write pregnancy test records
/// - Deletable: Delete records by IDs or time range
/// - Aggregation: Not supported (categorical data)
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.pregnancyTest.readPermission,
///   HealthDataType.pregnancyTest.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.pregnancyTest.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest = HealthDataType.pregnancyTest.deleteByIds([id1, id2]);
/// await connector.deleteRecords(deleteRequest);
///
/// // Delete records in time range
/// final deleteRangeRequest = HealthDataType.pregnancyTest.deleteInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// await connector.deleteRecords(deleteRangeRequest);
/// ```
///
/// ## See also
///
/// - [PregnancyTestRecord]
/// - [PregnancyTestResult]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class PregnancyTestDataType
    extends HealthDataType<PregnancyTestRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<PregnancyTestRecord>,
        ReadableInTimeRangeHealthDataType<PregnancyTestRecord>,
        WriteableHealthDataType<PregnancyTestRecord>,
        DeletableByIdsHealthDataType<PregnancyTestRecord>,
        DeletableInTimeRangeHealthDataType<PregnancyTestRecord> {
  /// Creates a pregnancy test data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const PregnancyTestDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'pregnancy_test';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PregnancyTestDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<PregnancyTestRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PregnancyTestRecord> readInTimeRange({
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
