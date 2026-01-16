part of '../health_data_type.dart';

/// Represents the contraceptive usage health data type.
///
/// A contraceptive data type tracks periods during which contraceptive methods
/// are used, including the type of contraceptive.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.contraceptive`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/contraceptive)
/// - **Android Health Connect**: Not supported
///
/// ## Capabilities
///
/// - Readable: Query historical contraceptive records
/// - Writeable: Create new contraceptive records
/// - Deletable: Remove contraceptive records created by your app
/// - Aggregatable: Not supported
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.contraceptive.readPermission,
///   HealthDataType.contraceptive.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.contraceptive.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 365)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Write a new record
/// final record = ContraceptiveRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime(2024, 1, 1),
///   endTime: DateTime(2024, 6, 30),
///   contraceptiveType: ContraceptiveType.oral,
///   metadata: Metadata.manuallyEntered(),
/// );
/// await connector.writeRecords([record]);
///
/// // Delete records by IDs
/// final deleteRequest = HealthDataType.contraceptive.deleteByIds([id1, id2]);
/// await connector.deleteRecords(deleteRequest);
///
/// // Delete records in time range
/// final deleteRangeRequest = HealthDataType.contraceptive.deleteInTimeRange(
///   startTime: DateTime(2024, 1, 1),
///   endTime: DateTime(2024, 6, 30),
/// );
/// await connector.deleteRecords(deleteRangeRequest);
/// ```
///
/// ## See also
///
/// - [ContraceptiveRecord]
/// - [ContraceptiveType]
///
/// {@category Health Records}
/// {@category Reproductive Health}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
class ContraceptiveDataType
    extends HealthDataType<ContraceptiveRecord, MeasurementUnit>
    implements
        ReadableHealthDataType<ContraceptiveRecord>,
        WriteableHealthDataType<ContraceptiveRecord>,
        DeletableHealthDataType<ContraceptiveRecord> {
  /// {@macro health_data_type.const}
  const ContraceptiveDataType() : super();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'contraceptive';

  @override
  HealthDataTypeCategory get category =>
      HealthDataTypeCategory.reproductiveHealth;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  ReadRecordByIdRequest<ContraceptiveRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ContraceptiveRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<ContraceptiveRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<ContraceptiveRecord> deleteInTimeRange({
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
