import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show allTargets;
import 'package:meta/meta.dart' show immutable, internal;

/// Annotation class marking the version where an API was added.
///
/// A `Since` annotation can be applied to a library declaration,
/// any public declaration in a library, or in a class, or to
/// an optional parameter.
///
/// ## Example
///
/// ```dart
/// @Since('1.2.0')
/// Future<void> newMethod() { ... }
/// ```
@sinceV1_0_0
@allTargets
@immutable
@internal
final class Since {
  /// Creates a `Since` annotation marking when an API was added.
  const Since(this.version);

  /// The version where this API was added.
  ///
  /// Must be a semantic version (e.g., `1.4.2`, `2.0.0-dev.1`)
  final String version;
}

const sinceV1_0_0 = Since('1.0.0');
const sinceV1_1_0 = Since('1.1.0');
const sinceV1_2_0 = Since('1.2.0');
const sinceV1_3_0 = Since('1.3.0');
