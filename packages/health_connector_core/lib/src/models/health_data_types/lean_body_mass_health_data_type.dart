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
}
