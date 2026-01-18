import 'package:collection/collection.dart' show ListEquality;
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/deletable_health_data_type.dart';
import 'package:health_connector_core/src/models/requests/request.dart';
import 'package:health_connector_core/src/utils/validation_utils.dart';
import 'package:meta/meta.dart';

/// Base sealed class for all delete records requests.
///
/// ## Data Ownership Restriction
///
/// Apps can only delete health records that they created.
/// Attempting to delete records created by other apps, manually entered by
/// users, or system-generated will fail with [AuthorizationException].
///
/// {@category Core API}
@sinceV2_0_0
@internalUse
@immutable
sealed class DeleteRecordsRequest extends Request {
  /// Creates a base delete records request.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to delete.
  DeleteRecordsRequest({required this.dataType}) {
    require(
      condition: dataType is DeletableHealthDataType,
      value: dataType,
      name: 'dataType',
      message: '$dataType is not deletable.',
    );
  }

  /// The type of health data to delete.
  final HealthDataType dataType;
}

/// Request to delete specific health records by their IDs.
///
/// This request type allows precise deletion of individual records when
/// you have their unique identifiers.
///
/// {@category Core API}
@sinceV3_2_0
@internalUse
@immutable
final class DeleteRecordsByIdsRequest extends DeleteRecordsRequest {
  /// Creates a request to delete specific health records by their IDs.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to delete
  /// - [recordIds]: List of unique record identifiers to delete
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if any record ID is [HealthRecordId.none]
  DeleteRecordsByIdsRequest({
    required super.dataType,
    required this.recordIds,
  }) {
    require(
      condition: recordIds.every((id) => id != HealthRecordId.none),
      value: recordIds,
      name: 'recordIds',
      message:
          'Record ID to delete cannot be HealthRecordId.none. '
          'Found invalid ID in `recordIds` list.',
    );
  }

  /// List of unique record identifiers to delete.
  ///
  /// All IDs must be valid (not [HealthRecordId.none]) and should come from
  /// previous write operations or read queries.
  final List<HealthRecordId> recordIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteRecordsByIdsRequest &&
          runtimeType == other.runtimeType &&
          dataType == other.dataType &&
          const ListEquality<HealthRecordId>().equals(
            recordIds,
            other.recordIds,
          );

  @override
  int get hashCode => dataType.hashCode ^ recordIds.hashCode;

  @override
  String toString() {
    return 'DeleteRecordsByIdsRequest('
        'dataType=$dataType, '
        'idsCount=${recordIds.length}'
        ')';
  }
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
