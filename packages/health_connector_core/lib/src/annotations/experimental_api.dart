import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show allTargets;
import 'package:meta/meta.dart' show immutable;

/// Annotation to mark APIs as experimental.
///
/// APIs marked with this annotation are not considered stable and might be
/// changed with breaking changes without bumping the major version of the SDK.
///
/// **Application developers should use APIs marked with [experimentalApi] with
/// caution**, as these are not considered part of the stable API surface
/// and can be changed or removed without adhering to strict semantic versioning
/// (i.e. breaking changes may occur in minor or patch releases).
///
/// ## Example
///
/// ```dart
/// @experimentalApi
/// class NewFeature {
///   // ...
/// }
/// ```
@allTargets
@internalUse
@immutable
final class _ExperimentalApi {
  /// Creates an [experimentalApi] annotation.
  const _ExperimentalApi();
}

/// Marks APIs as experimental and subject to change.
@internalUse
const experimentalApi = _ExperimentalApi();
