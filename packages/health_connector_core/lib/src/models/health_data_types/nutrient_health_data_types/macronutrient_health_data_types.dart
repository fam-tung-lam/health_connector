part of '../health_data_type.dart';

@sinceV1_1_0
@internal
@immutable
sealed class MacronutrientDataType<R extends HealthRecord>
    extends NutrientHealthDataType<R, Mass> {
  const MacronutrientDataType();
}

/// Health data type for protein intake.
@sinceV1_1_0
@immutable
final class ProteinNutrientDataType
    extends MacronutrientDataType<ProteinNutrientRecord>
    implements
        ReadableHealthDataType<ProteinNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ProteinNutrientRecord, Mass> {
  @internal
  const ProteinNutrientDataType();

  @override
  String get identifier => 'protein';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProteinNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'protein_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<ProteinNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<ProteinNutrientRecord> readRecords({
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
  AggregateRequest<ProteinNutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}

/// Health data type for total carbohydrate intake.
@sinceV1_1_0
@immutable
final class TotalCarbohydrateNutrientDataType
    extends MacronutrientDataType<TotalCarbohydrateNutrientRecord>
    implements
        ReadableHealthDataType<TotalCarbohydrateNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<TotalCarbohydrateNutrientRecord, Mass> {
  @internal
  const TotalCarbohydrateNutrientDataType();

  @override
  String get identifier => 'total_carbohydrate';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalCarbohydrateNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'total_carbohydrate_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<TotalCarbohydrateNutrientRecord> readRecord(
    HealthRecordId id,
  ) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<TotalCarbohydrateNutrientRecord> readRecords({
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
  AggregateRequest<TotalCarbohydrateNutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}

/// Health data type for total fat intake.
@sinceV1_1_0
@immutable
final class TotalFatNutrientDataType
    extends MacronutrientDataType<TotalFatNutrientRecord>
    implements
        ReadableHealthDataType<TotalFatNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<TotalFatNutrientRecord, Mass> {
  @internal
  const TotalFatNutrientDataType();

  @override
  String get identifier => 'total_fat';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalFatNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'total_fat_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<TotalFatNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<TotalFatNutrientRecord> readRecords({
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
  AggregateRequest<TotalFatNutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}

/// Health data type for saturated fat intake.
@sinceV1_1_0
@immutable
final class SaturatedFatNutrientDataType
    extends MacronutrientDataType<SaturatedFatNutrientRecord>
    implements
        ReadableHealthDataType<SaturatedFatNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SaturatedFatNutrientRecord, Mass> {
  @internal
  const SaturatedFatNutrientDataType();

  @override
  String get identifier => 'saturated_fat';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaturatedFatNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'saturated_fat_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<SaturatedFatNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<SaturatedFatNutrientRecord> readRecords({
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
  AggregateRequest<SaturatedFatNutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}

/// Health data type for monounsaturated fat intake.
@sinceV1_1_0
@immutable
final class MonounsaturatedFatNutrientDataType
    extends MacronutrientDataType<MonounsaturatedFatNutrientRecord>
    implements
        ReadableHealthDataType<MonounsaturatedFatNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<MonounsaturatedFatNutrientRecord, Mass> {
  @internal
  const MonounsaturatedFatNutrientDataType();

  @override
  String get identifier => 'monounsaturated_fat';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonounsaturatedFatNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'monounsaturated_fat_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<MonounsaturatedFatNutrientRecord> readRecord(
    HealthRecordId id,
  ) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<MonounsaturatedFatNutrientRecord> readRecords({
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
  AggregateRequest<MonounsaturatedFatNutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}

/// Health data type for polyunsaturated fat intake.
@sinceV1_1_0
@immutable
final class PolyunsaturatedFatNutrientDataType
    extends MacronutrientDataType<PolyunsaturatedFatNutrientRecord>
    implements
        ReadableHealthDataType<PolyunsaturatedFatNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<PolyunsaturatedFatNutrientRecord, Mass> {
  @internal
  const PolyunsaturatedFatNutrientDataType();

  @override
  String get identifier => 'polyunsaturated_fat';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PolyunsaturatedFatNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'polyunsaturated_fat_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<PolyunsaturatedFatNutrientRecord> readRecord(
    HealthRecordId id,
  ) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<PolyunsaturatedFatNutrientRecord> readRecords({
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
  AggregateRequest<PolyunsaturatedFatNutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}

/// Health data type for cholesterol intake.
@sinceV1_1_0
@immutable
final class CholesterolNutrientDataType
    extends MacronutrientDataType<CholesterolNutrientRecord>
    implements
        ReadableHealthDataType<CholesterolNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<CholesterolNutrientRecord, Mass> {
  @internal
  const CholesterolNutrientDataType();

  @override
  String get identifier => 'cholesterol';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CholesterolNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'cholesterol_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<CholesterolNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<CholesterolNutrientRecord> readRecords({
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
  AggregateRequest<CholesterolNutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}

/// Health data type for dietary fiber intake.
@sinceV1_1_0
@immutable
final class DietaryFiberNutrientDataType
    extends MacronutrientDataType<DietaryFiberNutrientRecord>
    implements
        ReadableHealthDataType<DietaryFiberNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<DietaryFiberNutrientRecord, Mass> {
  @internal
  const DietaryFiberNutrientDataType();

  @override
  String get identifier => 'dietary_fiber';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryFiberNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'dietary_fiber_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<DietaryFiberNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<DietaryFiberNutrientRecord> readRecords({
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
  AggregateRequest<DietaryFiberNutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}

/// Health data type for sugar intake.
@sinceV1_1_0
@immutable
final class SugarNutrientDataType
    extends MacronutrientDataType<SugarNutrientRecord>
    implements
        ReadableHealthDataType<SugarNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SugarNutrientRecord, Mass> {
  @internal
  const SugarNutrientDataType();

  @override
  String get identifier => 'sugar';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SugarNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'sugar_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<SugarNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<SugarNutrientRecord> readRecords({
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
  AggregateRequest<SugarNutrientRecord, Mass> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
