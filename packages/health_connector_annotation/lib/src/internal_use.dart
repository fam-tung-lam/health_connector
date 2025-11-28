import 'package:health_connector_annotation/src/meta_targets.dart'
    show allTargets;
import 'package:meta/meta.dart' show immutable;

/// Marks APIs intended only for cross-package communication and implementation
/// details within the `health_connector` plugin ecosystem.
///
/// **Application developers should not use or depend on APIs marked with
/// [internalUse]**, as these are not considered part of the public API surface.
/// Rely only on documented public APIs from the main plugin package.
///
/// ### Example
/// ```
/// @internalUse
/// final class AggregateRequest {}
///
/// // ❌ Not intended: Do not instantiate AggregateRequest in apps
/// final request = AggregateRequest();
///
/// // ✅ Intended: Use the documented approach instead
/// final sumAggregateRequest = HealthDataType.steps.aggregateSum(
///   startTime: DateTime.now().startOfDay,
///   endTime: DateTime.now(),
/// );
/// ```
@allTargets
@immutable
final class _InternalUse {
  /// Creates an [internalUse] annotation.
  const _InternalUse();
}

/// Annotation to mark APIs for internal plugin ecosystem use only.
const internalUse = _InternalUse();
