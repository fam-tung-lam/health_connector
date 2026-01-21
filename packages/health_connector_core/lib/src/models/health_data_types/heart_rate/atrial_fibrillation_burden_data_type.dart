part of '../health_data_type.dart';

/// Atrial Fibrillation Burden data type.
///
/// Use this identifier to access the user’s history of AFib Burden samples.
///
/// On watchOS 9 and iOS 16 and later, once a person enables AFib History, Apple
/// Watch begins collecting heart-rhythm data more frequently. iPhone then
/// calculates the AFib burden once a week, as long as Apple Watch has gathered
/// enough heart-rhythm data during that week.
///
/// The sample’s value represents an estimate of the percentage of time a
/// person’s heart shows signs of AFib while wearing Apple Watch.
///
/// > [!NOTE]
/// > This data type is **read-only**. Records of this type are calculated by
/// > Apple's internal algorithms and cannot be written or deleted by
/// > third-party apps.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.atrialFibrillationBurden`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/atrialfibrillationburden)
///
/// ## Example
///
/// ```dart
/// // Request read permission
/// final permissions = [
///   HealthDataType.atrialFibrillationBurden.readPermission,
/// ];
/// await connector.requestPermissions(permissions);
///
/// // Read records
/// final request =
///     HealthDataType.atrialFibrillationBurden.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('AFib Burden: ${record.percentage.asWhole}%');
/// }
///
/// // Aggregate average AFib Burden
/// final aggRequest =
///     HealthDataType.atrialFibrillationBurden.aggregateAvg(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final aggResponse = await connector.aggregate(aggRequest);
/// print('Average AFib Burden: ${aggResponse.value?.asWhole}%');
/// ```
///
/// ## See also
///
/// - [AtrialFibrillationBurdenRecord]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealthIOS16Plus
@readOnly
@immutable
final class AtrialFibrillationBurdenDataType
    extends HealthDataType<AtrialFibrillationBurdenRecord, Percentage>
    implements
        ReadableByIdHealthDataType<AtrialFibrillationBurdenRecord>,
        ReadableInTimeRangeHealthDataType<AtrialFibrillationBurdenRecord>,
        MinAggregatableHealthDataType<Percentage>,
        MaxAggregatableHealthDataType<Percentage>,
        AvgAggregatableHealthDataType<Percentage> {
  /// Creates an Atrial Fibrillation Burden data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the [HealthDataType.atrialFibrillationBurden].
  @internal
  const AtrialFibrillationBurdenDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  String get id => 'atrial_fibrillation_burden';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AtrialFibrillationBurdenDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<AtrialFibrillationBurdenRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<AtrialFibrillationBurdenRecord>
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
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.min,
    AggregationMetric.max,
    AggregationMetric.avg,
  ];

  @override
  AggregateRequest<Percentage> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Percentage> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<Percentage> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
