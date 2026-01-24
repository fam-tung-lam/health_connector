part of '../health_data_type.dart';

/// Represents the low cardio fitness event health data type.
///
/// An event that indicates the user’s VO2 max values consistently fall below a
/// particular aerobic fitness threshold.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are generated
/// > automatically by Apple Watch algorithms and cannot be written by
/// > third-party applications.
///
/// To generate test data in the iOS Simulator:
/// 1. Open the **Health** app.
/// 2. Navigate to **Browse**.
/// 3. Search for **Cardio Fitness Notifications**.
/// 4. Tap **Add Data**.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**:
///   [`HKCategoryTypeIdentifier.lowCardioFitnessEvent`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/lowcardiofitnessevent)
/// - **Android Health Connect**: Not supported
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnAppleHealth
@readOnly
@immutable
final class LowCardioFitnessEventDataType
    extends HealthDataType<LowCardioFitnessEventRecord, Number>
    implements
        ReadableByIdHealthDataType<LowCardioFitnessEventRecord>,
        ReadableInTimeRangeHealthDataType<LowCardioFitnessEventRecord> {
  /// Creates a low cardio fitness event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use [HealthDataType.lowCardioFitnessEvent].
  @internal
  const LowCardioFitnessEventDataType();

  @override
  String get id => 'low_cardio_fitness_event';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LowCardioFitnessEventDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordsInTimeRangeRequest<LowCardioFitnessEventRecord> readInTimeRange({
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
  ReadRecordByIdRequest<LowCardioFitnessEventRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }
}
