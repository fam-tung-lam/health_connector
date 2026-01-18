part of '../health_data_type.dart';

/// Caffeine data type.
///
/// Tracks dietary caffeine intake, a stimulant compound affecting the central
/// nervous system, found in coffee and tea.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (milligrams typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryCaffeine`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycaffeine)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query caffeine intake records
/// - Writeable: Write caffeine intake records
/// - Aggregatable: Sum total caffeine intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryCaffeineRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryCaffeineDataType
    extends NutrientDataType<DietaryCaffeineRecord, Mass>
    implements
        ReadableByIdHealthDataType<DietaryCaffeineRecord>,
        ReadableInTimeRangeHealthDataType<DietaryCaffeineRecord>,
        WriteableHealthDataType<DietaryCaffeineRecord>,
        SumAggregatableHealthDataType<DietaryCaffeineRecord, Mass>,
        DeletableByIdsHealthDataType<DietaryCaffeineRecord>,
        DeletableInTimeRangeHealthDataType<DietaryCaffeineRecord> {
  /// Creates a caffeine data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryCaffeineDataType();

  @override
  String get id => 'dietary_caffeine';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryCaffeineDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryCaffeineRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryCaffeineRecord> readInTimeRange({
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
  AggregateRequest<DietaryCaffeineRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.nutrition;

  @override
  DeleteRecordsByIdsRequest<DietaryCaffeineRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<DietaryCaffeineRecord> deleteInTimeRange({
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
