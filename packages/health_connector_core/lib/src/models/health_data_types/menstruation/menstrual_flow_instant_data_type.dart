part of '../health_data_type.dart';

/// Menstrual flow instant data type (Android only).
///
/// Menstrual flow instant records track the intensity of menstrual flow
/// at a specific point in time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`MenstruationFlowRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MenstruationFlowRecord)
/// - **iOS HealthKit**: Not supported. Use [MenstrualFlowDataType] instead.
///
/// ## Capabilities
///
/// - Readable: Query menstrual flow instant records
/// - Writeable: Write menstrual flow instant records
/// - Deletable: Delete records by IDs or time range
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.menstrualFlowInstant.readPermission,
///   HealthDataType.menstrualFlowInstant.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.menstrualFlowInstant.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest =
///     HealthDataType.menstrualFlowInstant.deleteByIds([id1, id2]);
/// await connector.deleteRecords(deleteRequest);
///
/// // Delete records in time range
/// final deleteRangeRequest =
///     HealthDataType.menstrualFlowInstant.deleteInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// await connector.deleteRecords(deleteRangeRequest);
/// ```
///
/// ## See also
///
/// - [MenstrualFlowInstantRecord]
/// - [MenstrualFlowDataType] - iOS interval-based alternative
/// - [MenstrualFlowType]
///
/// {@category Health Data Types}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class MenstrualFlowInstantDataType
    extends HealthDataType<MenstrualFlowInstantRecord, TimeDuration>
    implements
        ReadableHealthDataType<MenstrualFlowInstantRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<MenstrualFlowInstantRecord> {
  /// Creates a menstrual flow instant data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const MenstrualFlowInstantDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstrualFlowInstantDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<MenstrualFlowInstantRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<MenstrualFlowInstantRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<MenstrualFlowInstantRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<MenstrualFlowInstantRecord>
  deleteInTimeRange({
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
