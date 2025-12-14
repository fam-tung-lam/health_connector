part of '../health_data_type.dart';

@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class VitaminNutrientDataType<R extends HealthRecord>
    extends NutrientHealthDataType<R, Mass> {
  const VitaminNutrientDataType();
}

/// Health data type for vitamin a intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminANutrientDataType
    extends VitaminNutrientDataType<VitaminANutrientRecord>
    implements
        ReadableHealthDataType<VitaminANutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminANutrientRecord, Mass> {
  @internal
  const VitaminANutrientDataType();

  @override
  String get identifier => 'vitamin_a';

  @override
  String get name => identifier;

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
  ReadRecordRequest<VitaminANutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<VitaminANutrientRecord> readRecords({
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
  AggregateRequest<VitaminANutrientRecord, Mass> aggregateSum({
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

/// Health data type for vitamin b6 intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminB6NutrientDataType
    extends VitaminNutrientDataType<VitaminB6NutrientRecord>
    implements
        ReadableHealthDataType<VitaminB6NutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminB6NutrientRecord, Mass> {
  @internal
  const VitaminB6NutrientDataType();

  @override
  String get identifier => 'vitamin_b6';

  @override
  String get name => identifier;

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
  ReadRecordRequest<VitaminB6NutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<VitaminB6NutrientRecord> readRecords({
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
  AggregateRequest<VitaminB6NutrientRecord, Mass> aggregateSum({
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

/// Health data type for vitamin b12 intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminB12NutrientDataType
    extends VitaminNutrientDataType<VitaminB12NutrientRecord>
    implements
        ReadableHealthDataType<VitaminB12NutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminB12NutrientRecord, Mass> {
  @internal
  const VitaminB12NutrientDataType();

  @override
  String get identifier => 'vitamin_b12';

  @override
  String get name => identifier;

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
  ReadRecordRequest<VitaminB12NutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<VitaminB12NutrientRecord> readRecords({
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
  AggregateRequest<VitaminB12NutrientRecord, Mass> aggregateSum({
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

/// Health data type for vitamin c intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminCNutrientDataType
    extends VitaminNutrientDataType<VitaminCNutrientRecord>
    implements
        ReadableHealthDataType<VitaminCNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminCNutrientRecord, Mass> {
  @internal
  const VitaminCNutrientDataType();

  @override
  String get identifier => 'vitamin_c';

  @override
  String get name => identifier;

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
  ReadRecordRequest<VitaminCNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<VitaminCNutrientRecord> readRecords({
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
  AggregateRequest<VitaminCNutrientRecord, Mass> aggregateSum({
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

/// Health data type for vitamin d intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminDNutrientDataType
    extends VitaminNutrientDataType<VitaminDNutrientRecord>
    implements
        ReadableHealthDataType<VitaminDNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminDNutrientRecord, Mass> {
  @internal
  const VitaminDNutrientDataType();

  @override
  String get identifier => 'vitamin_d';

  @override
  String get name => identifier;

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
  ReadRecordRequest<VitaminDNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<VitaminDNutrientRecord> readRecords({
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
  AggregateRequest<VitaminDNutrientRecord, Mass> aggregateSum({
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

/// Health data type for vitamin e intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminENutrientDataType
    extends VitaminNutrientDataType<VitaminENutrientRecord>
    implements
        ReadableHealthDataType<VitaminENutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminENutrientRecord, Mass> {
  @internal
  const VitaminENutrientDataType();

  @override
  String get identifier => 'vitamin_e';

  @override
  String get name => identifier;

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
  ReadRecordRequest<VitaminENutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<VitaminENutrientRecord> readRecords({
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
  AggregateRequest<VitaminENutrientRecord, Mass> aggregateSum({
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

/// Health data type for vitamin k intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminKNutrientDataType
    extends VitaminNutrientDataType<VitaminKNutrientRecord>
    implements
        ReadableHealthDataType<VitaminKNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<VitaminKNutrientRecord, Mass> {
  @internal
  const VitaminKNutrientDataType();

  @override
  String get identifier => 'vitamin_k';

  @override
  String get name => identifier;

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
  ReadRecordRequest<VitaminKNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<VitaminKNutrientRecord> readRecords({
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
  AggregateRequest<VitaminKNutrientRecord, Mass> aggregateSum({
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

/// Health data type for thiamin intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class ThiaminNutrientDataType
    extends VitaminNutrientDataType<ThiaminNutrientRecord>
    implements
        ReadableHealthDataType<ThiaminNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ThiaminNutrientRecord, Mass> {
  @internal
  const ThiaminNutrientDataType();

  @override
  String get identifier => 'thiamin';

  @override
  String get name => identifier;

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
  ReadRecordRequest<ThiaminNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<ThiaminNutrientRecord> readRecords({
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
  AggregateRequest<ThiaminNutrientRecord, Mass> aggregateSum({
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

/// Health data type for riboflavin intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class RiboflavinNutrientDataType
    extends VitaminNutrientDataType<RiboflavinNutrientRecord>
    implements
        ReadableHealthDataType<RiboflavinNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<RiboflavinNutrientRecord, Mass> {
  @internal
  const RiboflavinNutrientDataType();

  @override
  String get identifier => 'riboflavin';

  @override
  String get name => identifier;

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
  ReadRecordRequest<RiboflavinNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<RiboflavinNutrientRecord> readRecords({
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
  AggregateRequest<RiboflavinNutrientRecord, Mass> aggregateSum({
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

/// Health data type for niacin intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class NiacinNutrientDataType
    extends VitaminNutrientDataType<NiacinNutrientRecord>
    implements
        ReadableHealthDataType<NiacinNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<NiacinNutrientRecord, Mass> {
  @internal
  const NiacinNutrientDataType();

  @override
  String get identifier => 'niacin';

  @override
  String get name => identifier;

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
  ReadRecordRequest<NiacinNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<NiacinNutrientRecord> readRecords({
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
  AggregateRequest<NiacinNutrientRecord, Mass> aggregateSum({
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

/// Health data type for folate intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class FolateNutrientDataType
    extends VitaminNutrientDataType<FolateNutrientRecord>
    implements
        ReadableHealthDataType<FolateNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<FolateNutrientRecord, Mass> {
  @internal
  const FolateNutrientDataType();

  @override
  String get identifier => 'folate';

  @override
  String get name => identifier;

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
  ReadRecordRequest<FolateNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<FolateNutrientRecord> readRecords({
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
  AggregateRequest<FolateNutrientRecord, Mass> aggregateSum({
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

/// Health data type for biotin intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class BiotinNutrientDataType
    extends VitaminNutrientDataType<BiotinNutrientRecord>
    implements
        ReadableHealthDataType<BiotinNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<BiotinNutrientRecord, Mass> {
  @internal
  const BiotinNutrientDataType();

  @override
  String get identifier => 'biotin';

  @override
  String get name => identifier;

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
  ReadRecordRequest<BiotinNutrientRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<BiotinNutrientRecord> readRecords({
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
  AggregateRequest<BiotinNutrientRecord, Mass> aggregateSum({
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

/// Health data type for pantothenic acid intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PantothenicAcidNutrientDataType
    extends VitaminNutrientDataType<PantothenicAcidNutrientRecord>
    implements
        ReadableHealthDataType<PantothenicAcidNutrientRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<PantothenicAcidNutrientRecord, Mass> {
  @internal
  const PantothenicAcidNutrientDataType();

  @override
  String get identifier => 'pantothenic_acid';

  @override
  String get name => identifier;

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
  ReadRecordRequest<PantothenicAcidNutrientRecord> readRecord(
    HealthRecordId id,
  ) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<PantothenicAcidNutrientRecord> readRecords({
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
  AggregateRequest<PantothenicAcidNutrientRecord, Mass> aggregateSum({
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
