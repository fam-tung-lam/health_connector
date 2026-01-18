part of '../health_data_type.dart';

/// Cervical mucus data type.
///
/// Cervical mucus records track observations of cervical mucus appearance
/// and sensation, which can be used for fertility tracking.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`CervicalMucusRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/CervicalMucusRecord)
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.cervicalMucusQuality`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/cervicalMucusQuality)
///
/// ## Capabilities
///
/// - Readable: Query cervical mucus records
/// - Writeable: Write cervical mucus records
/// - Deletable: Delete records by IDs or time range
///
/// ## Example
///
/// ```dart
/// // Request permissions
/// final permissions = [
///   HealthDataType.cervicalMucus.readPermission,
///   HealthDataType.cervicalMucus.writePermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request = HealthDataType.cervicalMucus.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// // Delete records by IDs
/// final deleteRequest =
///   HealthDataType.cervicalMucus.deleteByIds([id1, id2]);
/// await connector.deleteRecords(deleteRequest);
///
/// // Delete records in time range
/// final deleteRangeRequest =
///   HealthDataType.cervicalMucus.deleteInTimeRange(
///     startTime: DateTime.now().subtract(Duration(days: 30)),
///     endTime: DateTime.now(),
///   );
/// await connector.deleteRecords(deleteRangeRequest);
/// ```
///
/// ## See also
///
/// - [CervicalMucusRecord]
///
/// {@category Health Records}
@sinceV2_1_0
@immutable
final class CervicalMucusDataType
    extends HealthDataType<CervicalMucusRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<CervicalMucusRecord>,
        ReadableInTimeRangeHealthDataType<CervicalMucusRecord>,
        WriteableHealthDataType<CervicalMucusRecord>,
        DeletableHealthDataType<CervicalMucusRecord> {
  /// Creates a cervical mucus data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const CervicalMucusDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'cervical_mucus';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CervicalMucusDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<CervicalMucusRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CervicalMucusRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<CervicalMucusRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<CervicalMucusRecord> deleteInTimeRange({
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
