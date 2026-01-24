part of '../health_data_type.dart';

/// Represents the environmental audio exposure event health data type.
///
/// An event that indicates the user was exposed to a sound level that exceeds
/// a specific threshold.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by Apple Watch algorithms and cannot be written by
/// > third-party applications.
///
/// To generate test data in the iOS Simulator:
/// 1. Open the **Health** app.
/// 2. Navigate to **Browse > Hearing > Noise Notifications**.
/// 3. Tap **Add Data**.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**:
///   [`HKCategoryTypeIdentifier.environmentalAudioExposureEvent`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/environmentalaudioexposureevent)
/// - **Android Health Connect**: Not supported
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnAppleHealth
@readOnly
@immutable
final class EnvironmentalAudioExposureEventDataType
    extends HealthDataType<EnvironmentalAudioExposureEventRecord, Number>
    implements
        ReadableByIdHealthDataType<EnvironmentalAudioExposureEventRecord>,
        ReadableInTimeRangeHealthDataType<
          EnvironmentalAudioExposureEventRecord
        > {
  /// Creates an environmental audio exposure event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.environmentalAudioExposureEvent].
  @internal
  const EnvironmentalAudioExposureEventDataType();

  @override
  String get id => 'environmental_audio_exposure_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentalAudioExposureEventDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<EnvironmentalAudioExposureEventRecord>
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  ReadRecordByIdRequest<EnvironmentalAudioExposureEventRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
