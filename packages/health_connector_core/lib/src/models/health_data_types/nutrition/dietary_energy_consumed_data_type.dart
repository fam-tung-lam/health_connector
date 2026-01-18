part of '../health_data_type.dart';

/// Energy data type.
///
/// Tracks dietary energy intake, a total caloric intake from all
/// macronutrient sources.
///
/// ## Measurement Unit
///
/// Values are measured in [Mass] units (kilocalories typically).
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryEnergyConsumed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryenergyconsumed)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Capabilities
///
/// - Readable: Query energy intake records
/// - Writeable: Write energy intake records
/// - Aggregatable: Sum total energy intake
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [DietaryEnergyConsumedRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryEnergyConsumedDataType
    extends NutrientDataType<DietaryEnergyConsumedRecord, Energy>
    implements
        ReadableByIdHealthDataType<DietaryEnergyConsumedRecord>,
        ReadableInTimeRangeHealthDataType<DietaryEnergyConsumedRecord>,
        WriteableHealthDataType<DietaryEnergyConsumedRecord>,
        SumAggregatableHealthDataType<Energy>,
        DeletableByIdsHealthDataType<DietaryEnergyConsumedRecord>,
        DeletableInTimeRangeHealthDataType<DietaryEnergyConsumedRecord> {
  /// Creates a energy data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const DietaryEnergyConsumedDataType();

  @override
  String get id => 'dietary_energy_consumed';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryEnergyConsumedDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DietaryEnergyConsumedRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DietaryEnergyConsumedRecord> readInTimeRange({
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
  AggregateRequest<Energy> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
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
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest deleteInTimeRange({
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
