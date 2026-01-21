part of '../health_data_type.dart';

/// Represents the irregular menstrual cycle event data type.
///
/// This data type captures events where irregular menstrual cycles are
/// detected by HealthKit. An irregular cycle is defined as at least a
/// seventeen-day difference between a person’s shortest and longest cycles
/// over the last six months.
///
/// HealthKit generates Cycle Deviation notifications based on the cycle data
/// a person enters. If HealthKit detects irregular cycles and the person
/// confirms their cycle history is accurate, HealthKit saves this sample.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by HealthKit's cycle tracking algorithms and cannot be
/// > written by third-party applications.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKCategoryTypeIdentifier.irregularMenstrualCycles`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/irregularmenstrualcycles)
/// - **Android Health Connect**: Not supported
///
/// ## See also
///
/// - [IrregularMenstrualCycleEventRecord]
/// - [InfrequentMenstrualCycleEventDataType]
/// - [InfrequentMenstrualCycleEventRecord]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealthIOS16Plus
@readOnly
@immutable
final class IrregularMenstrualCycleEventDataType
    extends HealthDataType<IrregularMenstrualCycleEventRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<IrregularMenstrualCycleEventRecord>,
        ReadableInTimeRangeHealthDataType<IrregularMenstrualCycleEventRecord> {
  /// Creates an irregular menstrual cycle event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.irregularMenstrualCycleEvent].
  @internal
  const IrregularMenstrualCycleEventDataType();

  @override
  String get id => 'irregular_menstrual_cycle_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IrregularMenstrualCycleEventDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<IrregularMenstrualCycleEventRecord>
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
  ReadRecordByIdRequest<IrregularMenstrualCycleEventRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
