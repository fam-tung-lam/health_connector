import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show allTargets;
import 'package:meta/meta.dart' show immutable;

/// Marks health data types and records as read-only.
///
/// Health data types and records marked with this annotation cannot be written,
/// updated, or deleted through the Health Connector SDK. These types typically
/// represent data that is calculated or derived by the platform's health system
/// and is only available for reading.
///
/// ## Example
///
/// ```dart
/// @readOnly
/// final class WalkingSteadinessDataType extends HealthDataType
///     implements ReadableHealthDataType<WalkingSteadinessRecord> {
///   // ...
/// }
///
/// @readOnly
/// final class WalkingSteadinessRecord extends HealthRecord {
///   // ...
/// }
/// ```
@allTargets
@internalUse
@immutable
final class _ReadOnly {
  /// Creates a [readOnly] annotation.
  const _ReadOnly();
}

/// Annotation to mark health data types and records as read-only.
@internalUse
const readOnly = _ReadOnly();
