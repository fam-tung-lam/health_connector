part of '../health_data_type.dart';

/// Represents the irregular heart rhythm event data type.
///
/// This data type captures events where an irregular heart rhythm is detected,
/// such as atrial fibrillation (AFib).
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by Apple Watch algorithms and cannot be written by
/// > third-party applications.
///
/// To generate test data in the iOS Simulator:
/// 1. Open the **Health** app.
/// 2. Navigate to **Browse > Heart > Irregular Rhythm Notifications**.
/// 3. Tap **Add Data**.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKCategoryTypeIdentifier.irregularHeartRhythmEvent`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/irregularheartrhythmevent)
/// - **Android Health Connect**: Not supported
///
/// ## See also
///
/// - [IrregularHeartRhythmEventRecord]
/// - [LowHeartRateEventDataType]
/// - [LowHeartRateEventRecord]
/// - [HighHeartRateEventDataType]
/// - [HighHeartRateEventRecord]
///
/// {@category Health Records}
@sinceV3_3_0
@supportedOnAppleHealth
@readOnly
@immutable
final class IrregularHeartRhythmEventDataType
    extends HealthDataType<IrregularHeartRhythmEventRecord, Frequency>
    implements
        ReadableByIdHealthDataType<IrregularHeartRhythmEventRecord>,
        ReadableInTimeRangeHealthDataType<IrregularHeartRhythmEventRecord> {
  /// Creates an irregular heart rhythm event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.irregularHeartRhythmEvent].
  @internal
  const IrregularHeartRhythmEventDataType();

  @override
  String get id => 'irregular_heart_rhythm_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IrregularHeartRhythmEventDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<IrregularHeartRhythmEventRecord>
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.vitals;

  @override
  ReadRecordByIdRequest<IrregularHeartRhythmEventRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
