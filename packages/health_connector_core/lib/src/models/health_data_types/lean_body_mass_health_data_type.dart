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
/// - **Android Health Connect**: `LeanBodyMassRecord`
/// - **iOS HealthKit**: `HKQuantityType(.leanBodyMass)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query lean body mass records
/// - ✅ Writeable: Write lean body mass records
/// - ✅ Deletable: Delete records by IDs or time range
/// - ❌ Not aggregatable
///
/// {@category Health Data Types}
@sinceV1_0_0
@immutable
final class LeanBodyMassHealthDataType
    extends HealthDataType<LeanBodyMassRecord, Mass>
    implements
        ReadableHealthDataType<LeanBodyMassRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<LeanBodyMassRecord> {
  /// Creates a lean body mass data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const LeanBodyMassHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeanBodyMassHealthDataType && runtimeType == other.runtimeType;

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
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

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
