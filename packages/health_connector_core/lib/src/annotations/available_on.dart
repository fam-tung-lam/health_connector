import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show memberAndTypeTargets;
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:meta/meta.dart' show immutable;

/// Annotation to mark APIs that are available only on specific health platforms,
/// returning `null` on unsupported platforms rather than throwing an error.
///
/// This annotation is distinct from [_SupportedOn]: use `@AvailableOn` when
/// an API is present on all platforms but yields meaningful data only on the
/// specified platform (the field is non-null only there). Use `@SupportedOn`
/// when calling the API on an unsupported platform must result in an
/// [UnsupportedOperationException].
///
/// ## Behavior
///
/// When a field or getter marked with `@AvailableOn` is accessed on a platform
/// that is not listed, it returns `null`. The nullable type on the annotated
/// member communicates this to callers at compile time.
///
/// ## Target Elements
///
/// This annotation can be applied to:
/// - Classes (especially health data types)
/// - Methods and getters
/// - Fields and properties
/// - Enum values
/// - Parameters
///
/// ## Example
///
/// ```dart
/// // Field that is populated only on Android Health Connect; null on iOS
/// @availableOnHealthConnect
/// final Mass? weight;
/// ```
///
/// ## See also
///
/// - [_SupportedOn], which throws when the API is called on an unsupported
///   platform
/// - [HealthPlatform], which defines the available health platforms
///
/// {@category Annotations}
@sinceV3_9_0
@memberAndTypeTargets
@immutable
final class _AvailableOn {
  /// Creates an annotation that documents which platform provides a non-null
  /// value for the annotated member.
  const _AvailableOn({
    required this.platform,
    this.osVersion,
  });

  /// The health platform on which this API returns a non-null value.
  final HealthPlatform platform;

  /// The minimum OS version required for this API to return a non-null value.
  ///
  /// If not specified, the API is available on all OS versions of the platform.
  final String? osVersion;
}

/// Convenience annotation for fields available only on Android Health Connect.
///
/// The annotated member returns `null` on other platforms (e.g., iOS HealthKit).
///
/// {@category Annotations}
@internalUse
const availableOnHealthConnect = _AvailableOn(
  platform: HealthPlatform.healthConnect,
);
