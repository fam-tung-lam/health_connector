part of '../health_data_type.dart';

/// Represents the persistent intermenstrual bleeding event data type.
///
/// This data type captures events where persistent intermenstrual bleeding
/// (spotting) is detected by HealthKit. Persistent spotting is defined as
/// spotting that occurs in at least two cycles in the last six months.
///
/// HealthKit generates Cycle Deviation notifications based on the cycle data
/// a person enters. If HealthKit detects persistent spotting and the person
/// confirms their cycle history is accurate, HealthKit saves this sample.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by HealthKit's cycle tracking algorithms and cannot be
/// > written by third-party applications.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKCategoryTypeIdentifier.persistentIntermenstrualBleeding`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/persistentintermenstrualbleeding)
/// - **Android Health Connect**: Not supported
///
/// ## See also
///
/// - [PersistentIntermenstrualBleedingEventRecord]
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
final class PersistentIntermenstrualBleedingEventDataType
    extends
        HealthDataType<
          PersistentIntermenstrualBleedingEventRecord,
          MeasurementUnit
        >
    implements
        ReadableByIdHealthDataType<PersistentIntermenstrualBleedingEventRecord>,
        ReadableInTimeRangeHealthDataType<
          PersistentIntermenstrualBleedingEventRecord
        > {
  /// Creates a persistent intermenstrual bleeding event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.persistentIntermenstrualBleedingEvent].
  @internal
  const PersistentIntermenstrualBleedingEventDataType();

  @override
  String get id => 'persistent_intermenstrual_bleeding_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersistentIntermenstrualBleedingEventDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<PersistentIntermenstrualBleedingEventRecord>
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
  ReadRecordByIdRequest<PersistentIntermenstrualBleedingEventRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
