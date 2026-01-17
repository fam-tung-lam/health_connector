import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show allTargets;
import 'package:meta/meta.dart' show immutable;

/// Annotation class marking the version where an API was added.
///
/// A `Since` annotation can be applied to a library declaration, any public
/// declaration in a library, or in a class, or to an optional parameter.
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
final class _Since {
  /// Creates a `Since` annotation marking when an API was added.
  const _Since(this.version);

  /// The version where this API was added.
  ///
  /// Must be a semantic version (e.g., `1.4.2`, `2.0.0-dev.1`)
  final String version;
}

/// Marks APIs added in version 1.0.0 of the SDK.
const sinceV1_0_0 = _Since('1.0.0');

/// Marks APIs added in version 1.1.0 of the SDK.
const sinceV1_1_0 = _Since('1.1.0');

/// Marks APIs added in version 1.2.0 of the SDK.
const sinceV1_2_0 = _Since('1.2.0');

/// Marks APIs added in version 1.3.0 of the SDK.
const sinceV1_3_0 = _Since('1.3.0');

/// Marks APIs added in version 1.4.0 of the SDK.
const sinceV1_4_0 = _Since('1.4.0');

/// Marks APIs added in version 2.0.0 of the SDK.
const sinceV2_0_0 = _Since('2.0.0');

/// Marks APIs added in version 2.1.0 of the SDK.
const sinceV2_1_0 = _Since('2.1.0');

/// Marks APIs added in version 2.2.0 of the SDK.
const sinceV2_2_0 = _Since('2.2.0');

/// Marks APIs added in version 2.3.0 of the SDK.
const sinceV2_3_0 = _Since('2.3.0');

/// Marks APIs added in version 2.3.1 of the SDK.
const sinceV2_3_1 = _Since('2.3.1');

/// Marks APIs added in version 2.3.2 of the SDK.
const sinceV2_3_2 = _Since('2.3.2');

/// Marks APIs added in version 2_4_0 of the SDK.
const sinceV2_4_0 = _Since('2.4.0');

/// Marks APIs added in version 3.0.0 of the SDK.
const sinceV3_0_0 = _Since('3.0.0');

/// Marks APIs added in version 3.0.1 of the SDK.
const sinceV3_0_1 = _Since('3.0.1');

/// Marks APIs added in version 3.1.0 of the SDK.
const sinceV3_1_0 = _Since('3.1.0');

/// Marks APIs added in version 3.2.0 of the SDK.
const sinceV3_2_0 = _Since('3.2.0');
