part of '../health_data_type.dart';

/// Represents the infrequent menstrual cycle event data type.
///
/// This data type captures events where infrequent menstrual cycles are
/// detected by HealthKit. An infrequent period is defined as having a period
/// one or two times in the last six months.
///
/// HealthKit generates Cycle Deviation notifications based on the cycle data
/// a person enters. If HealthKit detects infrequent periods and the person
/// confirms their cycle history is accurate, HealthKit saves this sample.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by HealthKit's cycle tracking algorithms and cannot be
/// > written by third-party applications.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKCategoryTypeIdentifier.infrequentMenstrualCycles`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/infrequentmenstrualcycles)
/// - **Android Health Connect**: Not supported
///
/// ## See also
///
/// - [InfrequentMenstrualCycleEventRecord]
/// - [MenstrualFlowDataType]
/// - [MenstrualFlowRecord]
/// - [IntermenstrualBleedingDataType]
/// - [IntermenstrualBleedingRecord]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealthIOS16Plus
@readOnly
@immutable
final class InfrequentMenstrualCycleEventDataType
    extends HealthDataType<InfrequentMenstrualCycleEventRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<InfrequentMenstrualCycleEventRecord>,
        ReadableInTimeRangeHealthDataType<InfrequentMenstrualCycleEventRecord> {
  /// Creates an infrequent menstrual cycle event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.infrequentMenstrualCycleEvent].
  @internal
  const InfrequentMenstrualCycleEventDataType();

  @override
  String get id => 'infrequent_menstrual_cycle_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfrequentMenstrualCycleEventDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<InfrequentMenstrualCycleEventRecord>
  readInTimeRange({
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
  List<Permission> get permissions => [readPermission];

  @override
  HealthDataTypeCategory get category =>
      HealthDataTypeCategory.reproductiveHealth;

  @override
  ReadRecordByIdRequest<InfrequentMenstrualCycleEventRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
