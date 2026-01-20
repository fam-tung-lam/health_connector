import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/annotations/meta_targets.dart';
import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:meta/meta.dart' show immutable;

/// Annotation to mark health data types and records as read-only.
///
/// APIs marked with this annotation represent health data that can only be
/// read but cannot be written, updated, or deleted through the Health Connector
/// SDK. Read-only data types typically represent metrics that are automatically
/// calculated, computed, or derived by the underlying health platform and are
/// not intended for direct modification by third-party applications.
///
/// ## Why Are Some Health Data Types Read-Only?
///
/// Certain health metrics are **computed by the platform** based on other
/// health data sources or device sensors. For example:
/// - **Walking Steadiness** (iOS): Derived from accelerometer and motion data
/// - **Apple Move Time**: Calculated based on activity patterns
/// - **Exercise Time**: Aggregated from workout sessions and activity data
///
/// Because these values are system-computed, platforms do not allow apps to
/// write or modify them directly to preserve data integrity and accuracy.
///
/// ## Behavior
///
/// When attempting to write, update, or delete a read-only health data type
/// or record through APIs like `writeRecord()`, `updateRecord()`, or
/// `deleteRecords()`, the SDK **must** throw an
/// [UnsupportedOperationException] with a clear error message indicating
/// that the operation is not supported for read-only data.
///
/// ## Example
///
/// ```dart
/// // Marking a health data type as read-only
/// @readOnly
/// final class WalkingSteadinessDataType extends HealthDataType
///     implements ReadableHealthDataType<WalkingSteadinessRecord> {
///   // This type only implements ReadableHealthDataType
///   // NOT WriteableHealthDataType or DeletableHealthDataType
/// }
///
/// // Marking the corresponding record as read-only
/// @readOnly
/// final class WalkingSteadinessRecord extends HealthRecord {
///   // This record can only be obtained through read operations
/// }
///
/// // Attempting to write a read-only record will throw an error:
/// try {
///   await healthConnector.writeRecord(walkingSteadinessRecord);
/// } catch (e) {
///   // Throws: UnsupportedOperationException
///   print(e); // "Writing WalkingSteadinessRecord is not supported"
/// }
/// ```
///
/// ## See also
///
/// - [ReadableHealthDataType], which defines the interface for reading health
///   data.
/// - [WriteableHealthDataType] and [DeletableHealthDataType], which read-only
///   types do **not** implement.
///
/// {@category Annotations}
@allTargets
@internalUse
@immutable
final class _ReadOnly {
  /// Creates a [readOnly] annotation.
  const _ReadOnly();
}

/// Annotation to mark health data types and records as read-only.
///
/// {@category Annotations}
@internalUse
const readOnly = _ReadOnly();
