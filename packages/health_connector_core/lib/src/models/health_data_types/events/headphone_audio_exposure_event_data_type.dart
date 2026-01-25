part of '../health_data_type.dart';

/// Represents the headphone audio exposure event health data type.
///
/// An event that indicates the user was exposed to potentially damaging
/// sounds from headphones.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by iPhone and Apple Watch when the device generates a
/// > notification about loud headphone audio. Both devices generate these
/// > notifications when the user listens to audio long enough and at a
/// > volume that could affect their hearing.
///
/// To generate test data in the iOS Simulator:
/// 1. Open the **Health** app.
/// 2. Navigate to **Browse > Hearing > Headphone Notifications**.
/// 3. Tap **Add Data**.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**:
///   [`HKCategoryTypeIdentifier.headphoneAudioExposureEvent`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/headphoneaudioexposureevent)
/// - **Android Health Connect**: Not supported
///
/// ## See also
///
/// - [HeadphoneAudioExposureEventRecord]
/// - [EnvironmentalAudioExposureEventDataType]
/// - [EnvironmentalAudioExposureEventRecord]
/// - [EnvironmentalAudioExposureDataType]
/// - [EnvironmentalAudioExposureRecord]
/// - [HeadphoneAudioExposureDataType]
/// - [HeadphoneAudioExposureRecord]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnAppleHealth
@readOnly
@immutable
final class HeadphoneAudioExposureEventDataType
    extends HealthDataType<HeadphoneAudioExposureEventRecord, Number>
    implements
        ReadableByIdHealthDataType<HeadphoneAudioExposureEventRecord>,
        ReadableInTimeRangeHealthDataType<HeadphoneAudioExposureEventRecord> {
  /// Creates a headphone audio exposure event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.headphoneAudioExposureEvent].
  @internal
  const HeadphoneAudioExposureEventDataType();

  @override
  String get id => 'headphone_audio_exposure_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeadphoneAudioExposureEventDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<HeadphoneAudioExposureEventRecord>
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
  ReadRecordByIdRequest<HeadphoneAudioExposureEventRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
