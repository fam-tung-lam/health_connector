part of 'health_data_type.dart';

/// Bone mass data type.
///
/// Represents the mass of bone in the user's body.
/// This is a point-in-time measure.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (kilograms, pounds, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BoneMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BoneMassRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Capabilities
///
/// - Readable: Query bone mass records
/// - Writeable: Write bone mass records
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [BoneMassRecord]
///
/// {@category Health Data Types}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class BoneMassDataType extends HealthDataType<BoneMassRecord, Mass>
    implements
        ReadableHealthDataType<BoneMassRecord>,
        WriteableHealthDataType,
        DeletableHealthDataType<BoneMassRecord> {
  /// Creates a bone mass data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  const BoneMassDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BoneMassRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BoneMassRecord> readInTimeRange({
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
  DeleteRecordsByIdsRequest<BoneMassRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<BoneMassRecord> deleteInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return DeleteRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoneMassDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
