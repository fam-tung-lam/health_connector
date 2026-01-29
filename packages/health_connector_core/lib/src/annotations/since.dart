import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show allTargets;
import 'package:meta/meta.dart' show immutable;

/// Annotation to mark the SDK version when an API was first introduced.
///
/// This annotation helps developers understand when specific features became
/// available in the Health Connector SDK, enabling them to make informed
/// decisions about minimum SDK version requirements for their applications.
///
/// A `Since` annotation can be applied to:
/// - Library declarations
/// - Classes, enums, mixins, and other types
/// - Methods, functions, getters, and setters
/// - Fields and properties
/// - Optional parameters
///
/// ## Version Format
///
/// The version must follow semantic versioning (SemVer) format:
/// - **Major.Minor.Patch** (e.g., `3.2.0`)
/// - Pre-release versions are supported (e.g., `2.0.0-dev.1`)
///
/// ## Why Use This Annotation?
///
/// - **Track API Evolution**: Understand which features are available in
///   which SDK versions
/// - **Backward Compatibility**: Determine minimum SDK version requirements
///   for your app
/// - **Migration Planning**: Identify newer APIs when upgrading SDK
///   versions
/// - **Documentation**: Automatically generated docs show when each API was
///   added
///
/// ## Example
///
/// ```dart
/// // Feature added in version 3.2.0
/// @sinceV3_2_0
/// final class SleepingWristTemperatureDataType extends HealthDataType {
///   // ...
/// }
///
/// // Method added in version 2.1.0
/// @sinceV2_1_0
/// Future<void> aggregateData() async {
///   // ...
/// }
///
/// // Custom version annotation
/// @Since('1.2.0')
/// Future<void> customFeature() async {
///   // ...
/// }
/// ```
///
/// ## See also
///
/// - The SDK changelog for detailed version history
///
/// {@category Annotations}
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
///
/// {@category Annotations}
@internalUse
const sinceV1_0_0 = _Since('1.0.0');

/// Marks APIs added in version 1.1.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV1_1_0 = _Since('1.1.0');

/// Marks APIs added in version 1.2.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV1_2_0 = _Since('1.2.0');

/// Marks APIs added in version 1.3.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV1_3_0 = _Since('1.3.0');

/// Marks APIs added in version 1.4.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV1_4_0 = _Since('1.4.0');

/// Marks APIs added in version 2.0.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV2_0_0 = _Since('2.0.0');

/// Marks APIs added in version 2.1.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV2_1_0 = _Since('2.1.0');

/// Marks APIs added in version 2.2.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV2_2_0 = _Since('2.2.0');

/// Marks APIs added in version 2.3.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV2_3_0 = _Since('2.3.0');

/// Marks APIs added in version 2.3.1 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV2_3_1 = _Since('2.3.1');

/// Marks APIs added in version 2.3.2 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV2_3_2 = _Since('2.3.2');

/// Marks APIs added in version 2_4_0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV2_4_0 = _Since('2.4.0');

/// Marks APIs added in version 3.0.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV3_0_0 = _Since('3.0.0');

/// Marks APIs added in version 3.0.1 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV3_0_1 = _Since('3.0.1');

/// Marks APIs added in version 3.1.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV3_1_0 = _Since('3.1.0');

/// Marks APIs added in version 3.2.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV3_2_0 = _Since('3.2.0');

/// Marks APIs added in version 3.3.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV3_3_0 = _Since('3.3.0');

/// Marks APIs added in version 3.4.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV3_4_0 = _Since('3.4.0');

/// Marks APIs added in version 3.5.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV3_5_0 = _Since('3.5.0');

/// Marks APIs added in version 3.6.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV3_6_0 = _Since('3.6.0');

/// Marks APIs added in version 3.7.0 of the SDK.
///
/// {@category Annotations}
@internalUse
const sinceV3_7_0 = _Since('3.7.0');
