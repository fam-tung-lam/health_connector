part of 'health_data_type.dart';

/// Health data type for lean body mass information.
@sinceV1_0_0
@immutable
final class LeanBodyMassHealthDataType
    extends HealthDataType<LeanBodyMassRecord, Mass>
    implements
        ReadableHealthDataType<LeanBodyMassRecord>,
        WriteableHealthDataType {
  @internal
  const LeanBodyMassHealthDataType();

  @override
  String get identifier => 'lean_body_mass';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeanBodyMassHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'lean_body_mass_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  // ReadableHealthDataType implementation
  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<LeanBodyMassRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<LeanBodyMassRecord> readRecords({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  // WriteableHealthDataType implementation
  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
