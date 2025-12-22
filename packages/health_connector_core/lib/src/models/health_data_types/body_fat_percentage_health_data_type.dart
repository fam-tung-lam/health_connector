part of 'health_data_type.dart';

/// Health data type for body fat percentage information.
///
/// Represents the percentage of body fat as a decimal value (0-1).
/// For example, 0.25 represents 25% body fat.
@sinceV1_0_0
@immutable
final class BodyFatPercentageHealthDataType
    extends HealthDataType<BodyFatPercentageRecord, Percentage>
    implements
        ReadableHealthDataType<BodyFatPercentageRecord>,
        WriteableHealthDataType {
  @internal
  const BodyFatPercentageHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyFatPercentageHealthDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BodyFatPercentageRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BodyFatPercentageRecord> readInTimeRange({
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
