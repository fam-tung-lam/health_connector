part of 'read_records_request.dart';

/// Request to read multiple health records within a time range.
///
/// {@category Core API}
@sinceV1_0_0
@internalUse
@immutable
final class ReadRecordsInTimeRangeRequest<R extends HealthRecord>
    extends ReadRecordsRequest {
  /// Creates a request to read health records within a time range.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to read
  /// - [startTime]: Inclusive start of the time range
  /// - [endTime]: Exclusive end of the time range
  /// - [pageSize]: Maximum number of records per page
  /// - [pageToken]: Token for pagination
  /// - [dataOrigins]: List of data origins to filter by
  /// - [sortDescriptor]: Sort order for results (defaults to time descending)
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] before [startTime]
  /// - [ArgumentError] if [pageSize] is not between 1 and
  ///   [HealthConnectorConfigConstants.maxPageSize]
  ReadRecordsInTimeRangeRequest({
    required super.dataType,
    required this.startTime,
    required this.endTime,
    this.pageSize = HealthConnectorConfigConstants.defaultPageSize,
    this.pageToken,
    this.dataOrigins = const [],
    @sinceV3_0_0 this.sortDescriptor = SortDescriptor.timeDescending,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition:
      pageSize > 0 &&
          pageSize <= HealthConnectorConfigConstants.maxPageSize,
      value: pageSize,
      name: 'pageSize',
      message:
      'pageSize must be between 1 and '
          '${HealthConnectorConfigConstants.maxPageSize}. '
          'Got pageSize=$pageSize',
    );
  }

  /// List of data origins to filter by.
  ///
  /// When empty, records from all sources are returned (no filtering).
  /// When non-empty, only records from the specified data origins are returned.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Filter by specific apps
  /// final request = ReadRecordsRequest(
  ///   dataType: HealthDataType.steps,
  ///   startTime: startTime,
  ///   endTime: endTime,
  ///   dataOrigins: [
  ///     DataOrigin.fromPackageName('com.example.fitness'),
  ///     DataOrigin.fromPackageName('com.apple.health'),
  ///   ],
  /// );
  /// ```
  final List<DataOrigin> dataOrigins;

  /// Inclusive start of the time range.
  ///
  /// Records with timestamps >= this value are included.
  final DateTime startTime;

  /// Exclusive end of the time range.
  ///
  /// Records with timestamps < this value are included.
  final DateTime endTime;

  /// Maximum number of records to return per page.
  ///
  /// Must be between 1 and [HealthConnectorConfigConstants.maxPageSize].
  /// Defaults to [HealthConnectorConfigConstants.defaultPageSize].
  final int pageSize;

  /// Opaque pagination token.
  ///
  /// This token is provided by [ReadRecordsInTimeRangeResponse.nextPageRequest]
  /// and should not be manually created. It's used internally by the platform
  /// to fetch the next page of results.
  final String? pageToken;

  /// Descriptor defining how the results should be ordered.
  ///
  /// Defaults to [SortDescriptor.timeDescending] (newest first), which
  /// maintains backward compatibility with the previous implicit behavior.
  ///
  /// ## Performance Note
  ///
  /// Time-based sorting is optimized on all platforms:
  /// - iOS: Native support for both ascending and descending
  /// - Android API 34+: Native support via Health Connect SDK
  /// - Android < API 34: Per-page client-side reversal for descending order
  final SortDescriptor sortDescriptor;

  /// Creates a copy of this request with a new page token.
  ReadRecordsInTimeRangeRequest<R> copyWith({
    String? pageToken,
    SortDescriptor? sortDescriptor,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: dataType,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
      pageToken: pageToken ?? this.pageToken,
      dataOrigins: dataOrigins,
      sortDescriptor: sortDescriptor ?? this.sortDescriptor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ReadRecordsInTimeRangeRequest<R> &&
              runtimeType == other.runtimeType &&
              dataType == other.dataType &&
              startTime == other.startTime &&
              endTime == other.endTime &&
              pageSize == other.pageSize &&
              pageToken == other.pageToken &&
              sortDescriptor == other.sortDescriptor &&
              const ListEquality<DataOrigin>().equals(
                dataOrigins,
                other.dataOrigins,
              );

  @override
  int get hashCode =>
      dataType.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      pageSize.hashCode ^
      (pageToken?.hashCode ?? 0) ^
      sortDescriptor.hashCode ^
      dataOrigins.hashCode;

  @override
  String toString() {
    return 'ReadRecordsInTimeRangeRequest('
        'dataType=$dataType, '
        'dataOriginsCount=${dataOrigins.length}, '
        'hasPageToken=${pageToken != null}, '
        'pageSize=$pageSize, '
        'spanDays=${endTime.difference(startTime).inDays}, '
        'sortDescriptor=$sortDescriptor)';
  }
}
