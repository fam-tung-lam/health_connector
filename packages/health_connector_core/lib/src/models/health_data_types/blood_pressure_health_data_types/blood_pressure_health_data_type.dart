part of '../health_data_type.dart';

/// Health data type for composite blood pressure measurements.
///
/// This data type represents a complete blood pressure reading with both
/// systolic and diastolic values.
///
/// For individual systolic or diastolic measurements, see:
/// - [SystolicBloodPressureHealthDataType]
/// - and [DiastolicBloodPressureHealthDataType].
@sinceV1_2_0
@immutable
final class BloodPressureHealthDataType
    extends HealthDataType<BloodPressureRecord, Pressure>
    implements
        ReadableHealthDataType<BloodPressureRecord>,
        WriteableHealthDataType {
  @internal
  const BloodPressureHealthDataType();

  @override
  String get identifier => 'blood_pressure';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'blood_pressure_data_type';

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<BloodPressureRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<BloodPressureRecord> readRecords({
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

  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
