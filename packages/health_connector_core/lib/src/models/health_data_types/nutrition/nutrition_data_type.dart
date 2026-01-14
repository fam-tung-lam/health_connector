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
/// - **Android Health Connect**: [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
/// - **iOS HealthKit**: [`HKCorrelationTypeIdentifier.food`](https://developer.apple.com/documentation/healthkit/hkcorrelationtypeidentifier/food) or individual nutrient
/// types
///
/// ## Capabilities
///
/// - Readable: Query nutrition records
/// - Writeable: Write nutrition records
/// - Not aggregatable (use individual data types for aggregation)
///
/// {@category Health Records}
@sinceV1_1_0
@immutable
final class NutritionDataType
    extends HealthDataType<NutritionRecord, MeasurementUnit>
    implements
        ReadableHealthDataType<NutritionRecord>,
        WriteableHealthDataType<NutritionRecord> {
  /// Creates a nutrition data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const NutritionDataType();

  @override
  String get id => 'nutrition';

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.nutrition;

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
