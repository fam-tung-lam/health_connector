part of '../health_data_type.dart';

@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class MineralNutrientDataType<R extends HealthRecord>
    extends NutrientHealthDataType<R, Mass> {
  const MineralNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalciumNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;
}

/// Health data type for calcium intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class CalciumNutrientDataType
    extends MineralNutrientDataType<CalciumNutrientRecord>
    implements
        ReadableHealthDataType<CalciumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<CalciumNutrientRecord, Mass> {
  @internal
  const CalciumNutrientDataType();

  @override
  String get identifier => 'calcium';

  @override
  String get name => identifier;

  @override
  String toString() => 'calcium_health_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<CalciumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<CalciumNutrientRecord> readInTimeRange({
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
  AggregateRequest<CalciumNutrientRecord, Mass> aggregateSum({
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
}

/// Health data type for iron intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class IronNutrientDataType
    extends MineralNutrientDataType<IronNutrientRecord>
    implements
        ReadableHealthDataType<IronNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<IronNutrientRecord, Mass> {
  @internal
  const IronNutrientDataType();

  @override
  String get identifier => 'iron';

  @override
  String get name => identifier;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<IronNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<IronNutrientRecord> readInTimeRange({
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
  AggregateRequest<IronNutrientRecord, Mass> aggregateSum({
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
}

/// Health data type for magnesium intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class MagnesiumNutrientDataType
    extends MineralNutrientDataType<MagnesiumNutrientRecord>
    implements
        ReadableHealthDataType<MagnesiumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<MagnesiumNutrientRecord, Mass> {
  @internal
  const MagnesiumNutrientDataType();

  @override
  String get identifier => 'magnesium';

  @override
  String get name => identifier;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<MagnesiumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<MagnesiumNutrientRecord> readInTimeRange({
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
  AggregateRequest<MagnesiumNutrientRecord, Mass> aggregateSum({
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
}

/// Health data type for manganese intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class ManganeseNutrientDataType
    extends MineralNutrientDataType<ManganeseNutrientRecord>
    implements
        ReadableHealthDataType<ManganeseNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ManganeseNutrientRecord, Mass> {
  @internal
  const ManganeseNutrientDataType();

  @override
  String get identifier => 'manganese';

  @override
  String get name => identifier;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ManganeseNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ManganeseNutrientRecord> readInTimeRange({
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
  AggregateRequest<ManganeseNutrientRecord, Mass> aggregateSum({
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
}

/// Health data type for phosphorus intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PhosphorusNutrientDataType
    extends MineralNutrientDataType<PhosphorusNutrientRecord>
    implements
        ReadableHealthDataType<PhosphorusNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<PhosphorusNutrientRecord, Mass> {
  @internal
  const PhosphorusNutrientDataType();

  @override
  String get identifier => 'phosphorus';

  @override
  String get name => identifier;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<PhosphorusNutrientRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PhosphorusNutrientRecord> readInTimeRange({
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
  AggregateRequest<PhosphorusNutrientRecord, Mass> aggregateSum({
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
}

/// Health data type for potassium intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PotassiumNutrientDataType
    extends MineralNutrientDataType<PotassiumNutrientRecord>
    implements
        ReadableHealthDataType<PotassiumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<PotassiumNutrientRecord, Mass> {
  @internal
  const PotassiumNutrientDataType();

  @override
  String get identifier => 'potassium';

  @override
  String get name => identifier;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<PotassiumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<PotassiumNutrientRecord> readInTimeRange({
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
  AggregateRequest<PotassiumNutrientRecord, Mass> aggregateSum({
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
}

/// Health data type for selenium intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class SeleniumNutrientDataType
    extends MineralNutrientDataType<SeleniumNutrientRecord>
    implements
        ReadableHealthDataType<SeleniumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SeleniumNutrientRecord, Mass> {
  @internal
  const SeleniumNutrientDataType();

  @override
  String get identifier => 'selenium';

  @override
  String get name => identifier;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SeleniumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SeleniumNutrientRecord> readInTimeRange({
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
  AggregateRequest<SeleniumNutrientRecord, Mass> aggregateSum({
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
}

/// Health data type for sodium intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class SodiumNutrientDataType
    extends MineralNutrientDataType<SodiumNutrientRecord>
    implements
        ReadableHealthDataType<SodiumNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SodiumNutrientRecord, Mass> {
  @internal
  const SodiumNutrientDataType();

  @override
  String get identifier => 'sodium';

  @override
  String get name => identifier;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SodiumNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SodiumNutrientRecord> readInTimeRange({
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
  AggregateRequest<SodiumNutrientRecord, Mass> aggregateSum({
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
}

/// Health data type for zinc intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class ZincNutrientDataType
    extends MineralNutrientDataType<ZincNutrientRecord>
    implements
        ReadableHealthDataType<ZincNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ZincNutrientRecord, Mass> {
  @internal
  const ZincNutrientDataType();

  @override
  String get identifier => 'zinc';

  @override
  String get name => identifier;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ZincNutrientRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ZincNutrientRecord> readInTimeRange({
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
  AggregateRequest<ZincNutrientRecord, Mass> aggregateSum({
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
}
