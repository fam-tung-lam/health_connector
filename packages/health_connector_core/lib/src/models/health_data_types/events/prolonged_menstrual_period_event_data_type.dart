part of '../health_data_type.dart';

/// Represents the prolonged menstrual period event data type.
///
/// This data type captures events where prolonged menstrual periods are
/// detected by HealthKit. A prolonged period is defined as menstrual bleeding
/// that lasts for ten or more days, and this has happened at least two times
/// in the last six months.
///
/// HealthKit generates Cycle Deviation notifications based on the cycle data
/// a person enters. If HealthKit detects prolonged periods and the person
/// confirms their cycle history is accurate, HealthKit saves this sample.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by HealthKit's cycle tracking algorithms and cannot be
/// > written by third-party applications.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKCategoryTypeIdentifier.prolongedMenstrualPeriods`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/prolongedmenstrualperiods)
/// - **Android Health Connect**: Not supported
///
/// ## See also
///
/// - [ProlongedMenstrualPeriodEventRecord]
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
final class ProlongedMenstrualPeriodEventDataType
    extends HealthDataType<ProlongedMenstrualPeriodEventRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<ProlongedMenstrualPeriodEventRecord>,
        ReadableInTimeRangeHealthDataType<ProlongedMenstrualPeriodEventRecord> {
  /// Creates a prolonged menstrual period event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.prolongedMenstrualPeriodEvent].
  @internal
  const ProlongedMenstrualPeriodEventDataType();

  @override
  String get id => 'prolonged_menstrual_period_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProlongedMenstrualPeriodEventDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<ProlongedMenstrualPeriodEventRecord>
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
  ReadRecordByIdRequest<ProlongedMenstrualPeriodEventRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
