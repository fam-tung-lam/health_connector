import 'package:collection/collection.dart' show ListEquality;
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/requests/request.dart'
    show Request;
import 'package:health_connector_core/src/utils/validation.dart'
    show require, requireEndTimeAfterStartTime;
import 'package:meta/meta.dart' show immutable;

/// Base sealed class for all delete records requests.
@sinceV2_0_0
@internalUse
sealed class DeleteRecordsRequest<R extends HealthRecord> extends Request {
  /// Creates a base delete records request.
  const DeleteRecordsRequest({required this.dataType});

  /// The type of health data to delete.
  final HealthDataType<R, MeasurementUnit> dataType;
}

/// Request to delete specific health records by their IDs.
///
/// This request type allows precise deletion of individual records when
/// you have their unique identifiers.
///
/// ## Data Ownership Restriction
///
/// Apps can only delete health records that they created.
/// Attempting to delete records created by other apps, manually entered by
/// users, or system-generated will fail with a security error.
///
/// ## Throws
/// - [ArgumentError] if [recordIds] is empty
/// - [ArgumentError] if any record ID is [HealthRecordId.none]
///
/// ## Example
///
/// ```dart
/// // Delete specific step records
/// final request = HealthDataType.steps.deleteByIds([id1, id2, id3]);
/// await connector.deleteRecords(request);
/// ```
@sinceV2_0_0
@internalUse
@immutable
final class DeleteRecordsByIdsRequest<R extends HealthRecord>
    extends DeleteRecordsRequest<R> {
  /// Creates a request to delete specific health records by their IDs.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to delete
  /// - [recordIds]: List of unique record identifiers to delete
  ///
  /// ## Throws
  /// - [ArgumentError] if any record ID is [HealthRecordId.none]
  @internalUse
  factory DeleteRecordsByIdsRequest({
    required HealthDataType<R, MeasurementUnit> dataType,
    required List<HealthRecordId> recordIds,
  }) {
    require(
      recordIds.every((id) => id != HealthRecordId.none),
      'Record ID to delete cannot be HealthRecordId.none. '
      'Found invalid ID in `recordIds` list.',
    );

    return DeleteRecordsByIdsRequest._(
      dataType: dataType,
      recordIds: List.unmodifiable(recordIds),
    );
  }

  const DeleteRecordsByIdsRequest._({
    required super.dataType,
    required this.recordIds,
  });

  /// List of unique record identifiers to delete.
  ///
  /// All IDs must be valid (not [HealthRecordId.none]) and should come from
  /// previous write operations or read queries.
  final List<HealthRecordId> recordIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteRecordsByIdsRequest<R> &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          const ListEquality<HealthRecordId>().equals(
            recordIds,
            other.recordIds,
          );

  @override
  int get hashCode => dataType.hashCode ^ recordIds.hashCode;
}

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
/// users, or system-generated will fail with a security error.
///
/// ## Throws
/// - [ArgumentError] if [endTime] is before [startTime]
///
/// ## Example
///
/// ```dart
/// // Delete all step records from the last 7 days
/// final request = HealthDataType.steps.deleteInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// await connector.deleteRecords(request);
/// ```
@sinceV2_0_0
@internalUse
@immutable
final class DeleteRecordsInTimeRangeRequest<R extends HealthRecord>
    extends DeleteRecordsRequest<R> {
  /// Creates a request to delete records within a time range.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to delete
  /// - [startTime]: Inclusive start of the time range
  /// - [endTime]: Inclusive end of the time range
  ///
  /// ## Throws
  /// - [ArgumentError] if [endTime] is before [startTime]
  @internalUse
  factory DeleteRecordsInTimeRangeRequest({
    required HealthDataType<R, MeasurementUnit> dataType,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);

    return DeleteRecordsInTimeRangeRequest._(
      dataType: dataType,
      startTime: startTime,
      endTime: endTime,
    );
  }

  const DeleteRecordsInTimeRangeRequest._({
    required super.dataType,
    required this.startTime,
    required this.endTime,
  });

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
      other is DeleteRecordsInTimeRangeRequest<R> &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          startTime == other.startTime &&
          endTime == other.endTime;

  @override
  int get hashCode => dataType.hashCode ^ startTime.hashCode ^ endTime.hashCode;
}
