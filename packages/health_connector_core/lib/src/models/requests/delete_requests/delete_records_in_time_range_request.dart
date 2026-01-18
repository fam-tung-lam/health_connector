part of 'delete_records_request.dart';

/// Request to delete all health records within a time range.
///
/// This request type allows deletion of all records of a specific type
/// that fall within the specified time range. This is useful for bulk
/// cleanup operations or removing data from a specific period.
///
/// ## Data Ownership Restriction
///
/// Apps can only delete health records that they created.
/// Attempting to delete records created by other apps, manually entered by
/// users, or system-generated will fail with [AuthorizationException].
///
/// {@category Core API}
@sinceV3_2_0
@internalUse
@immutable
final class DeleteRecordsInTimeRangeRequest extends DeleteRecordsRequest {
  /// Creates a request to delete records within a time range.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to delete
  /// - [startTime]: Inclusive start of the time range
  /// - [endTime]: Inclusive end of the time range
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is before [startTime]
  DeleteRecordsInTimeRangeRequest({
    required super.dataType,
    required this.startTime,
    required this.endTime,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// Inclusive start of the time range.
  ///
  /// Records with timestamps >= this value are included in the deletion.
  final DateTime startTime;

  /// Inclusive end of the time range.
  ///
  /// Records with timestamps <= this value are included in the deletion.
  final DateTime endTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteRecordsInTimeRangeRequest &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          startTime == other.startTime &&
          endTime == other.endTime;

  @override
  int get hashCode => dataType.hashCode ^ startTime.hashCode ^ endTime.hashCode;

  @override
  String toString() {
    return 'DeleteRecordsInTimeRangeRequest('
        'dataType=$dataType, '
        'spanDays=${endTime.difference(startTime).inDays}'
        ')';
  }
}
