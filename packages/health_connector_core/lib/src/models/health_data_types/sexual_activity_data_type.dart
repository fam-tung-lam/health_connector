part of 'health_data_type.dart';

/// Sexual activity data type.
///
/// Sexual activity records track occurrences of sexual activity with optional
/// information about whether protection was used.
///
/// ## Measurement Unit
///
/// Duration is measured in [TimeDuration] (seconds, minutes, hours).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`SexualActivityRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SexualActivityRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.sexualActivity`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/sexualactivity)
///
/// ## Capabilities
///
/// - Readable: Query sexual activity records
/// - Writeable: Write sexual activity records
/// - Deletable: Delete records by IDs or time range
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.sexualActivity.readPermission,
///   HealthDataType.sexualActivity.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.sexualActivity.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest = HealthDataType.sexualActivity.deleteByIds([id1, id2]);
/// await connector.deleteRecords(deleteRequest);
///
/// // Delete records in time range
/// final deleteRangeRequest = HealthDataType.sexualActivity.deleteInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// await connector.deleteRecords(deleteRangeRequest);
/// ```
///
/// ## See also
///
/// - [SexualActivityRecord]
///
/// {@category Health Data Types}
@sinceV2_1_0
@immutable
final class SexualActivityDataType
    extends HealthDataType<SexualActivityRecord, TimeDuration>
    implements
        ReadableHealthDataType<SexualActivityRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<SexualActivityRecord> {
  /// Creates a sexual activity data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SexualActivityDataType();

  @override
  String get id => 'sexual_activity';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SexualActivityDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SexualActivityRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SexualActivityRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<SexualActivityRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<SexualActivityRecord> deleteInTimeRange({
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
