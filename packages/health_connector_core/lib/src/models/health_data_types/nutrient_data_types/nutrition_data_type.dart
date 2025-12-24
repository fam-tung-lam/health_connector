part of '../health_data_type.dart';

/// Health data type for nutrition records.
/// Nutrition data type.
///
/// Represents comprehensive nutrition information for meals and food items.
/// Tracks macronutrients, vitamins, minerals, and other nutritional values.
///
/// ## Measurement Unit
///
/// Contains multiple measurements across different units (Mass, Energy, etc.).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `NutritionRecord`
/// - **iOS HealthKit**: `HKCorrelationType(.food)` or individual nutrient
/// types
///
/// ## Capabilities
///
/// - ✅ Readable: Query nutrition records
/// - ✅ Writeable: Write nutrition records
/// - ❌ Not aggregatable (use individual nutrient data types for aggregation)
///
/// {@category Health Data Types}
@sinceV1_1_0
@immutable
final class NutritionHealthDataType
    extends HealthDataType<NutritionRecord, MeasurementUnit>
    implements
        ReadableHealthDataType<NutritionRecord>,
        WriteableHealthDataType {
  /// Creates a nutrition data type.
  ///
  ///This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const NutritionHealthDataType();

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  ReadRecordByIdRequest<NutritionRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<NutritionRecord> readInTimeRange({
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
}
