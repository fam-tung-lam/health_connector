import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/config/health_connector_config_constants.dart'
    show HealthConnectorConfigConstants;
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/metadata/metadata.dart'
    show DataOrigin;
import 'package:health_connector_core/src/models/requests/request.dart'
    show Request;
import 'package:health_connector_core/src/models/responses/read_records_response.dart'
    show ReadRecordsResponse;
import 'package:health_connector_core/src/utils/collection.dart';
import 'package:health_connector_core/src/utils/datetime.dart'
    show formatTimeRange;
import 'package:health_connector_core/src/utils/validation.dart'
    show requireEndTimeAfterStartTime, require;
import 'package:meta/meta.dart' show immutable, internal;

/// Request to read multiple health records within a time range.
@sinceV1_0_0
@immutable
final class ReadRecordsRequest<R extends HealthRecord> extends Request {
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
  ///
  /// ## Throws
  /// - [ArgumentError] if:
  ///   - [endTime] before [startTime]
  ///   - or [pageSize] is not between 1 and
  ///     [HealthConnectorConfigConstants.maxPageSize]
  @internal
  factory ReadRecordsRequest({
    required HealthDataType<R, MeasurementUnit> dataType,
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
    String? pageToken,
    List<DataOrigin> dataOrigins = const [],
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      pageSize > 0 && pageSize <= HealthConnectorConfigConstants.maxPageSize,
      'pageSize must be between 1 and '
      '${HealthConnectorConfigConstants.maxPageSize}. '
      'Got pageSize=$pageSize',
    );

    return ReadRecordsRequest._(
      dataType: dataType,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
      pageToken: pageToken,
      dataOrigins: dataOrigins,
    );
  }

  const ReadRecordsRequest._({
    required this.dataType,
    required this.startTime,
    required this.endTime,
    required this.pageSize,
    this.pageToken,
    this.dataOrigins = const [],
  });

  /// List of data origins to filter by.
  ///
  /// When empty, records from all sources are returned (no filtering).
  /// When non-empty, only records from the specified data origins are returned.
  ///
  /// Example:
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

  /// The type of health data to read.
  ///
  /// This determines which platform API to use and how to deserialize records.
  final HealthDataType<R, MeasurementUnit> dataType;

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
  /// This token is provided by [ReadRecordsResponse.nextPageRequest] and
  /// should not be manually created. It's used internally by the platform
  /// to fetch the next page of results.
  final String? pageToken;

  /// Creates a copy of this request with a new page token.
  ReadRecordsRequest<R> copyWith({String? pageToken}) {
    return ReadRecordsRequest._(
      dataType: dataType,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
      pageToken: pageToken ?? this.pageToken,
      dataOrigins: dataOrigins,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadRecordsRequest<R> &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          pageSize == other.pageSize &&
          pageToken == other.pageToken &&
          dataOrigins.equals(other.dataOrigins);

  @override
  int get hashCode =>
      dataType.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      pageSize.hashCode ^
      (pageToken?.hashCode ?? 0) ^
      dataOrigins.hashCode;

  @override
  String toString() =>
      'ReadRecordsRequest('
      'dataType: $dataType, '
      'time_range: ${formatTimeRange(startTime: startTime, endTime: endTime)}, '
      'pageSize: $pageSize, '
      'pageToken: ${pageToken ?? "none"}, '
      'dataOrigins: $dataOrigins'
      ')';
}
