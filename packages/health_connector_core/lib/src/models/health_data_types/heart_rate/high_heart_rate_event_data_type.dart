part of '../health_data_type.dart';

/// Represents the high heart rate event data type.
///
/// This data type captures events where high heart rate is detected.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by Apple Watch algorithms and cannot be written by
/// > third-party applications.
///
/// To generate test data in the iOS Simulator:
/// 1. Open the **Health** app.
/// 2. Navigate to **Browse > Heart > High Heart Rate Notifications**.
/// 3. Tap **Add Data**.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKCategoryTypeIdentifier.highHeartRateEvent`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/highheartrateevent/)
/// - **Android Health Connect**: Not supported
///
/// ## See also
///
/// - [HighHeartRateEventRecord]
/// - [LowHeartRateEventDataType]
/// - [LowHeartRateEventRecord]
/// - [IrregularHeartRhythmEventDataType]
/// - [IrregularHeartRhythmEventRecord]
///
/// {@category Health Records}
@sinceV3_3_0
@supportedOnAppleHealth
@readOnly
@immutable
final class HighHeartRateEventDataType
    extends HealthDataType<HighHeartRateEventRecord, Frequency>
    implements
        ReadableByIdHealthDataType<HighHeartRateEventRecord>,
        ReadableInTimeRangeHealthDataType<HighHeartRateEventRecord> {
  /// Creates a high heart rate event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.highHeartRateEvent].
  @internal
  const HighHeartRateEventDataType();

  @override
  String get id => 'high_heart_rate_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HighHeartRateEventDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<HighHeartRateEventRecord> readInTimeRange({
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
  ReadRecordByIdRequest<HighHeartRateEventRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
