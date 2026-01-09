import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show memberAndTypeTargets;
import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:meta/meta.dart' show immutable;

/// Annotation used to mark APIs that are supported only on specific
/// health platforms.
///
/// Apply this annotation to methods, getters, classes, or other declarations
/// that are only available on certain [HealthPlatform]s.
///
/// When the annotated API is called on an unsupported platform, the annotated
/// API should throw a [UnsupportedOperationException].
///
/// ## Example
///
/// ```
/// @SupportedHealthPlatforms([HealthPlatform.android])
/// Future<void> getFeatureStatus() async {
///   if (_currentPlatform != HealthPlatform.android) {
///     throw UnsupportedOperationException(
///       'getFeatureStatus is not supported on $_currentPlatform.',
///     );
///   }
/// }
/// ```
@sinceV1_0_0
@memberAndTypeTargets
@immutable
final class _SupportedOn {
  /// Creates an annotation that restricts API usage to the specified platforms.
  ///
  /// The [platforms] list must contain at least one [HealthPlatform] value.
  const _SupportedOn(this.platforms);

  /// The list of health platforms on which this API is supported.
  ///
  /// If the API is invoked on a platform not in this list, an error
  /// will be thrown.
  final List<HealthPlatform> platforms;
}

/// Convenience annotation for APIs supported only on Android Health Connect.
const supportedOnHealthConnect = _SupportedOn([
  HealthPlatform.healthConnect,
]);

/// Convenience annotation for APIs supported only on iOS HealthKit.
const supportedOnAppleHealth = _SupportedOn([
  HealthPlatform.appleHealth,
]);
