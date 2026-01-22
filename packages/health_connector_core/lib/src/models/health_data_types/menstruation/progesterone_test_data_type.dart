part of '../health_data_type.dart';

/// Progesterone test data type.
///
/// Progesterone test records track the results of tests that detect the
/// presence of progesterone hormone to confirm ovulation.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.progesteroneTestResult`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/progesteronetestresult)
///
/// ## Capabilities
///
/// - Readable: Query progesterone test records
/// - Writeable: Write progesterone test records
/// - Deletable: Delete records by IDs or time range
/// - Aggregation: Not supported (categorical data)
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.progesteroneTest.readPermission,
///   HealthDataType.progesteroneTest.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.progesteroneTest.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest = HealthDataType.progesteroneTest.deleteByIds([id1]);
/// await connector.deleteRecords(deleteRequest);
/// ```
///
/// ## See also
///
/// - [ProgesteroneTestRecord]
/// - [ProgesteroneTestResult]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class ProgesteroneTestDataType
    extends HealthDataType<ProgesteroneTestRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<ProgesteroneTestRecord>,
        ReadableInTimeRangeHealthDataType<ProgesteroneTestRecord>,
        WriteableHealthDataType<ProgesteroneTestRecord>,
        DeletableByIdsHealthDataType<ProgesteroneTestRecord>,
        DeletableInTimeRangeHealthDataType<ProgesteroneTestRecord> {
  /// Creates a progesterone test data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const ProgesteroneTestDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'progesterone_test';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgesteroneTestDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ProgesteroneTestRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ProgesteroneTestRecord> readInTimeRange({
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
