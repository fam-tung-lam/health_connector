part of '../health_data_type.dart';

/// Intermenstrual bleeding data type.
///
/// Intermenstrual bleeding records track occurrences of vaginal bleeding
/// between menstrual periods (spotting).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`IntermenstrualBleedingRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/IntermenstrualBleedingRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.intermenstrualBleeding`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/intermenstrualbleeding)
///
/// ## Capabilities
///
/// - Readable: Query intermenstrual bleeding records
/// - Writeable: Write intermenstrual bleeding records
/// - Deletable: Delete records by IDs or time range
/// - Aggregation: Not supported (categorical data)
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.intermenstrualBleeding.readPermission,
///   HealthDataType.intermenstrualBleeding.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.intermenstrualBleeding.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest =
///     HealthDataType.intermenstrualBleeding.deleteByIds([id1, id2]);
/// await connector.deleteRecords(deleteRequest);
///
/// // Delete records in time range
/// final deleteRangeRequest =
///     HealthDataType.intermenstrualBleeding.deleteInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// await connector.deleteRecords(deleteRangeRequest);
/// ```
///
/// ## See also
///
/// - [IntermenstrualBleedingRecord]
///
/// {@category Health Data Types}
@sinceV2_2_0
@immutable
final class IntermenstrualBleedingDataType
    extends HealthDataType<IntermenstrualBleedingRecord, TimeDuration>
    implements
        ReadableHealthDataType<IntermenstrualBleedingRecord>,
        WriteableHealthDataType<IntermenstrualBleedingRecord>,
        DeletableHealthDataType<IntermenstrualBleedingRecord> {
  /// Creates an intermenstrual bleeding data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const IntermenstrualBleedingDataType();

  @override
  String get id => 'intermenstrual_bleeding';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntermenstrualBleedingDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<IntermenstrualBleedingRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<IntermenstrualBleedingRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<IntermenstrualBleedingRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<IntermenstrualBleedingRecord>
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
