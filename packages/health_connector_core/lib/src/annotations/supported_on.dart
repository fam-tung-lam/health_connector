import 'package:health_connector_core/health_connector_core.dart'
    show HealthPlatform, HealthConnectorErrorCode, HealthConnectorException;
import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show memberAndTypeTargets;
import 'package:health_connector_core/src/annotations/since.dart'
    show sinceV1_0_0;
import 'package:meta/meta.dart' show immutable, internal;

/// Annotation used to mark APIs that are supported only on specific
/// health platforms.
///
/// Apply this annotation to methods, getters, classes, or other declarations
/// that are only available on certain [HealthPlatform]s.
///
/// When the annotated API is called on an unsupported platform, the annotated
/// API should throw a [HealthConnectorException] with
/// [HealthConnectorErrorCode.unsupportedOperation].
///
/// ## Example
///
/// ```
/// @SupportedHealthPlatforms([HealthPlatform.android])
/// Future<void> getFeatureStatus() async {
///   if (_currentPlatform != HealthPlatform.android) {
///     // Throw an error
///   }
/// }
/// ```
@sinceV1_0_0
@memberAndTypeTargets
@internal
@immutable
final class SupportedOn {
  /// Creates an annotation that restricts API usage to the specified platforms.
  ///
  /// The [platforms] list must contain at least one [HealthPlatform] value.
  const SupportedOn(this.platforms);

  /// The list of health platforms on which this API is supported.
  ///
  /// If the API is invoked on a platform not in this list, an error
  /// will be thrown.
  final List<HealthPlatform> platforms;
}

/// Convenience annotation for APIs supported only on Health Connect.
const supportedOnHealthConnect = SupportedOn([
  HealthPlatform.healthConnect,
]);

/// Convenience annotation for APIs supported only on Apple Health (HealthKit).
const supportedOnAppleHealth = SupportedOn([
  HealthPlatform.appleHealth,
]);
