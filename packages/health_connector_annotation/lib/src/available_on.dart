import 'package:health_connector_annotation/src/meta_targets.dart'
    show memberAndTypeTargets;
import 'package:health_connector_annotation/src/since.dart' show sinceV1_0_0;
import 'package:health_connector_core/health_connector_core.dart'
    show HealthPlatform;
import 'package:meta/meta.dart' show immutable, internal;

/// Annotation to indicate an API is only implemented on specific platforms.
///
/// Use this when an API has shipped for a subset of platforms, but is not yet
/// available everywhere.
///
/// The annotated API should **not** throw unsupported exception:
/// - For fields/properties: the value will always be `null` or handled by the plugin.
/// - For methods: the call will be ignored, skipped, or handled by the plugin.
///
/// Callers can check the current platform to decide whether to rely on the
/// returned data or to present alternative UX.
///
/// ## Example
///
/// ```dart
/// @AvailableOn([HealthPlatform.android, HealthPlatform.appleHealth])
/// Future<Metadata> loadMetadata();
/// ```
@sinceV1_0_0
@memberAndTypeTargets
@internal
@immutable
final class AvailableOn {
  const AvailableOn(this.platforms);

  final List<HealthPlatform> platforms;
}

/// Convenience annotation for APIs available on Health Connect.
///
/// When used on unsupported platforms, fields/properties return `null` and
/// method calls are ignored, skipped, or handled by the plugin.
const availableOnHealthConnect = AvailableOn([
  HealthPlatform.healthConnect,
]);

/// Convenience annotation for APIs available on Apple Health (HealthKit).
///
/// When used on unsupported platforms, fields/properties return `null` and
/// method calls are ignored, skipped, or handled by the plugin.
const availableOnAppleHealth = AvailableOn([
  HealthPlatform.appleHealth,
]);
