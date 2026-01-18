part of 'health_data_type.dart';

/// Lean body mass data type.
///
/// Represents the weight of body tissue excluding fat, including muscle, bone,
/// organs, and water. Used for tracking body composition and fitness progress.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (kilograms, pounds, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`LeanBodyMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/LeanBodyMassRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.leanBodyMass`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/leanbodymass)
///
/// ## Capabilities
///
/// - Readable: Query lean body mass records
/// - Writeable: Write lean body mass records
/// - Deletable: Delete records by IDs or time range
/// - Not aggregatable
///
/// ## See also
///
/// - [LeanBodyMassRecord]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class LeanBodyMassDataType
    extends HealthDataType<LeanBodyMassRecord, Mass>
    implements
        ReadableHealthDataType<LeanBodyMassRecord>,
        ReadableByIdHealthDataType<LeanBodyMassRecord>,
        ReadableInTimeRangeHealthDataType<LeanBodyMassRecord>,
        WriteableHealthDataType<LeanBodyMassRecord>,
        DeletableByIdsHealthDataType<LeanBodyMassRecord>,
        DeletableInTimeRangeHealthDataType<LeanBodyMassRecord> {
  /// Creates a lean body mass data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const LeanBodyMassDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'lean_body_mass';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeanBodyMassDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<LeanBodyMassRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<LeanBodyMassRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.bodyMeasurement;

  @override
  DeleteRecordsByIdsRequest<LeanBodyMassRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<LeanBodyMassRecord> deleteInTimeRange({
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
