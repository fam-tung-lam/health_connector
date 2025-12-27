import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show allTargets;
import 'package:meta/meta.dart' show immutable;

/// Marks APIs intended only for cross-package communication and implementation
/// details within the Health Connector SDK ecosystem.
///
/// **Application developers should not use or depend on APIs marked with
/// [internalUse]**, as these are not considered part of the public API surface
/// and can be changed without notice.
///
/// ### Example
/// ```
/// @internalUse
/// final class AggregateRequest {}
///
/// // ❌ Not intended: Do not instantiate AggregateRequest in apps
/// final request = AggregateRequest();
///
/// // Intended: Use the documented approach instead
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
