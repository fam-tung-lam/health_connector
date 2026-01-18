import 'package:collection/collection.dart' show ListEquality;
import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0, sinceV2_0_0, internalUse, sinceV3_0_0;
import 'package:health_connector_core/src/config/health_connector_config_constants.dart'
    show HealthConnectorConfigConstants;
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord, HealthRecordId;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/metadata/metadata.dart'
    show DataOrigin;
import 'package:health_connector_core/src/models/requests/read_requests/sort_descriptor.dart'
    show SortDescriptor;
import 'package:health_connector_core/src/models/requests/request.dart'
    show Request;
import 'package:health_connector_core/src/models/responses/read_records_response.dart'
    show ReadRecordsInTimeRangeResponse;
import 'package:health_connector_core/src/utils/validation_utils.dart'
    show requireEndTimeAfterStartTime, require;
import 'package:meta/meta.dart';

/// Base sealed class for all health records read requests.
///
/// @nodoc
@sinceV2_0_0
@internalUse
@immutable
sealed class ReadRecordsRequest<R extends HealthRecord> extends Request {
  /// Creates a base read records request.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to read.
  const ReadRecordsRequest({required this.dataType});

  /// The type of health data to read.
  final HealthDataType<R, MeasurementUnit> dataType;
}

/// Request to read a single health record by its ID.
///
/// {@category Core API}
@sinceV1_0_0
@internalUse
@immutable
final class ReadRecordByIdRequest<R extends HealthRecord>
    extends ReadRecordsRequest {
  /// Creates a request to read a health record by its ID.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to read.
  /// - [id]: The unique identifier of the record to read.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [id] is [HealthRecordId.none]
  factory ReadRecordByIdRequest({
    required HealthDataType<R, MeasurementUnit> dataType,
    required HealthRecordId id,
  }) {
    require(
      condition: id != HealthRecordId.none,
      value: id,
      name: 'id',
      message: 'Record ID cannot be HealthRecordId.none',
    );

    return ReadRecordByIdRequest._(dataType: dataType, id: id);
  }

  const ReadRecordByIdRequest._({
    required super.dataType,
    required this.id,
  });

  /// The unique identifier of the record to read.
  ///
  /// **⚠️ WARNING**: This ID should come from a previous write or reading
  /// operation. IDs are platform-assigned and should not be manually
  /// created.
  final HealthRecordId id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadRecordByIdRequest<R> &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          id == other.id;

  @override
  int get hashCode => dataType.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'ReadRecordByIdRequest(dataType=$dataType, id=$id)';
  }
}

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
  factory ReadRecordsInTimeRangeRequest({
    required HealthDataType<R, MeasurementUnit> dataType,
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
    String? pageToken,
    List<DataOrigin> dataOrigins = const [],
    @sinceV3_0_0 SortDescriptor sortDescriptor = SortDescriptor.timeDescending,
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

    return ReadRecordsInTimeRangeRequest._(
      dataType: dataType,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
      pageToken: pageToken,
      dataOrigins: dataOrigins,
      sortDescriptor: sortDescriptor,
    );
  }

  const ReadRecordsInTimeRangeRequest._({
    required super.dataType,
    required this.startTime,
    required this.endTime,
    required this.pageSize,
    this.pageToken,
    this.dataOrigins = const [],
    this.sortDescriptor = SortDescriptor.timeAscending,
  });

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
    return ReadRecordsInTimeRangeRequest._(
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
