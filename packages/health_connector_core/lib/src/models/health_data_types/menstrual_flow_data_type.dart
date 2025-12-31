part of 'health_data_type.dart';

/// Menstrual flow data type (iOS only).
///
/// Menstrual flow records track the intensity of menstrual flow over a time
/// interval and include metadata about whether the sample marks the start of
/// a menstrual cycle.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported. Use
///   [MenstrualFlowInstantDataType] instead.
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.menstrualFlow`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/menstrualflow)
///
/// ## Capabilities
///
/// - Readable: Query menstrual flow records
/// - Writeable: Write menstrual flow records
/// - Deletable: Delete records by IDs or time range
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.menstrualFlow.readPermission,
///   HealthDataType.menstrualFlow.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.menstrualFlow.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest = HealthDataType.menstrualFlow.deleteByIds([id1, id2]);
/// await connector.deleteRecords(deleteRequest);
///
/// // Delete records in time range
/// final deleteRangeRequest = HealthDataType.menstrualFlow.deleteInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// await connector.deleteRecords(deleteRangeRequest);
/// ```
///
/// ## See also
///
/// - [MenstrualFlowRecord]
/// - [MenstrualFlowInstantDataType] - Android instant-based alternative
/// - [MenstrualFlowType]
///
/// {@category Health Data Types}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class MenstrualFlowDataType
    extends HealthDataType<MenstrualFlowRecord, TimeDuration>
    implements
        ReadableHealthDataType<MenstrualFlowRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<MenstrualFlowRecord> {
  /// Creates a menstrual flow data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const MenstrualFlowDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstrualFlowDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<MenstrualFlowRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<MenstrualFlowRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<MenstrualFlowRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<MenstrualFlowRecord> deleteInTimeRange({
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
