part of '../health_data_type.dart';

/// Represents the low heart rate event data type.
///
/// This data type captures events where low heart rate is detected.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated automatically
/// > by Apple Watch algorithms and cannot be written by third-party applications.
///
/// To generate test data in the iOS Simulator:
/// 1. Open the **Health** app.
/// 2. Navigate to **Browse > Heart > Low Heart Rate Notifications**.
/// 3. Tap **Add Data**.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKCategoryTypeIdentifier.lowHeartRateEvent`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/lowheartrateevent)
/// - **Android Health Connect**: Not supported
///
/// ## See also
///
/// - [LowHeartRateEventRecord]
/// - [HighHeartRateEventDataType]
/// - [HighHeartRateEventRecord]
/// - [IrregularHeartRhythmEventDataType]
/// - [IrregularHeartRhythmEventRecord]
///
/// {@category Health Records}
@sinceV3_3_0
@supportedOnAppleHealth
@readOnly
@immutable
final class LowHeartRateEventDataType
    extends HealthDataType<LowHeartRateEventRecord, Frequency>
    implements
        ReadableByIdHealthDataType<LowHeartRateEventRecord>,
        ReadableInTimeRangeHealthDataType<LowHeartRateEventRecord> {
  /// Creates a low heart rate event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.lowHeartRateEvent].
  @internal
  const LowHeartRateEventDataType();

  @override
  String get id => 'low_heart_rate_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LowHeartRateEventDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<LowHeartRateEventRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  ReadRecordByIdRequest<LowHeartRateEventRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
