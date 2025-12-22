part of 'health_data_type.dart';

/// Body fat percentage data type.
///
/// Represents the percentage of body weight that is fat tissue, used for
/// tracking body composition and fitness progress.
///
/// ## Measurement Unit
///
/// Values are measured as [Percentage] (decimal from 0-1).
/// For example, 0.25 represents 25% body fat.
///
/// ## Platform Mapping
///
/// - **Android (Health Connect)**: `BodyFatRecord`
/// - **iOS (HealthKit)**: `HKQuantityType(.bodyFatPercentage)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query body fat percentage records
/// - ✅ Writeable: Write body fat percentage records
/// - ❌ Not aggregatable
@sinceV1_0_0
@immutable
final class BodyFatPercentageHealthDataType
    extends HealthDataType<BodyFatPercentageRecord, Percentage>
    implements
        ReadableHealthDataType<BodyFatPercentageRecord>,
        WriteableHealthDataType {
  /// Creates a body fat percentage data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
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
