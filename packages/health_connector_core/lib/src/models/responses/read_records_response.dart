import 'package:collection/collection.dart' show ListEquality;
import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV2_0_0, internalUse;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/requests/read_records_request.dart'
    show ReadRecordsInTimeRangeRequest;
import 'package:health_connector_core/src/models/responses/response.dart';
import 'package:meta/meta.dart';

/// Base sealed class for all health records read responses.
///
/// @nodoc
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
@internalUse
@immutable
final class ReadRecordsInTimeRangeResponse<R extends HealthRecord>
    extends ReadRecordsResponse {
  /// Creates a read records response.
  ///
  /// ## Parameters
  ///
  /// - [records]: The list of health records in this page.
  /// - [nextPageRequest]: Request for fetching the next page of records.
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
  /// if (response.nextPageRequest != null) {
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
          const ListEquality<HealthRecord>().equals(
            records,
            other.records,
          ) &&
          nextPageRequest == other.nextPageRequest;

  @override
  int get hashCode => Object.hash(Object.hashAll(records), nextPageRequest);

  @override
  String toString() =>
      'ReadRecordsInTimeRangeResponse('
      'recordsCount=${records.length}, '
      'hasNextPage=${nextPageRequest != null}'
      ')';
}
