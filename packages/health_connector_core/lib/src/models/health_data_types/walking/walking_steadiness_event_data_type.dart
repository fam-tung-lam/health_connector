part of '../health_data_type.dart';

/// Walking Steadiness Event data type.
///
/// A health data type that records an incident where the user showed a reduced
/// score for their gait’s steadiness.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are calculated by
/// > Apple's internal algorithms and cannot be written or deleted by
/// > third-party apps.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKCategoryTypeIdentifier.appleWalkingSteadinessEvent`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/applewalkingsteadinessevent)
///
/// ## Example
///
/// ```dart
/// // Request read permission
/// final permissions = [
///   HealthDataType.walkingSteadinessEvent.readPermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request =
///     HealthDataType.walkingSteadinessEvent.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 30)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Walking steadiness event: ${record.type}');
/// }
/// ```
///
/// ## See also
///
/// - [WalkingSteadinessEventRecord]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealth
@readOnly
@immutable
final class WalkingSteadinessEventDataType
    extends HealthDataType<WalkingSteadinessEventRecord, MeasurementUnit>
    implements
        ReadableByIdHealthDataType<WalkingSteadinessEventRecord>,
        ReadableInTimeRangeHealthDataType<WalkingSteadinessEventRecord> {
  /// Creates a Walking Steadiness Event data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance [HealthDataType.walkingSteadinessEvent].
  @internal
  const WalkingSteadinessEventDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'walking_steadiness_event';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingSteadinessEventDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<WalkingSteadinessEventRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WalkingSteadinessEventRecord> readInTimeRange({
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
  HealthDataTypeCategory get category => HealthDataTypeCategory.mobility;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => const [];
}
