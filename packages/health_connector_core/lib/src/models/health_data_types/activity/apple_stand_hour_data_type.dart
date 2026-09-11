part of '../health_data_type.dart';

/// Apple Stand Hour data type.
///
/// Each record indicates whether the user stood and moved for at least one
/// continuous minute during an hour. For wheelchair users, Apple Watch tracks
/// Roll hours using the same HealthKit type.
///
/// > [!NOTE]
/// > This data type is **read-only**. Apple Watch generates these records, and
/// > third-party apps cannot write or delete them.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**:
///   [`HKCategoryTypeIdentifier.appleStandHour`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/applestandhour)
///
/// ## Capabilities
///
/// - Readable by ID and time range
/// - Aggregatable by sum, returning the number of stood or rolled hours
///
/// ## See also
///
/// - [AppleStandHourRecord]
/// - [AppleStandHourStatus]
///
@sinceV3_11_0
@readOnly
@immutable
final class AppleStandHourDataType
    extends HealthDataType<AppleStandHourRecord, Number>
    implements
        ReadableByIdHealthDataType<AppleStandHourRecord>,
        ReadableInTimeRangeHealthDataType<AppleStandHourRecord>,
        SumAggregatableHealthDataType<Number> {
  /// Creates an Apple Stand Hour data type.
  ///
  /// This is a constant constructor used internally. Use
  /// [HealthDataType.appleStandHour] to reference this data type.
  @internal
  const AppleStandHourDataType();

  @override
  List<HealthPlatformRequirement> get healthPlatformRequirements => const [
    AppleHealthRequirement.none,
  ];

  @override
  String get id => 'apple_stand_hour';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<AppleStandHourRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<AppleStandHourRecord> readInTimeRange({
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
  AggregateRequest<Number> aggregateSum({
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
  List<Permission> get permissions => [readPermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppleStandHourDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
