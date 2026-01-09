import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:meta/meta.dart' show immutable;

/// Defines the available fields by which health records can be sorted.
///
/// Currently supports time-based sorting only. Future versions may add
/// value-based sorting (e.g., by step count, heart rate magnitude).
@sinceV3_0_0
@internalUse
enum SortField {
  /// Sort by the record's timestamp.
  ///
  /// - For instant records (e.g., heart rate): Uses the `time` field
  /// - For interval records (e.g., steps, exercise): Uses the `startTime` field
  time,
}

/// Defines the direction of the sort operation.
@sinceV3_0_0
@internalUse
enum SortDirection {
  /// Ascending order (oldest to newest, smallest to largest).
  ///
  /// For time-based sorting: earlier timestamps appear first.
  ascending,

  /// Descending order (newest to oldest, largest to smallest).
  ///
  /// For time-based sorting: later timestamps appear first.
  descending,
}

/// Represents a sorting rule applied to a health record query.
///
/// Combines a [SortField] (what to sort by) with a [SortDirection]
/// (ascending or descending order).
///
/// ## Example
///
/// ```dart
/// // Sort by time, newest first (default)
/// final request = ReadRecordsInTimeRangeRequest(
///   dataType: HealthDataType.steps,
///   startTime: startTime,
///   endTime: endTime,
///   sortDescriptor: SortDescriptor.timeDescending,
/// );
///
/// // Sort by time, oldest first
/// final request = ReadRecordsInTimeRangeRequest(
///   dataType: HealthDataType.steps,
///   startTime: startTime,
///   endTime: endTime,
///   sortDescriptor: SortDescriptor.timeAscending,
/// );
/// ```
@sinceV3_0_0
@immutable
final class SortDescriptor {
  /// Creates a sort descriptor with the specified field and direction.
  const SortDescriptor._({
    required this.field,
    required this.direction,
  });

  /// The field to sort by.
  final SortField field;

  /// The direction to sort (ascending or descending).
  final SortDirection direction;

  /// Sort by time in descending order (newest first).
  ///
  /// - For instant records (e.g., heart rate): Uses the `time` field
  /// - For interval records (e.g., steps, exercise): Uses the `startTime` field
  static const SortDescriptor timeDescending = SortDescriptor._(
    field: SortField.time,
    direction: SortDirection.descending,
  );

  /// Sort by time in ascending order (oldest first).
  ///
  /// - For instant records (e.g., heart rate): Uses the `time` field
  /// - For interval records (e.g., steps, exercise): Uses the `startTime` field
  static const SortDescriptor timeAscending = SortDescriptor._(
    field: SortField.time,
    direction: SortDirection.ascending,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortDescriptor &&
          runtimeType == other.runtimeType &&
          field == other.field &&
          direction == other.direction;

  @override
  int get hashCode => Object.hash(field, direction);
}
