import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV2_0_0;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/requests/read_records_request.dart'
    show ReadRecordsInTimeRangeRequest;
import 'package:health_connector_core/src/models/responses/response.dart'
    show Response;
import 'package:health_connector_core/src/utils/collection.dart';
import 'package:meta/meta.dart' show immutable, internal;

/// Base sealed class for all health records read responses.
@sinceV2_0_0
@internal
@immutable
sealed class ReadRecordsResponse<R extends HealthRecord> extends Response {
  const ReadRecordsResponse();
}

/// Response from reading multiple health records.
///
/// {@category Core API}
@sinceV2_0_0
@immutable
final class ReadRecordsInTimeRangeResponse<R extends HealthRecord>
    extends ReadRecordsResponse {
  /// Creates a read records response.
  const ReadRecordsInTimeRangeResponse({
    required this.records,
    this.nextPageRequest,
  });

  /// The list of health records in this page.
  ///
  /// This list contains records that match the query criteria and fall
  /// within the requested time range.
  ///
  /// If no records match the query, this will be an empty list.
  final List<R> records;

  /// Request for fetching the next page of records.
  ///
  /// If this is null, there are no more records to fetch.
  ///
  /// ## Example
  ///
  /// ```dart
  /// if (response.hasMorePages) {
  ///   final nextPage = await connector.readRecords(response.nextPageRequest!);
  /// }
  /// ```
  final ReadRecordsInTimeRangeRequest<R>? nextPageRequest;

  /// Returns true if there are more pages of records to fetch.
  ///
  /// This is a convenience getter equivalent to `nextPageRequest != null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// while (response.hasMorePages) {
  ///   response = await connector.readRecords(response.nextPageRequest!);
  ///   // Process records...
  /// }
  /// ```
  bool get hasMorePages => nextPageRequest != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadRecordsInTimeRangeResponse<R> &&
          runtimeType == other.runtimeType &&
          records.equals(other.records) &&
          nextPageRequest == other.nextPageRequest;

  @override
  int get hashCode => Object.hash(Object.hashAll(records), nextPageRequest);
}
